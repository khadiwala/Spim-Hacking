#all asserts should pass

.text
main:

add $t0, $0, $0
li  $t0, -1
li  $t1, 3
#@  $t0 != 12
#@  $t0 == -1
#@  $t1 < 5
#@  $t0 >= -1
li  $t0, 1
jr  $ra

