use gdnative::prelude::*;

#[derive(NativeClass)]
#[inherit(Node)]
pub struct GameState;

#[methods]
impl GameState {
    fn new(_owner: &Node) -> Self {
        GameState
    }

    #[export]
    fn _ready(&self, _owner: &Node) {
        godot_print!("hello, world from Rust!!!!");
    }
}

fn init(handle: InitHandle) {
    handle.add_class::<GameState>();
}

godot_init!(init);
