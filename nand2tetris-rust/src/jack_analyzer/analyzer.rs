use std::error::Error;
use std::path::Path;

use xml::writer as xml;

use crate::jack_analyzer::buffered_tokenizer::BufferedTokenizer;
use crate::jack_analyzer::tokenizer::Token;

pub struct Analyzer {
    tokenizer: BufferedTokenizer,
    writer: xml::EventWriter<std::fs::File>,
}

impl Analyzer {
    pub fn new(input_path: &str, output_path: &Path) -> Result<Analyzer, Box<dyn Error>> {
        let tokenizer = BufferedTokenizer::new(&input_path)?;

        let f = std::fs::File::create(output_path)?;
        let writer = xml::EmitterConfig::new()
            .write_document_declaration(false)
            .normalize_empty_elements(false)
            .perform_indent(true)
            .create_writer(f);

        Ok(Analyzer { tokenizer, writer })
    }

    pub fn analyze(&mut self) -> Result<(), Box<dyn Error>> {
        match self.tokenizer.forward() {
            Token::Keyword(keyword) if keyword == "class" => self.compile_class(),
            _ => panic!("Unexpected token"),
        }

        Ok(())
    }
}

impl Analyzer {
    fn compile_class(&mut self) {
        self.write_start("class");
        self.write_keyword("class");

        match self.tokenizer.forward() {
            Token::Identifier(s) => self.write_identifier(&s),
            token => panic!("Expected class name but got {:?}", token),
        };

        match self.tokenizer.forward() {
            Token::Symbol(c) if c == '{' => self.write_symbol(c),
            token => panic!("Expected left brace but got {:?}", token),
        }

        loop {
            let token = self.tokenizer.forward();
            if let Token::Symbol('}') = token {
                self.tokenizer.backward();
                break;
            } else {
                self.tokenizer.backward();
            }

            match self.tokenizer.forward() {
                Token::Keyword(s) if s == "field" || s == "static" => {
                    self.tokenizer.backward();
                    self.compile_variable_declaration("classVarDec");
                }
                Token::Keyword(s) if s == "constructor" || s == "function" || s == "method" => {
                    self.tokenizer.backward();
                    self.compile_subroutine_declaration();
                }
                _ => panic!("Unexpected token: {:?}", token),
            }
        }

        match self.tokenizer.forward() {
            Token::Symbol(c) if c == '}' => self.write_symbol(c),
            token => panic!("Expected right brace but got {:?}", token),
        }

        self.write_end();
    }

    fn compile_subroutine_declaration(&mut self) {
        self.write_start("subroutineDec");

        match self.tokenizer.forward() {
            Token::Keyword(keyword)
                if keyword == "constructor" || keyword == "function" || keyword == "method" =>
            {
                self.write_keyword(&keyword)
            }
            t => panic!("Expected constructor/function/method but got {:?}", t),
        }

        match self.tokenizer.forward() {
            Token::Keyword(var_type) => self.write_keyword(&var_type),
            Token::Identifier(var_type) => self.write_identifier(&var_type),
            t => panic!("Expected function type but got {:?}", t),
        }

        match self.tokenizer.forward() {
            Token::Identifier(function_name) => self.write_identifier(&function_name),
            t => panic!("Expected function name but got {:?}", t),
        }

        match self.tokenizer.forward() {
            Token::Symbol(c) if c == '(' => self.write_symbol(c),
            t => panic!("Expected left parenthesis but got {:?}", t),
        }

        self.compile_parameter_list();

        match self.tokenizer.forward() {
            Token::Symbol(c) if c == ')' => self.write_symbol(c),
            t => panic!("Expected right parenthesis but got {:?}", t),
        }

        self.compile_subroutine_body();

        self.write_end();
    }

    fn compile_parameter_list(&mut self) {
        self.write_start("parameterList");

        if let Token::Symbol(')') = self.tokenizer.forward() {
            self.tokenizer.backward();
            self.write_end();
            return;
        } else {
            self.tokenizer.backward();
        }

        self.compile_variable_type();
        self.compile_variable_name();

        loop {
            match self.tokenizer.forward() {
                Token::Symbol(c) if c == ',' => self.write_symbol(c),
                Token::Symbol(c) if c == ')' => {
                    self.tokenizer.backward();
                    break;
                }
                t => panic!("Expected comma or right parenthesis but got {:?}", t),
            }

            self.compile_variable_type();
            self.compile_variable_name();
        }

        self.write_end();
    }

