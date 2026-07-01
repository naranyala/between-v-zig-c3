const std = @import("std");

pub fn main() void {
    // Array declaration and initialization
    var arr = [_]i32{ 1, 2, 3, 4, 5 };
    std.debug.print("array: {any}\n", .{arr});
    std.debug.print("length: {}\n", .{arr.len});

    // Access elements
    std.debug.print("first: {}\n", .{arr[0]});
    std.debug.print("last: {}\n", .{arr[arr.len - 1]});

    // Modify elements
    arr[0] = 10;
    std.debug.print("after modify: {any}\n", .{arr});

    // Array iteration
    std.debug.print("iterating:\n", .{});
    for (arr, 0..) |val, i| {
        std.debug.print("  [{}] = {}\n", .{ i, val });
    }

    // Array slicing
    const slice = arr[1..4];
    std.debug.print("slice [1..4]: {any}\n", .{slice});

    // Array sorting
    var nums = [_]i32{ 5, 2, 8, 1, 9 };
    std.sort.block(i32, &nums, {}, struct {
        fn cmp(_: void, a: i32, b: i32) bool {
            return a < b;
        }
    }.cmp);
    std.debug.print("sorted: {any}\n", .{nums});

    // Array contains
    var found = false;
    for (nums) |val| {
        if (val == 5) {
            found = true;
            break;
        }
    }
    std.debug.print("contains 5: {}\n", .{found});

    found = false;
    for (nums) |val| {
        if (val == 10) {
            found = true;
            break;
        }
    }
    std.debug.print("contains 10: {}\n", .{found});
}
