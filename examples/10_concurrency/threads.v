import time

fn worker(id int) {
	for i in 0 .. 3 {
		println('worker ${id}: iteration ${i}')
		time.sleep(100 * time.millisecond)
	}
	println('worker ${id}: done')
}

fn main() {
	println('starting workers...')

	mut threads := []thread{}
	for i in 0 .. 3 {
		threads << spawn worker(i)
	}

	for t in threads {
		t.wait()
	}

	println('all workers done')
}
