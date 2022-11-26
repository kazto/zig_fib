const std = @import("std");


pub fn build(b: *std.build.Builder) void {
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.

    var build_step = b.step("build", "build so file.");

    const mode = b.standardReleaseOptions();
    const lib = b.addSharedLibrary("zig_fib", "src/main.zig", .unversioned);
    lib.setBuildMode(mode);
    lib.addIncludePath("/home/kazto/.anyenv/envs/rbenv/versions/3.1.2/include/ruby-3.1.0");
    lib.addIncludePath("/home/kazto/.anyenv/envs/rbenv/versions/3.1.2/include/ruby-3.1.0/x86_64-linux");
    lib.addIncludePath("/usr/lib/gcc/x86_64-linux-gnu/9/include");
    lib.addIncludePath("/usr/local/include");
    lib.addIncludePath("/usr/include/x86_64-linux-gnu");
    lib.addIncludePath("/usr/include");
    lib.install();

    build_step.dependOn(&lib.step);

    const install_so = b.addSystemCommand(&[_][]const u8{"cp", "./zig-out/lib/libzig_fib.so", "./zig_fib.so"});
    build_step.dependOn(&install_so.step);

    const hello = b.addSystemCommand(&[_][]const u8{"echo", "hello world"});
    build_step.dependOn(&hello.step);

    b.default_step.dependOn(build_step);

    const main_tests = b.addTest("src/main.zig");
    main_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
