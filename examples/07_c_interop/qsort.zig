const std = @import("std");

fn compare(context: void, a: i32, b: i32) bool {
	_ = context;
	return a < b;
}

pub fn main() void {
	var arr = [_]i32{ 5, 2, 8, 1, 9 };
	std.sort.block(i32, &arr, {}, compare);

	for (arr) |val| {
		std.debug.print("{d} ", .{val});
	}
	std.debug.print("\n", .{});
}
