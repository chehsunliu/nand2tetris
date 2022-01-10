pub struct Meta {
    counter: i32,
    vm_name: Option<String>,
    function_name: Option<String>,
}

impl Meta {
    pub fn new() -> Meta {
        Meta {
            counter: 0,
            vm_name: None,
            function_name: None,
        }
    }

    pub fn set_vm_name(&mut self, name: &str) {
        self.vm_name = Some(name.to_string());
    }

    pub fn set_function_name(&mut self, name: &str) {
        self.function_name = Some(name.to_string());
    }

    pub fn generate_implicit_label(&mut self) -> String {
        let v = self.counter;
        self.counter += 1;
        format!("_LABEL.{}", v)
    }

    pub fn generate_label(&self, label: &str) -> String {
        match self.function_name.as_ref() {
            Some(function_name) => format!("{}.{}", function_name, label),
            None => label.to_string(),
        }
    }

    pub fn generate_return_address(&mut self, name: &str) -> String {
        let v = self.counter;
        self.counter += 1;
        format!("RET_ADDRESS_{}{}", name, v)
    }

    pub fn generate_static_address(&self, index: i32) -> String {
        format!("{}.{}", self.vm_name.as_deref().unwrap_or(""), index)
    }
}
