use std::fs::File;
use std::io;
use std::io::Write;
use std::path::Path;

use crate::vm_translator::command::Command;
use crate::vm_translator::meta::Meta;

pub struct Translator {
    f: File,
    meta: Meta,
}

impl Translator {
    pub fn new(output_path: &str) -> io::Result<Translator> {
        let translator = Translator {
            f: File::create(&output_path)?,
            meta: Meta::new(),
        };
        Ok(translator)
    }

    pub fn set_vm_name(&mut self, input_path: &str) {
        let p = Path::new(input_path);
        let filename = p.file_name().unwrap().to_str().unwrap();
        let ext = p.extension().unwrap().to_str().unwrap();
        let name = filename.trim_end_matches(ext).trim_end_matches(".");

        self.meta.set_vm_name(name);
    }

    pub fn write_init(&mut self) -> std::io::Result<usize> {
        let output = format!(
            "\
@256
D=A
@SP
M=D

{}

",
            self.translate_call("Sys.init", 0)
        );
        self.f.write(output.as_bytes())
    }

    pub fn write(&mut self, cmd: &Command) -> std::io::Result<usize> {
        let output = match cmd {
            Command::Add => self.translate_binary_operation("M=D+M"),
            Command::Sub => self.translate_binary_operation("M=M-D"),
            Command::And => self.translate_binary_operation("M=D&M"),
            Command::Or => self.translate_binary_operation("M=D|M"),
            Command::Neg => self.translate_unary_operation("M=-M"),
            Command::Not => self.translate_unary_operation("M=!M"),
            Command::Eq => self.translate_comparison("JEQ"),
            Command::Lt => self.translate_comparison("JGT"),
            Command::Gt => self.translate_comparison("JLT"),
            Command::Push { segment, index } => self.translate_push(segment, *index),
            Command::Pop { segment, index } => self.translate_pop(segment, *index),
            Command::Label(label) => self.translate_label(label),
            Command::IfGoto(label) => self.translate_if_goto(label),
            Command::Goto(label) => self.translate_goto(label),
            Command::Call { name, args } => self.translate_call(name, *args),
            Command::Function { name, locals } => self.translate_function(name, *locals),
            Command::Return => self.translate_return(),
        };
        let output = format!("// {:?}\n{}\n\n", cmd, output);

        self.f.write(output.as_bytes())
    }
}

impl Translator {
    fn translate_binary_operation(&self, operation: &str) -> String {
        format!(
            "\
@SP
A=M
A=A-1
D=M
A=A-1
{}
@SP
M=M-1",
            operation
        )
    }

    fn translate_unary_operation(&self, operation: &str) -> String {
        format!(
            "\
@SP
A=M
A=A-1
{}",
            operation
        )
    }

    fn translate_comparison(&mut self, operation: &str) -> String {
        format!(
            "\
@SP
A=M
A=A-1
D=M
A=A-1
D=D-M
@{label_true}
D;{operation}

@SP
A=M
A=A-1
A=A-1
M=0
@{label_move_sp_up}
0;JMP

({label_true})
@SP
A=M
A=A-1
A=A-1
M=-1

({label_move_sp_up})
@SP
M=M-1",
            operation = operation,
            label_true = self.meta.generate_implicit_label(),
            label_move_sp_up = self.meta.generate_implicit_label(),
        )
    }

    fn translate_label(&self, label: &str) -> String {
        format!("({})", self.meta.generate_label(label))
    }

    fn translate_if_goto(&self, label: &str) -> String {
        format!(
            "\
@SP
M=M-1
A=M
D=M
@{}
D;JNE",
            self.meta.generate_label(label)
        )
    }

    fn translate_goto(&self, label: &str) -> String {
        format!(
            "\
@{}
0;JMP",
            self.meta.generate_label(label)
        )
    }
}

