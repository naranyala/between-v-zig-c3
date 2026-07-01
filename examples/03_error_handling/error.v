fn divide(x int, y int) ?int {
	if y == 0 {
		return none
	}
	return x / y
}

fn main() {
	result := divide(10, 2) or {
		eprintln('division by zero')
		return
	}
	println('Result: ${result}')
}
