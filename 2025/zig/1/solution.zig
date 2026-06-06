const std = @import("std");

const DIAL_START_POS: u8 = 50;
const DIAL_MAX_LENGTH: i32 = 100;

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
    var raw: i32 = DIAL_START_POS;
    var value: i32 = DIAL_START_POS;
    var count: i32 = 0;
    while (try readLine(&reader)) |line| {
        const direction = line[0];
        var rounds: i32 = 0;
        const length = try std.fmt.parseInt(i32, line[1..], 10);

        if (direction == 'R') {
            raw = value + length;
            value = @mod(raw, DIAL_MAX_LENGTH);
            rounds = @divTrunc(raw, DIAL_MAX_LENGTH);
        } else {
            raw = DIAL_MAX_LENGTH + length - value;
            if (value == 0) {
                rounds = @divTrunc(length, DIAL_MAX_LENGTH);
            } else {
                rounds = @divTrunc(raw, DIAL_MAX_LENGTH);
            }

            value = @mod(DIAL_MAX_LENGTH + value - length, DIAL_MAX_LENGTH);
        }

        std.debug.print("Line Value {s} - Current Value {} - Raw Value {} - Rounds {} \n", .{ line, value, raw, rounds });
        count += rounds;
    }

    std.debug.print("\nCount {}\n", .{count});
}
