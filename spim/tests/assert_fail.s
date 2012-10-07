#The second assert should fail, stopping execution and
#printing an error message

.text
main:

add $t0, $0, $0
li  $t0, -1
li  $t1, 3
#@  $t1 == 3
#@  $t0 == 12
li  $t0, 1
jr  $ra

