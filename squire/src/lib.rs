use gdnative::prelude::*;
use rand::prelude::*;
use specs::prelude::*;
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
        ecs.register::<Player>();
        ecs.register::<Quest>();
        ecs.register::<AcceptedQuest>();

        GameState { ecs }
    }

    #[export]
    fn _ready(&self, _owner: &Node) {
        godot_print!("GameState Loaded");
    }

    #[export]
    fn load(&mut self, _owner: &Node, names: Vec<String>, player_name: String) {
        let character_count = 2000;
        let dice = Dice {};
        let mut rng = rand::thread_rng();

        let player = self.ecs.create_entity().with(Player { name: player_name, gold: 10, experience: 0 }).build();

        self.ecs.insert(player);

        for _x in 0..character_count {
            let character = Character {
                name: format!(
                    "{} {}",
                    names[rng.gen_range(1..names.len() - 1) as usize],
                    names[rng.gen_range(1..names.len() - 1) as usize]
                ),
                might: dice.roll_multiple(3, 6),
                mind: dice.roll_multiple(3, 6),
                reflex: dice.roll_multiple(3, 6),
                constitution: dice.roll_multiple(3, 6),
                charisma: dice.roll_multiple(3, 6),
            };

            self.ecs.create_entity().with(character).build();
        }
    }

    #[export]
    fn load_quests(&mut self, _owner: &Node) -> Vec<Quest> {
        let file = File::open("./Resources/quests.json").unwrap();
        let reader = BufReader::new(file);
        let quests: Quests = serde_json::from_reader(reader).unwrap();

        for quest in quests.quests.iter() {
            self.ecs
                .create_entity()
                .with(Quest {
                    id: quest.id,
                    quest_name: quest.quest_name.clone(),
                    expires: quest.expires,
                    description: quest.description.clone(),
                    reward: quest.reward,
                })
                .build();
        }
        quests.quests
    }

    #[export]
    fn current_quests(&self, _owner: &Node) -> Vec<Quest> {
        let mut quests: Vec<Quest> = vec![];
        let all_quests = self.ecs.read_storage::<Quest>();
        let accepted_quests = self.ecs.read_storage::<AcceptedQuest>();

        for quest in (all_quests).join() {
            for accepted_quest in (accepted_quests).join() {
                if accepted_quest.quest_id == quest.id && !accepted_quest.completed {
                    let q = Quest {
                        id: quest.id,
                        quest_name: quest.quest_name.clone(),
                        expires: quest.expires,
                        description: quest.description.clone(),
                        reward: quest.reward,
                    };

                    quests.push(q);
                }
            }
        }

        quests
    }

    #[export]
    fn accept_quest(&self, _owner: &Node, quest_id: i32) {
        let quests = self.ecs.read_storage::<Quest>();
        let entities = self.ecs.entities();
        let player = self.ecs.read_storage::<Player>();

        for quest in (&quests).join() {
            if quest.id == quest_id {
                for (_player, entity) in (&player, &entities).join() {
                    let mut accepted_quests = self.ecs.write_storage::<AcceptedQuest>();
                    let accepted_quest = AcceptedQuest {
                        quest_id: quest.id,
                        completed: false,
                    };
                    accepted_quests
                        .insert(entity, accepted_quest)
                        .expect("Cannot accept quest");
                    godot_print!("Quest inserted!!");
                }
            }
        }
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

    #[export]
    fn player(&self, _owner: &Node) -> Player {
        let mut player = Player { name: "Falakin Pendrane".into(), gold: 0, experience: 0 };
        let players = self.ecs.read_storage::<Player>();

        for p in (players).join() {
            player.name = p.name.clone();
            player.gold = p.gold.clone();
            player.experience = p.experience.clone();
        }

        player
    }
}

fn init(handle: InitHandle) {
    handle.add_class::<GameState>();
}

godot_init!(init);
