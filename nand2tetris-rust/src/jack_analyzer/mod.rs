use std::error::Error;
use std::path::{Path, PathBuf};

use crate::jack_analyzer::analyzer::Analyzer;

mod analyzer;
mod tokenizer;
mod buffered_tokenizer;

pub fn run(input_path: &str, output_directory: &str) -> Result<(), Box<dyn Error>> {
    let input_paths = load_input_paths(Path::new(input_path))?;

    for input_path in input_paths {
        println!(">> {}", input_path);
        let output_path = generate_output_path(&input_path, output_directory);
        let mut analyzer = Analyzer::new(&input_path, &output_path)?;
        analyzer.analyze()?;
    }

    Ok(())
}

fn generate_output_path(input_path: &str, output_directory: &str) -> PathBuf {
    let filename = Path::new(input_path)
        .file_name()
        .unwrap()
        .to_string_lossy()
        .replacen(".jack", ".xml", 1);
    Path::new(output_directory).join(filename)
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
