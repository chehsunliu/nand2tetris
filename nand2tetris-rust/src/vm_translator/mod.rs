use std::error::Error;

use crate::vm_translator::parser::Parser;
use crate::vm_translator::translator::Translator;

mod command;
mod label;
mod parser;
mod translator;

pub fn run(input_path: &str) -> Result<(), Box<dyn Error>> {
    if !input_path.ends_with(".vm") {
        Err("The input path should end with '.vm'")?;
    }

    let output_path = input_path.trim_end_matches(".vm").to_string() + ".asm";

    let parser = Parser::new(input_path)?;
    let mut translator = Translator::new(&output_path)?;

    for cmd in parser {
        translator.write(&cmd)?;
    }

    Ok(())
}
