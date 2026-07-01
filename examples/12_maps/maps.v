fn main() {
	// Map declaration and initialization
	mut ages := map[string]int{}
	ages['Alice'] = 30
	ages['Bob'] = 25
	ages['Charlie'] = 35
	println('ages: ${ages}')

	// Access elements
	println('Alice age: ${ages['Alice']}')

	// Add elements
	ages['Diana'] = 28
	println('after add: ${ages}')

	// Modify elements
	ages['Alice'] = 31
	println('after modify: ${ages}')

	// Check existence
	if 'Bob' in ages {
		println('Bob exists: ${ages['Bob']}')
	}

	// Remove elements
	ages.delete('Charlie')
	println('after delete: ${ages}')

	// Map iteration
	println('iterating:')
	for key, val in ages {
		println('  ${key}: ${val}')
	}

	// Map keys and values
	println('keys: ${ages.keys()}')
	println('values: ${ages.values()}')

	// Map length
	println('length: ${ages.len}')

	// Map with default value
	val := ages['Unknown'] or { 0 }
	println('unknown age: ${val}')
}