    fn compile_subroutine_body(&mut self) {
        self.write_start("subroutineBody");

        match self.tokenizer.forward() {
            Token::Symbol(c) if c == '{' => self.write_symbol(c),
            t => panic!("Expected left brace but got {:?}", t),
        }

        loop {
            match self.tokenizer.forward() {
                Token::Keyword(keyword) if keyword == "var" => {
                    self.tokenizer.backward();
                    self.compile_variable_declaration("varDec");
                }
                _ => {
                    self.tokenizer.backward();
                    break;
                }
            }
        }

        self.compile_statements();

        match self.tokenizer.forward() {
            Token::Symbol(c) if c == '}' => self.write_symbol(c),
            t => panic!("Expected right brace but got {:?}", t),
        }

        self.write_end();
    }

    fn compile_statements(&mut self) {
        self.write_start("statements");

        loop {
            match self.tokenizer.forward() {
                Token::Keyword(keyword) if keyword == "let" => self.compile_let_statement(),
                Token::Keyword(keyword) if keyword == "if" => self.compile_if_statement(),
                Token::Keyword(keyword) if keyword == "while" => self.compile_while_statement(),
                Token::Keyword(keyword) if keyword == "do" => self.compile_do_statement(),
                Token::Keyword(keyword) if keyword == "return" => self.compile_return_statement(),
                Token::Symbol(c) if c == '}' => {
                    self.tokenizer.backward();
                    break;
                }
                t => panic!("Expected statement keyword but got {:?}", t),
            }
        }

        self.write_end();
    }

    fn compile_let_statement(&mut self) {
        self.write_start("letStatement");
        self.write_keyword("let");

        self.compile_variable_name();

        if let Token::Symbol('[') = self.tokenizer.forward() {
            self.tokenizer.backward();
            self.compile_bracket_expression();
        } else {
            self.tokenizer.backward();
        }

        match self.tokenizer.forward() {
            Token::Symbol('=') => self.write_symbol('='),
            t => panic!("Expected = but got {:?}", t),
        }

        self.compile_expression();

        self.compile_semi_colon();
        self.write_end();
    }

    fn compile_if_statement(&mut self) {
        self.write_start("ifStatement");
        self.write_keyword("if");

        match self.tokenizer.forward() {
            Token::Symbol('(') => self.write_symbol('('),
            t => panic!("Expected left parenthesis but got {:?}", t),
        }

        self.compile_expression();

        match self.tokenizer.forward() {
            Token::Symbol(')') => self.write_symbol(')'),
            t => panic!("Expected right parenthesis but got {:?}", t),
        }

        match self.tokenizer.forward() {
            Token::Symbol('{') => self.write_symbol('{'),
            t => panic!("Expected left brace but got {:?}", t),
        }

        self.compile_statements();

        match self.tokenizer.forward() {
            Token::Symbol('}') => self.write_symbol('}'),
            t => panic!("Expected right brace but got {:?}", t),
        }

        self.write_end();
    }

    fn compile_while_statement(&mut self) {
        self.write_start("whileStatement");
        self.write_keyword("while");

        // TODO

        self.write_end();
    }

    fn compile_do_statement(&mut self) {
        self.write_start("doStatement");
        self.write_keyword("do");

        self.compile_subroutine_call();

        self.compile_semi_colon();
        self.write_end();
    }

    fn compile_return_statement(&mut self) {
        self.write_start("returnStatement");
        self.write_keyword("return");

        if let Token::Symbol(';') = self.tokenizer.forward() {
            self.tokenizer.backward();
        } else {
            self.tokenizer.backward();
            self.compile_expression();
        }

        self.compile_semi_colon();
        self.write_end();
    }

    fn compile_bracket_expression(&mut self) {
        match self.tokenizer.forward() {
            Token::Symbol('[') => self.write_symbol('['),
            t => panic!("Expected left bracket but got {:?}", t),
        }

        self.compile_expression();

        match self.tokenizer.forward() {
            Token::Symbol(']') => self.write_symbol(']'),
            t => panic!("Expected right bracket but got {:?}", t),
        }
    }

    fn compile_expression(&mut self) {
        self.write_start("expression");

        // TODO
        self.write_start("term");
        match self.tokenizer.forward() {
            Token::Identifier(s) => self.write_identifier(&s),
            Token::Keyword(s) => self.write_keyword(&s),
            t => panic!("Expected expression identifier or keyword but got {:?}", t),
        }
        self.write_end();

        self.write_end();
    }

