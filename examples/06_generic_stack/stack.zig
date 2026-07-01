const std = @import("std");

fn Stack(comptime T: type) type {
	return struct {
		const Self = @This();
		elements: std.ArrayList(T),
		gpa: std.mem.Allocator,

		fn init(gpa: std.mem.Allocator) Self {
			return .{ .elements = .empty, .gpa = gpa };
		}

		fn push(self: *Self, item: T) !void {
			try self.elements.append(self.gpa, item);
		}

		fn pop(self: *Self) ?T {
			return self.elements.pop();
		}

		fn deinit(self: *Self) void {
			self.elements.deinit(self.gpa);
		}
	};
}

pub fn main() !void {
	var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
	defer arena.deinit();
	const allocator = arena.allocator();

	var stack = Stack(i32).init(allocator);
	defer stack.deinit();

	try stack.push(10);
	try stack.push(20);
	try stack.push(30);

	while (stack.pop()) |val| {
		std.debug.print("popped: {}\n", .{val});
	}
}
