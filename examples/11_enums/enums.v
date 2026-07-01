enum Color {
	red
	green
	blue
}

enum Direction {
	north
	south
	east
	west
}

fn color_name(c Color) string {
	match c {
		.red { return 'red' }
		.green { return 'green' }
		.blue { return 'blue' }
	}
}

fn main() {
	// Enum declaration and usage
	mut c := Color.red
	println('color: ${color_name(c)}')

	// Enum in switch
	d := Direction.north
	match d {
		.north { println('going north') }
		.south { println('going south') }
		.east { println('going east') }
		.west { println('going west') }
	}

	// Enum with methods
	println('color red index: ${int(Color.red)}')
	println('color green index: ${int(Color.green)}')
	println('color blue index: ${int(Color.blue)}')
}
