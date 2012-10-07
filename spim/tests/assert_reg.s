#all asserts should pass

.text
main:

add $t0, $0, $0
li  $t0, 125
li  $t1, 3
#@  $t0 != $t1
#@  $t0 > $t1
#@  $t1 <= $t0
li  $t0, 1
jr  $ra

