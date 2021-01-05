use gdnative::prelude::*;
use specs::prelude::*;
use specs_derive::Component;
#[derive(NativeClass, ToVariant, Component, Debug, PartialEq)]
#[inherit(Node)]
pub struct Guild {
    pub name: String,
    pub renown: i32,
}

#[methods]
impl Guild {
    fn new(_owner: &Node) -> Self {
        Guild {
            name: "".into(),
            renown: 0,
        }
    }

    #[export]
    fn _ready(&self, _owner: &Node) {}
}
