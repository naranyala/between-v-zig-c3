const std = @import("std");

pub fn main() void {
    // Use page allocator for simplicity
    const allocator = std.heap.page_allocator;

    // Allocate memory
    const ptr = allocator.alloc(u8, 100) catch {
        std.debug.print("alloc failed\n", .{});
        return;
    };
    defer allocator.free(ptr);

    std.debug.print("allocated 100 bytes at {*}\n", .{ptr.ptr});
    std.debug.print("freed memory\n", .{});
}
