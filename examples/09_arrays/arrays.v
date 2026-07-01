fn main() {
	// Array declaration and initialization
	mut arr := [1, 2, 3, 4, 5]
	println('array: ${arr}')
	println('length: ${arr.len}')

	// Access elements
	println('first: ${arr[0]}')
	println('last: ${arr[arr.len - 1]}')

	// Modify elements
	arr[0] = 10
	println('after modify: ${arr}')

	// Array operations
	arr << 6
	println('after append: ${arr}')

	mut removed := arr.pop()
	println('popped: ${removed}')
	println('after pop: ${arr}')

	// Array iteration
	println('iterating:')
	for i, val in arr {
		println('  [${i}] = ${val}')
	}

	// Array slicing
	slice := arr[1..4]
	println('slice [1..4]: ${slice}')

	// Array sorting
	mut nums := [5, 2, 8, 1, 9]
	nums.sort(a < b)
	println('sorted: ${nums}')

	// Array contains
	println('contains 5: ${nums.contains(5)}')
	println('contains 10: ${nums.contains(10)}')
}
