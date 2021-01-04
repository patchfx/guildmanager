use gdnative::prelude::*;
use serde::{Deserialize, Serialize};
use specs::prelude::*;
use specs_derive::Component;

#[derive(Debug, PartialEq, Deserialize, Serialize, Component, NativeClass, ToVariant)]
#[inherit(Node)]
pub struct Player {
    pub name: String,
    pub gold: i32,
    pub experience: i32,
}

#[methods]
impl Player {
    fn new(_owner: &Node) -> Self {
        Player {
            name: "Falakin Pendrane".into(),
            gold: 10,
            experience: 0,
        }
    }

    #[export]
    fn _ready(&self, _owner: &Node) {}
}
