struct User {
	name string
	age  int
}

fn (u User) greet() string {
	return 'Hello, my name is ${u.name}'
}

fn main() {
	user := User{'Alice', 30}
	println(user.greet())
}
