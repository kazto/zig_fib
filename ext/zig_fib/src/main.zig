const std = @import("std");
const testing = std.testing;

const ruby = @cImport({
    @cInclude("ruby.h");
});

export fn wrap_fib(self: ruby.VALUE, v: ruby.VALUE) callconv(.C) ruby.VALUE {
    const n: i32 = ruby.FIX2INT(v);
    const r: i32 = fib(n);
    _ = self;
    return ruby.INT2FIX(r);
}

export fn Init_zig_fib() void {
    const rb_mZigFib: ruby.VALUE = ruby.rb_define_module("ZigFib");
    ruby.rb_define_module_function(
        rb_mZigFib,
        "fib",
        @ptrCast(fn(...) callconv(.C) ruby.VALUE, wrap_fib),
        1
    );
}

export fn fib(n: i32) i32 {
    const r = switch(n) {
        0, 1 => n,
        else => fib(n - 1) + fib(n - 2),
    };
    return r;
}

test "basic add functionality" {
    try testing.expect(fib(0) == 0);
    try testing.expect(fib(1) == 1);
    try testing.expect(fib(2) == 1);
    try testing.expect(fib(10) == 55);
}
