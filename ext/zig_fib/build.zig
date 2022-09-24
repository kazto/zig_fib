const std = @import("std");


pub fn build(b: *std.build.Builder) void {
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const lib = b.addSharedLibrary("zig_fib", "src/main.zig", .unversioned);
    lib.setBuildMode(mode);
    lib.addIncludeDir("/home/kazto/.anyenv/envs/rbenv/versions/3.1.1/include/ruby-3.1.0");
    lib.addIncludeDir("/home/kazto/.anyenv/envs/rbenv/versions/3.1.1/include/ruby-3.1.0/x86_64-linux");
    lib.addIncludeDir("/usr/lib/gcc/x86_64-linux-gnu/9/include");
    lib.addIncludeDir("/usr/local/include");
    lib.addIncludeDir("/usr/include/x86_64-linux-gnu");
    lib.addIncludeDir("/usr/include");
    _ = lib.installRaw("zig_fib.so", std.build.InstallRawStep.CreateOptions{ .dest_dir = std.build.InstallDir{ .custom = "../"} });

    const main_tests = b.addTest("src/main.zig");
    main_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
