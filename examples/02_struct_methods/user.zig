const std = @import("std");

const User = struct {
	name: []const u8,
	age: u32,

	fn greet(self: User) void {
		std.debug.print("Hello, my name is {s}\n", .{self.name});
	}
};

pub fn main() void {
	const user = User{ .name = "Alice", .age = 30 };
	user.greet();
}