    fn compile_expression_list(&mut self) {
        self.write_start("expressionList");

        if let Token::Symbol(')') = self.tokenizer.forward() {
            self.tokenizer.backward();
            self.write_end();
            return;
        } else {
            self.tokenizer.backward();
        }

        self.compile_expression();

        loop {
            match self.tokenizer.forward() {
                Token::Symbol(')') => {
                    self.tokenizer.backward();
                    break;
                },
                Token::Symbol(',') => self.write_symbol(','),
                t => panic!("Expected right parenthesis or comma but got {:?}", t),
            }

            self.compile_expression();
        }

        self.write_end();
    }

    fn compile_subroutine_call(&mut self) {
        self.tokenizer.forward();
        let is_called_implicitly = match self.tokenizer.forward() {
            Token::Symbol('(') => true,
            Token::Symbol('.') => false,
            t => panic!("Expected dot or left parenthesis but got {:?}", t),
        };

        self.tokenizer.backward();
        self.tokenizer.backward();

        if is_called_implicitly {
            match self.tokenizer.forward() {
                Token::Identifier(function_name) => self.write_identifier(&function_name),
                t => panic!("Expected function name but got {:?}", t),
            }
        } else {
            match self.tokenizer.forward() {
                Token::Identifier(name) => self.write_identifier(&name),
                t => panic!("Expected class name or variable name but got {:?}", t),
            }
            match self.tokenizer.forward() {
                Token::Symbol('.') => self.write_symbol('.'),
                t => panic!("Expected dot but got {:?}", t),
            }
            match self.tokenizer.forward() {
                Token::Identifier(function_name) => self.write_identifier(&function_name),
                t => panic!("Expected function name but got {:?}", t),
            }
        }

        match self.tokenizer.forward() {
            Token::Symbol('(') => self.write_symbol('('),
            t => panic!("Expected left parenthesis but got {:?}", t),
        }

        self.compile_expression_list();

        match self.tokenizer.forward() {
            Token::Symbol(')') => self.write_symbol(')'),
            t => panic!("Expected right parenthesis but got {:?}", t),
        }
    }

    fn compile_variable_declaration(&mut self, declaration: &str) {
        self.write_start(declaration);

        match self.tokenizer.forward() {
            Token::Keyword(keyword)
                if keyword == "static" || keyword == "field" || keyword == "var" =>
            {
                self.write_keyword(&keyword);
            }
            t => panic!("Expected static/field/var but got {:?}", t),
        }

        self.compile_variable_type();
        self.compile_variable_name();

        loop {
            match self.tokenizer.forward() {
                Token::Symbol(c) if c == ',' => self.write_symbol(c),
                Token::Symbol(c) if c == ';' => {
                    self.write_symbol(c);
                    break;
                }
                t => panic!("Expected comma or semi-colon but got {:?}", t),
            }

            self.compile_variable_name();
        }

        self.write_end();
    }

    fn compile_variable_type(&mut self) {
        match self.tokenizer.forward() {
            Token::Keyword(var_type) => self.write_keyword(&var_type),
            Token::Identifier(var_type) => self.write_identifier(&var_type),
            t => panic!("Expected var type but got {:?}", t),
        }
    }

    fn compile_variable_name(&mut self) {
        match self.tokenizer.forward() {
            Token::Identifier(var_name) => self.write_identifier(&var_name),
            t => panic!("Expected var name but got {:?}", t),
        }
    }

    fn compile_semi_colon(&mut self) {
        match self.tokenizer.forward() {
            Token::Symbol(';') => self.write_symbol(';'),
            t => panic!("Expected semi-colon but got {:?}", t),
        }
    }
}

impl Analyzer {
    fn write_start(&mut self, s: &str) {
        self.writer.write(xml::XmlEvent::start_element(s)).unwrap();
    }

    fn write_characters(&mut self, s: &str) {
        self.writer.write(xml::XmlEvent::characters(s)).unwrap();
    }

    fn write_end(&mut self) {
        self.writer.write(xml::XmlEvent::end_element()).unwrap();
    }

    fn write_keyword(&mut self, keyword: &str) {
        self.write_start("keyword");
        self.write_characters(&format!(" {} ", keyword));
        self.write_end();
    }

    fn write_symbol(&mut self, symbol: char) {
        self.write_start("symbol");
        self.write_characters(&format!(" {} ", symbol));
        self.write_end();
    }

    fn write_identifier(&mut self, identifier: &str) {
        self.write_start("identifier");
        self.write_characters(&format!(" {} ", identifier));
        self.write_end();
    }
}
