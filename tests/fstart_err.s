#this should fail and print an error msg because there
#is a f_end but no f_start

.text
main:
li  $t0, 7
jal my_func
jr  $ra


my_func:
   addi $t0, $t0, 1
#@ f_end
  jr   $ra
