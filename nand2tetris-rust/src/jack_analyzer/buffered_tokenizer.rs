use std::error::Error;

use crate::jack_analyzer::tokenizer::{Token, Tokenizer};

pub struct BufferedTokenizer {
    tokens: Vec<Token>,
    index: usize,
}

impl BufferedTokenizer {
    pub fn new(input_path: &str) -> Result<BufferedTokenizer, Box<dyn Error>> {
        let tokens: Vec<Token> = Tokenizer::new(&input_path)?.collect();
        Ok(BufferedTokenizer { tokens, index: 0 })
    }

    pub fn forward(&mut self) -> Token {
        let token = self.tokens.get(self.index).unwrap().clone();
        self.index += 1;
        return token;
    }

    pub fn backward(&mut self) -> Token {
        self.index -= 1;
        self.tokens.get(self.index).unwrap().clone()
    }
}
