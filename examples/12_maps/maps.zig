const std = @import("std");

pub fn main() void {
    const allocator = std.heap.page_allocator;

    // Map declaration and initialization
    var ages = std.StringHashMap(i32).init(allocator);
    defer ages.deinit();

    _ = ages.put("Alice", 30) catch {};
    _ = ages.put("Bob", 25) catch {};
    _ = ages.put("Charlie", 35) catch {};
    std.debug.print("ages: {any}\n", .{ages});

    // Access elements
    if (ages.get("Alice")) |age| {
        std.debug.print("Alice age: {}\n", .{age});
    }

    // Add elements
    _ = ages.put("Diana", 28) catch {};
    std.debug.print("after add: {any}\n", .{ages});

    // Modify elements
    _ = ages.put("Alice", 31) catch {};
    std.debug.print("after modify: {any}\n", .{ages});

    // Check existence
    if (ages.get("Bob")) |age| {
        std.debug.print("Bob exists: {}\n", .{age});
    }

    // Remove elements
    _ = ages.remove("Charlie");
    std.debug.print("after delete: {any}\n", .{ages});

    // Map iteration
    std.debug.print("iterating:\n", .{});
    var iter = ages.iterator();
    while (iter.next()) |entry| {
        std.debug.print("  {s}: {}\n", .{ entry.key_ptr.*, entry.value_ptr.* });
    }

    // Map keys and values
    std.debug.print("keys:\n", .{});
    var key_iter = ages.keyIterator();
    while (key_iter.next()) |key| {
        std.debug.print("  {s}\n", .{key.*});
    }

    std.debug.print("values:\n", .{});
    var val_iter = ages.valueIterator();
    while (val_iter.next()) |val| {
        std.debug.print("  {}\n", .{val.*});
    }

    // Map length
    std.debug.print("length: {}\n", .{ages.count()});

    // Map with default value
    const val = ages.get("Unknown") orelse 0;
    std.debug.print("unknown age: {}\n", .{val});
}