impl Translator {
    fn translate_push(&self, segment: &str, index: i32) -> String {
        match segment {
            "constant" => self.translate_push_constant(index),
            "local" => self.translate_push_local("LCL", index),
            "argument" => self.translate_push_local("ARG", index),
            "this" => self.translate_push_local("THIS", index),
            "that" => self.translate_push_local("THAT", index),
            "pointer" => self.translate_push_pointer(if index == 0 { "THIS" } else { "THAT" }),
            "static" => self.translate_push_pointer(&self.meta.generate_static_address(index)),
            "temp" => self.translate_push_temp(index),
            _ => panic!("Unknown push command: {}", segment),
        }
    }

    fn translate_push_constant(&self, index: i32) -> String {
        format!(
            "\
@{}
D=A
@SP
A=M
M=D
@SP
M=M+1",
            index,
        )
    }

    fn translate_push_local(&self, address: &str, index: i32) -> String {
        format!(
            "\
@{index}
D=A
@{address}
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1",
            address = address,
            index = index,
        )
    }

    fn translate_push_pointer(&self, segment: &str) -> String {
        format!(
            "\
@{}
D=M
@SP
A=M
M=D
@SP
M=M+1",
            segment
        )
    }

    fn translate_push_temp(&self, index: i32) -> String {
        let segment = format!("R{}", 5 + index);
        self.translate_push_pointer(&segment)
    }
}

impl Translator {
    fn translate_pop(&self, segment: &str, index: i32) -> String {
        match segment {
            "local" => self.translate_pop_local("LCL", index),
            "argument" => self.translate_pop_local("ARG", index),
            "this" => self.translate_pop_local("THIS", index),
            "that" => self.translate_pop_local("THAT", index),
            "pointer" => self.translate_pop_pointer(if index == 0 { "THIS" } else { "THAT" }),
            "static" => self.translate_pop_pointer(&self.meta.generate_static_address(index)),
            "temp" => self.translate_pop_temp(index),
            _ => panic!("Unknown pop command: {}", segment),
        }
    }

    fn translate_pop_local(&self, segment: &str, index: i32) -> String {
        format!(
            "\
@{index}
D=A
@{segment}
D=D+M
@SP
A=M
M=D
@SP
M=M-1
A=M
D=M
A=A+1
A=M
M=D",
            index = index,
            segment = segment,
        )
    }

    fn translate_pop_temp(&self, index: i32) -> String {
        format!(
            "\
@{}
D=A
@SP
A=M
M=D
@SP
M=M-1
A=M
D=M
A=A+1
A=M
M=D",
            5 + index,
        )
    }

    fn translate_pop_pointer(&self, segment: &str) -> String {
        format!(
            "\
@SP
M=M-1
A=M
D=M
@{}
M=D",
            segment,
        )
    }
}

impl Translator {
    fn translate_call(&mut self, name: &str, args: i32) -> String {
        let return_address = self.meta.generate_return_address(name);
        format!(
            "\
@{return_address}
D=A
@SP
A=M
M=D
@SP
M=M+1

@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1

@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1

@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1

@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1

@SP
D=M
@{offset}
D=D-A
@ARG
M=D

@SP
D=M
@LCL
M=D

@{function_name}
0;JMP

({return_address})",
            function_name = name,
            offset = 5 + args,
            return_address = return_address,
        )
    }

    fn translate_function(&mut self, name: &str, locals: i32) -> String {
        self.meta.set_function_name(name);

        let mut out = format!("({})\n", name);
        for i in 0..locals {
            out.push_str(&self.translate_push_constant(0));
            if i != locals - 1 {
                out.push('\n');
            }
        }

        out
    }

    fn translate_return(&self) -> String {
        "\
@LCL  // Backup M[LCL] to M[frame]
D=M
@frame
M=D

@SP  // Store return value to M[M[ARG]]
A=M-1
D=M
@ARG
A=M
M=D

@ARG  // M[SP] = M[ARG] + 1
D=M+1
@SP
M=D

@frame  // Restore THAT
AM=M-1
D=M
@THAT
M=D

@frame  // Restore THIS
AM=M-1
D=M
@THIS
M=D

@frame  // Restore ARG
AM=M-1
D=M
@ARG
M=D

@frame  // Restore LCL
AM=M-1
D=M
@LCL
M=D

@frame  // Go to RET
A=M-1
A=M
0;JMP"
            .to_string()
    }
}
