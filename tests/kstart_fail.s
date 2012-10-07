#this test should fail
.text
main:
li  $t0, 7
jal my_func
jr  $ra


my_func:
#@ k_start
   addi $t0, $t0, 1
#@ k_end
  jr   $ra
