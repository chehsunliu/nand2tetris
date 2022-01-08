use std::cell::RefCell;

pub struct Label {
    counter: RefCell<i32>,
}

impl Label {
    pub fn new() -> Label {
        Label {
            counter: RefCell::new(0),
        }
    }

    pub fn get(&self) -> String {
        let v = *self.counter.borrow();
        *self.counter.borrow_mut() += 1;
        format!("_LABEL.{}", v)
    }
}
