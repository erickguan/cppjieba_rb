#include <ruby.h>

void Init_internal();
VALUE rb_mCppjiebaRb;

void Init_cppjieba_rb()
{
    rb_mCppjiebaRb = rb_define_module("CppjiebaRb");

    Init_internal();
}
