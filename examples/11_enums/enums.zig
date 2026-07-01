const std = @import("std");

const Color = enum {
    red,
    green,
    blue,

    fn name(self: Color) []const u8 {
        return switch (self) {
            .red => "red",
            .green => "green",
            .blue => "blue",
        };
    }
};

const Direction = enum {
    north,
    south,
    east,
    west,
};

pub fn main() void {
    // Enum declaration and usage
    var c = Color.red;
    std.debug.print("color: {s}\n", .{c.name()});

    // Enum iteration
    inline for (std.meta.fields(Color)) |field| {
        const color = @field(Color, field.name);
        std.debug.print("color: {s}\n", .{color.name()});
    }

    // Enum in switch
    const d = Direction.north;
    switch (d) {
        .north => std.debug.print("going north\n", .{}),
        .south => std.debug.print("going south\n", .{}),
        .east => std.debug.print("going east\n", .{}),
        .west => std.debug.print("going west\n", .{}),
    }

    // Enum with methods
    std.debug.print("color red index: {}\n", .{@intFromEnum(Color.red)});
    std.debug.print("color green index: {}\n", .{@intFromEnum(Color.green)});
    std.debug.print("color blue index: {}\n", .{@intFromEnum(Color.blue)});
}
