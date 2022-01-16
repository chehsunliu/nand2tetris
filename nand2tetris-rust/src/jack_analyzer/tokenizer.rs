use std::error::Error;
use std::fmt::{Display, Formatter};

pub enum Token {
    Keyword(String),
    Symbol(char),
    Identifier(String),
    IntegerConstant(i32),
    StringConstant(String),
}

impl Display for Token {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match self {
            Token::Keyword(s) => write!(f, "<keyword> {} </keyword>", s),
            Token::Symbol(c) => write!(f, "<symbol> {} </symbol>", c),
            Token::Identifier(s) => write!(f, "<identifier> {} </identifier>", s),
            Token::IntegerConstant(i) => write!(f, "<integerConstant> {} </integerConstant>", i),
            Token::StringConstant(s) => write!(f, "<stringConstant> {} </stringConstant>", s),
        }
    }
}

enum ParsingState {
    Initial,
    ConsumingChars,
    ConsumingNumbers,
    HasMetQuote,
    HasMetSlash,
    OneLineComment,
    BlockComment,
    BlockCommentCanEnd,
}

pub struct Tokenizer {
    content: Vec<u8>,
    index: usize,
}

impl Tokenizer {
    pub fn new(input_path: &str) -> Result<Tokenizer, Box<dyn Error>> {
        let content = std::fs::read(input_path)?;
        Ok(Tokenizer { content, index: 0 })
    }

    fn parse_symbol(&self, i: usize) -> Token {
        Token::Symbol(self.content[i] as char)
    }

    fn parse_chars(&self, i: usize, j: usize) -> Token {
        let s = String::from_utf8_lossy(&self.content[i..j]);
        match s.as_ref() {
            "class" | "method" | "function" | "constructor" | "int" | "boolean" | "char"
            | "void" | "var" | "static" | "field" | "let" | "do" | "if" | "else" | "while"
            | "return" | "true" | "false" | "null" | "this" => Token::Keyword(s.to_string()),
            _ => Token::Identifier(s.to_string()),
        }
    }

    fn parse_integer_constant(&self, i: usize, j: usize) -> Token {
        let s = String::from_utf8_lossy(&self.content[i..j]);
        Token::IntegerConstant(s.parse().unwrap())
    }

    fn parse_string_content(&self, i: usize, j: usize) -> Token {
        let s = String::from_utf8_lossy(&self.content[i..j]);
        Token::StringConstant(s.to_string())
    }
}

impl Iterator for Tokenizer {
    type Item = Token;

    fn next(&mut self) -> Option<Self::Item> {
        let mut state = ParsingState::Initial;
        let mut j = self.index;

        while let Some(c) = self.content.get(j) {
            let c = *c as char;

            state = match state {
                ParsingState::Initial => match c {
                    ' ' | '\n' => {
                        self.index += 1;
                        state
                    }
                    '/' => ParsingState::HasMetSlash,
                    '0'..='9' => ParsingState::ConsumingNumbers,
                    'a'..='z' | 'A'..='Z' | '_' => ParsingState::ConsumingChars,
                    '(' | ')' | '[' | ']' | '{' | '}' | ',' | ';' | '=' | '.' | '+' | '-' | '*'
                    | '&' | '|' | '~' | '<' | '>' => {
                        let token = self.parse_symbol(self.index);
                        self.index += 1;
                        return Some(token);
                    }
                    '"' => {
                        self.index += 1;
                        ParsingState::HasMetQuote
                    }
                    _ => {
                        self.index += 1;
                        state
                    }
                },
                ParsingState::ConsumingChars => match c {
                    'a'..='z' | 'A'..='Z' | '0'..='9' | '_' => state,
                    _ => {
                        let token = self.parse_chars(self.index, j);
                        self.index = j;
                        return Some(token);
                    }
                },
                ParsingState::ConsumingNumbers => match c {
                    '0'..='9' => state,
                    _ => {
                        let token = self.parse_integer_constant(self.index, j);
                        self.index = j;
                        return Some(token);
                    }
                },
                ParsingState::HasMetQuote => match c {
                    '"' => {
                        let token = self.parse_string_content(self.index, j);
                        self.index = j + 1;
                        return Some(token);
                    }
                    _ => state,
                },
                ParsingState::HasMetSlash => match c {
                    '/' => ParsingState::OneLineComment,
                    '*' => ParsingState::BlockComment,
                    _ => {
                        let token = self.parse_symbol(self.index);
                        self.index = j + 1;
                        return Some(token);
                    }
                },
                ParsingState::OneLineComment => match c {
                    '\n' => {
                        self.index = j + 1;
                        ParsingState::Initial
                    }
                    _ => state,
                },
                ParsingState::BlockComment => match c {
                    '*' => ParsingState::BlockCommentCanEnd,
                    _ => state,
                },
                ParsingState::BlockCommentCanEnd => match c {
                    '/' => {
                        self.index = j + 1;
                        ParsingState::Initial
                    }
                    _ => state,
                },
            };

            j += 1;
        }

        None
    }
}
