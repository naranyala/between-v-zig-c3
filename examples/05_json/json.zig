const std = @import("std");

const User = struct {
	name: []const u8,
	age: u32,
};

pub fn main() !void {
	var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
	defer arena.deinit();
	const allocator = arena.allocator();

	const data = "{\"name\":\"Alice\",\"age\":30}";
	const parsed = try std.json.parseFromSlice(User, allocator, data, .{});
	defer parsed.deinit();

	std.debug.print("name: {s}, age: {}\n", .{ parsed.value.name, parsed.value.age });
}
