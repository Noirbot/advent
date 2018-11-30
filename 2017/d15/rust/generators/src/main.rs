use std::thread;

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
  let mut matches: u64 = 0;
  
  let handle1 = thread::spawn(|| {
    let mut gen = Generator {factor: 16807, value: 634, divisor: 2147483647};
    let mut values = Vec::with_capacity(5_000_000);
    for _iter in 0..5_000_000 {
      values.push(loop {
        if gen.generate() % 4 == 0 {
          break gen.value;
        }
      })
    }
    return values;
  });

  let handle2 = thread::spawn(move || {
    let mut gen = Generator {factor: 48271, value: 301, divisor: 2147483647};
    let mut values = Vec::with_capacity(5_000_000);
    for _iter in 0..5_000_000 {
      values.push(loop {
        if gen.generate() % 8 == 0 {
          break gen.value;
        }
      })
    }
    return values;
  });

  let vals1 = handle1.join().unwrap();
  let vals2 = handle2.join().unwrap();

  for iter in 0..5_000_000 {
    matches += check_tail(vals1[iter], vals2[iter]);
  }

  println!("{}", matches)
}