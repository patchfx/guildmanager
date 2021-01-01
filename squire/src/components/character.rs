use gdnative::prelude::*;

#[derive(NativeClass, ToVariant)]
#[inherit(Node)]
pub struct Character {
  pub name: String,
}

#[methods]
impl Character {
    fn new(_owner: &Node) -> Self {
        Character {
          name: "".into(),
        }
    }

    #[export]
    fn _ready(&self, _owner: &Node) { }
}
