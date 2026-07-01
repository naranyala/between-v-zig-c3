struct Stack[T] {
mut:
	elements []T
}

fn (mut s Stack[T]) push(item T) {
	s.elements << item
}

fn (mut s Stack[T]) pop() ?T {
	if s.elements.len == 0 {
		return none
	}
	return s.elements.pop()
}

fn main() {
	mut stack := Stack[int]{}
	stack.push(10)
	stack.push(20)
	stack.push(30)

	for _ in 0 .. 3 {
		val := stack.pop() or {
			eprintln('stack empty')
			return
		}
		println('popped: ${val}')
	}
}
