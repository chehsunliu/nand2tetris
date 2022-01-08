use std::error::Error;
use std::fs::File;
use std::io::{BufRead, BufReader, Lines};

use crate::vm_translator::command::Command;

pub struct Parser {
    lines: Lines<BufReader<File>>,
}

impl Parser {
    pub fn new(input_path: &str) -> Result<Parser, Box<dyn Error>> {
        let f = File::open(input_path)?;
        Ok(Parser {
            lines: BufReader::new(f).lines(),
        })
    }
}

impl Iterator for Parser {
    type Item = Command;

    fn next(&mut self) -> Option<Self::Item> {
        loop {
            let line = self.lines.next()?.unwrap().trim().to_string();

            if line.is_empty() || line.starts_with("//") {
                continue;
            }

            let line_without_comments: Vec<&str> = line.splitn(2, "//").collect();
            let cmd = line_without_comments[0].trim_end().to_string();

            return Some(Command::new(&cmd));
        }
    }
}
