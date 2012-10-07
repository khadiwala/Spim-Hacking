#This test should sucueed and run normally

.text
main:
li  $t0, 7
jal my_func
jr  $ra


my_func:
#@ f_start
   addi $t0, $t0, 1
   addi $sp, $sp -4
   sw   $ra, 0($sp)
   jal  other_func
   lw   $ra, 0($sp)
   addi $sp, $sp, 4
#@ f_end
  jr   $ra

other_func:
#@ f_start
   addi $t0, $t0, 1
#@ f_end
   jr   $ra
