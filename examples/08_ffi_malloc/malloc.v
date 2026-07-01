fn C.malloc(size int) voidptr
fn C.free(ptr voidptr)

fn main() {
	ptr := C.malloc(100)
	if ptr == 0 {
		eprintln('malloc failed')
		return
	}
	println('allocated 100 bytes at ${ptr}')
	C.free(ptr)
	println('freed memory')
}
