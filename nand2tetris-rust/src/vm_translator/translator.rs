use std::fs::File;
use std::io;
use std::io::Write;
use std::path::Path;

use crate::vm_translator::command::Command;
use crate::vm_translator::label::Label;

pub struct Translator {
    f: File,
    static_prefix: String,
    label: Label,
}

impl Translator {
    pub fn new(output_path: &str) -> io::Result<Translator> {
        let p = Path::new(output_path);
        let filename = p.file_name().unwrap().to_str().unwrap();
        let ext = p.extension().unwrap().to_str().unwrap();
        let static_prefix = filename.trim_end_matches(ext).to_string();

        let translator = Translator {
            f: File::create(&output_path)?,
            static_prefix,
            label: Label::new(),
        };
        Ok(translator)
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

    fn translate_comparison(&self, operation: &str) -> String {
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
            label_true = self.label.get(),
            label_move_sp_up = self.label.get(),
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
            "static" => self.translate_push_pointer(&format!("{}{}", self.static_prefix, index)),
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
            "static" => self.translate_pop_pointer(&format!("{}{}", self.static_prefix, index)),
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
