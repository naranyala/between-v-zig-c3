import json

struct User {
	name string
	age  int
}

fn main() {
	data := '{"name":"Alice","age":30}'
	user := json.decode(User, data) or {
		eprintln('Failed to parse JSON')
		return
	}
	println('name: ${user.name}, age: ${user.age}')
}
