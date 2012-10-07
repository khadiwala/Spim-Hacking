#Should stop execution and print error message after f_end
.text
main:
li  $t0, 7
jal my_func
jr  $ra


my_func:
#@ f_start
   addi $t0, $t0, 1
   addi $sp, $sp, 4
#@ f_end
  jr   $ra
