use specs::prelude::*;
use serde::{Serialize, Deserialize};
use gdnative::prelude::*;

#[derive(Debug, PartialEq, Deserialize, Serialize, NativeClass, ToVariant)]
#[inherit(Node)]
pub struct Quest {
  pub quest_name: String,
  pub expires: i32,
  pub description: String,
}

#[methods]
impl Quest {
    fn new(_owner: &Node) -> Self {
        Quest {
          quest_name: "".into(),
          expires: 0,
          description: "".into(),
        }
    }

    #[export]
    fn _ready(&self, _owner: &Node) { }
}

#[derive(Debug, Deserialize, Serialize)]
pub struct Quests {
  pub quests: Vec<Quest>,
}
