const std = @import("std");

fn divide(x: i32, y: i32) error{DivisionByZero}!i32 {
	if (y == 0) return error.DivisionByZero;
	return @divTrunc(x, y);
}

pub fn main() !void {
	const result = divide(10, 2) catch |err| {
		std.debug.print("Error: {}\n", .{err});
		return;
	};
	std.debug.print("Result: {}\n", .{result});
}
