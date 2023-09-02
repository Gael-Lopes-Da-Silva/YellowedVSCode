#[derive(Debug)]
struct HasLifetime<'a> {
  some_string: &'a str
}

fn do_something<'a>(has_lifetime: &HasLifetime<'a>) {
  println!("{}", has_lifetime.some_string);
}

fn main() {
  let has_lifetime = HasLifetime {
    some_string: "example"
  };
  do_something(&has_lifetime);
}

type TimeoutFunction = Box<Fn(&str, &ArgsMatcher) -> ()>;

fn whatever(&self, closure: Box<Fn() + 'static>) {
  // do nothing
}

impl<'a> AsRef<i32> for Foo<'a> {
    fn as_ref(&self) -> &i32 {
        &self.x
    }
}

pub unsafe fn hello() {}

use std::io;
use rand::Rng;

fn main() {
    println!("Guess the number!");
    // oskour

    let secret_number = rand::thread_rng().gen_range(1, 101);

    println!("The secret number is: {}", secret_number);

    println!("Please input your guess.");

    let mut guess = String::new();

    io::stdin().read_line(&mut guess)
        .expect("Failed to read line");

    println!("You guessed: {}", guess);
}
