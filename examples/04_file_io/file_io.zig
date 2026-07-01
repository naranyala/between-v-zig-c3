const std = @import("std");

pub fn main() !void {
	const allocator = std.heap.page_allocator;
	var threaded = std.Io.Threaded.init(allocator, .{});
	defer threaded.deinit();

	const io = threaded.io();
	const file = try std.Io.Dir.openFile(std.Io.Dir.cwd(), io, "input.txt", .{});
	defer file.close(io);

	var buf: [1024]u8 = undefined;
	var reader = file.reader(io, &buf);
	const content = try reader.interface.allocRemaining(allocator, std.Io.Limit.limited(1024 * 1024));
	defer allocator.free(content);

	std.debug.print("{s}", .{content});
}
