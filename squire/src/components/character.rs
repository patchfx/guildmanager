use gdnative::prelude::*;
use specs::prelude::*;
use specs_derive::Component;

#[derive(NativeClass, ToVariant)]
#[inherit(Node)]
pub struct GameCharacter {
  pub id: u32,
  pub name: String,
  pub might: i32,
  pub reflex: i32,
  pub mind: i32,
  pub constitution: i32,
  pub charisma: i32,
}

#[methods]
impl GameCharacter {
    fn new(_owner: &Node) -> Self {
        GameCharacter {
          id: 0,
          name: "".into(),
          might: 0,
          reflex: 0,
          mind: 0,
          constitution: 0,
          charisma: 0,
        }
    }

    #[export]
    fn _ready(&self, _owner: &Node) { }
}


#[derive(NativeClass, ToVariant, Component, Debug, PartialEq)]
#[inherit(Node)]
pub struct Character {
  pub name: String,
  pub might: i32,
  pub reflex: i32,
  pub mind: i32,
  pub constitution: i32,
  pub charisma: i32,
}

#[methods]
impl Character {
    fn new(_owner: &Node) -> Self {
        Character {
          name: "".into(),
          might: 0,
          reflex: 0,
          mind: 0,
          constitution: 0,
          charisma: 0,
        }
    }

    #[export]
    fn _ready(&self, _owner: &Node) { }
}
