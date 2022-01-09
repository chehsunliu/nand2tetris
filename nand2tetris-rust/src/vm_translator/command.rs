#[derive(Debug)]
pub enum Command {
    Push { segment: String, index: i32 },
    Pop { segment: String, index: i32 },
    Eq,
    Lt,
    Gt,
    Add,
    Sub,
    Neg,
    And,
    Or,
    Not,
    Label(String),
    IfGoto(String),
    Goto(String),
    Function { name: String, locals: i32 },
    Return,
}

impl Command {
    pub fn new(cmd: &str) -> Command {
        let tokens: Vec<&str> = cmd.split(" ").collect();

        match tokens[0] {
            "eq" => Command::Eq,
            "lt" => Command::Lt,
            "gt" => Command::Gt,
            "add" => Command::Add,
            "sub" => Command::Sub,
            "neg" => Command::Neg,
            "and" => Command::And,
            "or" => Command::Or,
            "not" => Command::Not,
            "push" => Command::Push {
                segment: tokens[1].to_string(),
                index: tokens[2].parse::<i32>().unwrap(),
            },
            "pop" => Command::Pop {
                segment: tokens[1].to_string(),
                index: tokens[2].parse::<i32>().unwrap(),
            },
            "label" => Command::Label(tokens[1].to_string()),
            "if-goto" => Command::IfGoto(tokens[1].to_string()),
            "goto" => Command::Goto(tokens[1].to_string()),
            "function" => Command::Function {
                name: tokens[1].to_string(),
                locals: tokens[2].parse().unwrap(),
            },
            "return" => Command::Return,
            _ => panic!("Unknown command: {}", cmd),
        }
    }
}
