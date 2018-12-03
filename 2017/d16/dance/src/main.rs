use std::fs::File;
use std::io::prelude::*;
use std::cmp;

fn spin(line, count) {
  for _iter in 0..count {
    line.insert(0, line.pop());
  }
}

fn exchange(line, x, y) {
  let first = cmp::min(x, y);
  let last = cmp::max(x, y);
  let to_low = line.remove(last);
  let to_high = line.remove(first);
  line.insert(first, to_low);
  line.insert(last, to_high);
}

fn partner(line, x, y) {
  let x_ind = line.iter().position(|&s| s == x).unwrap();
  let y_ind = line.iter().position(|&s| s == y).unwrap();
  exchange(line, x_ind, y_ind);
}

fn main() {
  let mut line = vec!['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p'];
  let filename = "input.txt";
  let mut f = File::open(filename).expect("file not found");

  let mut contents = String::new();
  f.read_to_string(&mut contents)
    .expect("something went wrong reading the file");

  let instructions: Vec<&str> = contents.split(',').collect();

  for inst in &instructions {
    let command = inst.chars().collect();
    match command[0] {
      's' => spin(line, &command[1..]),
      'x' => exchange(line, command[1], command[3])
      'p' => partner(line, command[1], command[3])
    }
  }
}
