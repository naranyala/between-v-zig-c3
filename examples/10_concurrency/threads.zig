const std = @import("std");

fn worker(id: usize) void {
    for (0..3) |i| {
        std.debug.print("worker {}: iteration {}\n", .{ id, i });
    }
    std.debug.print("worker {}: done\n", .{id});
}

pub fn main() void {
    std.debug.print("starting workers...\n", .{});

    var threads: [3]std.Thread = undefined;
    for (0..3) |i| {
        threads[i] = std.Thread.spawn(.{}, worker, .{i}) catch {
            std.debug.print("failed to spawn thread\n", .{});
            return;
        };
    }

    for (threads) |thread| {
        thread.join();
    }

    std.debug.print("all workers done\n", .{});
}
