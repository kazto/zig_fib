#include "zig_fib.h"

VALUE rb_mZigFib;

void
Init_zig_fib(void)
{
  rb_mZigFib = rb_define_module("ZigFib");
}
