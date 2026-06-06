const std = @import("std");

const DIAL_START_POS: u8 = 50;
const DIAL_MAX_LENGTH: i16 = 100;

fn getFile() !std.fs.File {
    const dir = std.fs.cwd();
    const file = try dir.openFile("./input.txt", .{});

    return file;
}

fn readLine(reader: *std.fs.File.Reader) !?[]u8 {
    const line = try reader.interface.takeDelimiter('\n');
    return line;
}

pub fn main() !void {
    var file = try getFile();
    defer file.close();
    var buffer: [4096]u8 = undefined;
    var reader = file.reader(&buffer);
    var value: i16 = DIAL_START_POS;
    var count: u16 = 0;
    while (try readLine(&reader)) |line| {
        const direction = line[0];
        const steps = switch (direction) {
            'R' => try std.fmt.parseInt(i16, line[1..], 10),
            'L' => -try std.fmt.parseInt(i16, line[1..], 10),
            else => return error.InvalidCode,
        };

        var raw = @abs(@divFloor(value + steps, DIAL_MAX_LENGTH));
        if (value == 0 and steps < 0) {
            raw -= 1;
        }
        value = @mod(value + steps, DIAL_MAX_LENGTH);

        if (value == 0 and steps < 0) {
            raw += 1;
        }

        count += raw;

        std.debug.print("{} - {} - {}\n", .{ value, steps, raw });
    }

    std.debug.print("\nCount {}\n", .{count});
}
