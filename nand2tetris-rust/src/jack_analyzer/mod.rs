use std::error::Error;
use std::path::Path;
use crate::jack_analyzer::tokenizer::Tokenizer;

mod tokenizer;

pub fn run(input_path: &str, output_directory: &str) -> Result<(), Box<dyn Error>> {
    let input_paths = load_input_paths(Path::new(input_path))?;

    for input_path in input_paths {
        println!(">> {}", input_path);
        for (l, token) in Tokenizer::new(&input_path)?.enumerate() {
            println!("{}:{}", l, token);
        }
    }

    Ok(())
}

fn load_input_paths(source: &Path) -> Result<Vec<String>, Box<dyn Error>> {
    if source.is_file() {
        return Ok(vec![source.to_str().unwrap().to_string()]);
    }

    Ok(source
        .read_dir()?
        .map(|entry| entry.unwrap().path().to_str().unwrap().to_string())
        .filter(|f| f.ends_with(".jack"))
        .collect())
}
