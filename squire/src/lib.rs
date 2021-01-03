use gdnative::prelude::*;
use specs::prelude::*;
use rand::prelude::*;
use std::fs::File;
use std::io::BufReader;

mod components;
mod utilities;

use components::*;
use utilities::*;

#[derive(NativeClass)]
#[inherit(Node)]
pub struct GameState {
    ecs: World,
}

#[methods]
impl GameState {
    fn new(_owner: &Node) -> Self {
        let mut ecs = World::new();

        ecs.register::<Character>();

        GameState { ecs }
    }

    #[export]
    fn _ready(&self, _owner: &Node) {
        godot_print!("GameState Loaded");
    }

    #[export]
    fn load(&mut self, _owner: &Node, names: Vec<String>) {
        let character_count = 2000;
        let dice = Dice {};
        let mut rng = rand::thread_rng();

        for _x in 0..character_count {
            let character = Character {
                name: format!("{} {}", names[rng.gen_range(1..names.len() - 1) as usize], names[rng.gen_range(1..names.len() - 1) as usize]),
                might: dice.roll_multiple(3, 6),
                mind: dice.roll_multiple(3, 6),
                reflex: dice.roll_multiple(3, 6),
                constitution: dice.roll_multiple(3, 6),
                charisma: dice.roll_multiple(3, 6),
            };

            self.ecs
                .create_entity()
                .with(character)
                .build();

        }
    }

    #[export]
    fn quests(&self, _owner: &Node) -> Vec<Quest> {
        let file = File::open("./Resources/quests.json").unwrap();
        let reader = BufReader::new(file);
        let quests: Quests = serde_json::from_reader(reader).unwrap();

        quests.quests
    }

    #[export]
    fn npcs(&self, _owner: &Node) -> Vec<GameCharacter> {
        let entities = self.ecs.entities();

        let mut collection: Vec<GameCharacter> = vec![];
        let characters = self.ecs.read_storage::<Character>();

        for (entity, character) in (&entities, &characters).join() {
            let npc = GameCharacter {
                id: entity.id(),
                name: character.name.clone(),
                might: character.might,
                mind: character.mind,
                reflex: character.reflex,
                constitution: character.constitution,
                charisma: character.charisma,
            };

            collection.push(npc);
        }

        collection
    }
}

fn init(handle: InitHandle) {
    handle.add_class::<GameState>();
}

godot_init!(init);
