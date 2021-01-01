use rand::prelude::*;

pub struct Dice {}

impl Dice {
  pub fn roll_multiple(&self, rolls: i32, total: i32) -> i32 {
    let mut combined = 0;
    let mut rng = rand::thread_rng();

    for _x in 0..rolls {
      let roll = rng.gen_range(1..total);
      combined += roll;
    }

    combined
  }
}
