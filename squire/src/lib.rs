use gdnative::prelude::*;

mod components;

use components::*;

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
        godot_print!("GameState Loaded");
    }

    #[export]
    fn load(&self, _owner: &Node) -> Vec<Character> {
        let mut characters: Vec<Character> = vec![];
        let character_count = 2000;

        for _x in 0..character_count {
            let character = Character {
                name: "".into(),
            };

            characters.push(character);
        }
        
        characters
    }
}

fn init(handle: InitHandle) {
    handle.add_class::<GameState>();
}

godot_init!(init);
