use specs::prelude::*;
use specs_derive::Component;
use serde::{Serialize, Deserialize};
use gdnative::prelude::*;


#[derive(Debug, PartialEq, Deserialize, Serialize, NativeClass, ToVariant, Component)]
#[inherit(Node)]
pub struct Quest {
  pub id: i32,
  pub quest_name: String,
  pub expires: i32,
  pub description: String,
  pub reward: i32,
}

#[methods]
impl Quest {
    fn new(_owner: &Node) -> Self {
        Quest {
          id: 0,
          quest_name: "".into(),
          expires: 0,
          description: "".into(),
          reward: 0,
        }
    }

    #[export]
    fn _ready(&self, _owner: &Node) { }
}

#[derive(Debug, Deserialize, Serialize)]
pub struct Quests {
  pub quests: Vec<Quest>,
}

#[derive(Debug, Component, Deserialize, Serialize)]
pub struct AcceptedQuest {
  pub quest_id: i32
}
