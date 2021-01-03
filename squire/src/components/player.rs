use specs::prelude::*;
use specs_derive::Component;
use serde::{Serialize, Deserialize};
use gdnative::prelude::*;

#[derive(Debug, PartialEq, Deserialize, Serialize, Component, NativeClass, ToVariant)]
#[inherit(Node)]
pub struct Player { }

#[methods]
impl Player {
    fn new(_owner: &Node) -> Self {
        Player { }
    }

    #[export]
    fn _ready(&self, _owner: &Node) { }
}
