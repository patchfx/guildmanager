use gdnative::prelude::*;
use specs::prelude::*;
use specs_derive::Component;

#[derive(Debug, PartialEq, Component, NativeClass, ToVariant)]
#[inherit(Node)]
pub struct Week {
    pub current: i32,
}

#[methods]
impl Week {
    fn new(_owner: &Node) -> Self {
      Week {
            current: 14,
        }
    }

    #[export]
    fn _ready(&self, _owner: &Node) {}
}
   