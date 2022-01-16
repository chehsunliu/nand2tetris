use std::error::Error;

use clap::{AppSettings, Parser, Subcommand};

use nand2tetris_rust::{jack_analyzer, vm_translator};

#[derive(Subcommand)]
enum Command {
    #[clap(setting(AppSettings::ArgRequiredElseHelp))]
    JackAnalyzer {
        #[clap(long, required = true)]
        input_path: String,
        #[clap(long, required = true)]
        output_directory: String,
    },

    #[clap(setting(AppSettings::ArgRequiredElseHelp))]
    VmTranslator {
        #[clap(long, required = true)]
        input_path: String,
    },
}

#[derive(Parser)]
struct Cli {
    #[clap(subcommand)]
    command: Command,
}

fn main() -> Result<(), Box<dyn Error>> {
    let args = Cli::parse();

    match &args.command {
        Command::JackAnalyzer {
            input_path,
            output_directory,
        } => jack_analyzer::run(input_path, output_directory),
        Command::VmTranslator { input_path } => vm_translator::run(input_path),
    }
}
