use std::error::Error;
use std::path::Path;

use crate::vm_translator::parser::Parser;
use crate::vm_translator::translator::Translator;

mod command;
mod meta;
mod parser;
mod translator;

fn process_paths(input_path: &str) -> Result<(Vec<String>, String), Box<dyn Error>> {
    let p = Path::new(input_path);
    if !p.exists() {
        Err(format!("file {} does not exist", input_path))?;
    }

    if p.is_file() {
        if !input_path.ends_with(".vm") {
            Err("The input path should end with '.vm'")?;
        }

        let output_path = input_path.trim_end_matches(".vm").to_string() + ".asm";
        let input_paths = vec![input_path.to_string()];

        Ok((input_paths, output_path))
    } else {
        let folder_path = Path::new(input_path);
        let output_path = folder_path
            .join(folder_path.file_name().unwrap())
            .to_str()
            .unwrap()
            .to_string()
            + ".asm";

        let input_paths: Vec<String> = folder_path
            .read_dir()?
            .map(|entry| entry.unwrap().path().to_str().unwrap().to_string())
            .filter(|s| s.ends_with(".vm"))
            .collect();

        Ok((input_paths, output_path))
    }
}

pub fn run(input_path: &str) -> Result<(), Box<dyn Error>> {
    let (input_paths, output_path) = process_paths(input_path)?;

    let mut translator = Translator::new(&output_path)?;

    if input_paths.len() > 1 {
        translator.write_init()?;
    }

    for input_path in input_paths.iter() {
        let parser = Parser::new(input_path)?;
        translator.set_vm_name(input_path);

        for cmd in parser {
            translator.write(&cmd)?;
        }
    }

    Ok(())
}
