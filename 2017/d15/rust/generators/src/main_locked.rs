use std::thread;
use std::sync::{Arc, Mutex};

#[derive(Debug)]
struct Generator {
  factor: u128,
  value: u128,
  divisor: u128,
}

impl std::fmt::Display for Generator {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(f, "(currentValue: {}, usedFactor: {})", self.value, self.factor)
    }
}

impl Generator {
  fn generate(&mut self) -> u128 {
    self.value = (self.value * self.factor) % self.divisor;
    self.value
  }
}

fn check_tail(val1: u128, val2: u128) -> u64 {
  let bin1 = format!("{:0>16b}", val1);
  let bin2 = format!("{:0>16b}", val2);

  if &bin1[(bin1.len()-16)..] == &bin2[(bin2.len()-16)..] {
    return 1
  } else {
    return 0
  }
}

fn main() {
  let mut gen1 = Generator {factor: 16807, value: 634, divisor: 2147483647};
  
  let mutex_gen1 = Arc::new(Mutex::new(gen1));

  let mut gen2 = Generator {factor: 48271, value: 301, divisor: 2147483647};
  
  let mutex_gen2 = Arc::new(Mutex::new(gen2));

  let mut matches: u64 = 0;
  
  for iter in 0..5_000_000 {
  //  println!("on iter: {}", iter);
    let mutex_gen1_clone = mutex_gen1.clone();
    let handle1 = thread::spawn(move || {
      let mut gen = mutex_gen1_clone.lock().unwrap();
      loop {
        if gen.generate() % 4 == 0 {
          break;
        }
      }
    });

    let mutex_gen2_clone = mutex_gen2.clone();
    let handle2 = thread::spawn(move || {
      let mut gen = mutex_gen2_clone.lock().unwrap();
      loop {
        if gen.generate() % 8 == 0 {
          break;
        }
      }
    });

    handle1.join().unwrap();
    handle2.join().unwrap();

    matches += check_tail(mutex_gen1.lock().unwrap().value, mutex_gen2.lock().unwrap().value);
  }

  println!("{}", matches)
}