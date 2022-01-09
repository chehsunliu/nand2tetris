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
            function_name: None
        }
    }

    pub fn set_vm_name(&mut self, name: &str) {
        self.vm_name = Some(name.to_string());
    }

    pub fn set_function_name(&mut self, name: &str) {
        self.function_name = Some(name.to_string());
    }

    pub fn generate_label(&mut self) -> String {
        let v = self.counter;
        self.counter += 1;
        format!("_LABEL.{}", v)
    }

    pub fn generate_static_address(&self, index: i32) -> String {
        format!("{}.{}", self.vm_name.as_deref().unwrap_or(""), index)
    }
}
