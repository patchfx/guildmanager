use gdnative::prelude::*;
use specs::prelude::*;

#[derive(NativeClass)]
#[inherit(Node)]
pub struct GameState {
    ecs: World,
}

#[methods]
impl GameState {
    fn new(_owner: &Node) -> Self {
        let mut ecs = World::new();

        GameState { ecs }
    }

    #[export]
    fn _ready(&self, _owner: &Node) {
        godot_print!("GameState Loaded");
    }
}

fn init(handle: InitHandle) {
    handle.add_class::<GameState>();
}

godot_init!(init);
