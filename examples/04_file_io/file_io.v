import os

fn main() {
	contents := os.read_file('input.txt') or {
		eprintln('Failed to read file')
		return
	}
	print(contents)
}
