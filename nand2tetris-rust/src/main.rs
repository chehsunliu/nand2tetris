use clap::{AppSettings, Parser, Subcommand};
use nand2tetris_rust::vm_translator;
use std::error::Error;

#[derive(Subcommand)]
enum Command {
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
        Command::VmTranslator { input_path } => vm_translator::run(input_path),
    }
}
