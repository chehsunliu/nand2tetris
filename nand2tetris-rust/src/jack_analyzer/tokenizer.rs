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

struct Content {
    content: Vec<u8>,
    base_index: usize,
    current_index: usize,
}

impl Content {
    fn new(content: Vec<u8>) -> Content {
        Content {
            content,
            base_index: 0,
            current_index: 0,
        }
    }

    fn char(&self) -> Option<char> {
        self.content.get(self.current_index).map(|u| *u as char)
    }

    fn advance(&mut self) {
        self.current_index += 1;
    }

    fn reset(&mut self) {
        self.current_index = self.base_index;
    }

    fn cut_char(&mut self) -> char {
        let c = self.content[self.base_index] as char;
        self.base_index += 1;
        c
    }

    fn cut_word(&mut self) -> String {
        let s = String::from_utf8_lossy(&self.content[self.base_index..self.current_index]);
        self.base_index = self.current_index;
        s.to_string()
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
    End(Token),
}

pub struct Tokenizer {
    content: Content,
}

impl Tokenizer {
    pub fn new(input_path: &str) -> Result<Tokenizer, Box<dyn Error>> {
        let content = std::fs::read(input_path)?;
        Ok(Tokenizer {
            content: Content::new(content),
        })
    }

    fn handle_initial(&mut self, state: ParsingState) -> ParsingState {
        match self.content.char().unwrap() {
            ' ' | '\n' => {
                self.content.cut_char();
                state
            }
            '/' => ParsingState::HasMetSlash,
            '0'..='9' => ParsingState::ConsumingNumbers,
            'a'..='z' | 'A'..='Z' | '_' => ParsingState::ConsumingChars,
            '(' | ')' | '[' | ']' | '{' | '}' | ',' | ';' | '=' | '.' | '+' | '-' | '*' | '&'
            | '|' | '~' | '<' | '>' => {
                let token = Token::Symbol(self.content.cut_char());
                return ParsingState::End(token);
            }
            '"' => {
                self.content.cut_char();
                ParsingState::HasMetQuote
            }
            _ => {
                self.content.cut_char();
                state
            }
        }
    }

    fn handle_consuming_chars(&mut self, state: ParsingState) -> ParsingState {
        match self.content.char().unwrap() {
            'a'..='z' | 'A'..='Z' | '0'..='9' | '_' => state,
            _ => {
                let s = self.content.cut_word();
                let token = match s.as_ref() {
                    "class" | "method" | "function" | "constructor" | "int" | "boolean"
                    | "char" | "void" | "var" | "static" | "field" | "let" | "do" | "if"
                    | "else" | "while" | "return" | "true" | "false" | "null" | "this" => {
                        Token::Keyword(s.to_string())
                    }
                    _ => Token::Identifier(s.to_string()),
                };
                return ParsingState::End(token);
            }
        }
    }

    fn handle_consuming_numbers(&mut self, state: ParsingState) -> ParsingState {
        match self.content.char().unwrap() {
            '0'..='9' => state,
            _ => {
                let s = self.content.cut_word();
                let token = Token::IntegerConstant(s.parse().unwrap());
                return ParsingState::End(token);
            }
        }
    }

    fn handle_has_met_quote(&mut self, state: ParsingState) -> ParsingState {
        match self.content.char().unwrap() {
            '"' => {
                let s = self.content.cut_word();
                self.content.cut_char();
                let token = Token::StringConstant(s.to_string());
                return ParsingState::End(token);
            }
            _ => state,
        }
    }

    fn handle_has_met_slash(&mut self) -> ParsingState {
        match self.content.char().unwrap() {
            '/' => ParsingState::OneLineComment,
            '*' => ParsingState::BlockComment,
            _ => {
                let token = Token::Symbol(self.content.cut_char());
                return ParsingState::End(token);
            }
        }
    }

    fn handle_one_line_comment(&mut self, state: ParsingState) -> ParsingState {
        match self.content.char().unwrap() {
            '\n' => {
                self.content.cut_word();
                self.content.cut_char();
                ParsingState::Initial
            }
            _ => state,
        }
    }

    fn handle_block_comment(&mut self, state: ParsingState) -> ParsingState {
        match self.content.char().unwrap() {
            '*' => ParsingState::BlockCommentCanEnd,
            _ => state,
        }
    }

    fn handle_block_comment_can_end(&mut self, state: ParsingState) -> ParsingState {
        match self.content.char().unwrap() {
            '/' => {
                self.content.cut_word();
                self.content.cut_char();
                ParsingState::Initial
            }
            '*' => state,
            _ => ParsingState::BlockComment,
        }
    }
}

impl Iterator for Tokenizer {
    type Item = Token;

    fn next(&mut self) -> Option<Self::Item> {
        let mut state = ParsingState::Initial;
        self.content.reset();

        while self.content.char() != None {
            state = match state {
                ParsingState::Initial => self.handle_initial(state),
                ParsingState::ConsumingChars => self.handle_consuming_chars(state),
                ParsingState::ConsumingNumbers => self.handle_consuming_numbers(state),
                ParsingState::HasMetQuote => self.handle_has_met_quote(state),
                ParsingState::HasMetSlash => self.handle_has_met_slash(),
                ParsingState::OneLineComment => self.handle_one_line_comment(state),
                ParsingState::BlockComment => self.handle_block_comment(state),
                ParsingState::BlockCommentCanEnd => self.handle_block_comment_can_end(state),
                _ => panic!("Unhandled state!"),
            };

            if let ParsingState::End(token) = state {
                return Some(token);
            }

            self.content.advance();
        }

        None
    }
}
