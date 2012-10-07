.text

#@ cfunc "max" "
int max(int a, int b, int c, int d){
    if(a < b) 
        return b;
    else 
        return a;
}
"
#@ cfunc "other_func" "
int other_func(int a, int b, int c, int d){
    return a + 100;
}
"

main:
  addi  $sp, $sp, -4
  sw    $ra, 0($sp)
  li    $a0, 8
  li    $a1, 7
  jal   mips_max
  #@ $v0 == 8
  li    $a0, 8
  li    $a1, 7
  #@ ccall "max"
  #@ $v0 == 8
  move  $v0, $a1
  #@ ccall "other_func"
  #@ $v0 == 108
  lw    $ra, 0($sp)
  addi  $sp, $sp, 4
  jr    $ra

mips_max:
  #@ f_start
  bgt   $a0, $a1, a_larger
  move  $v0, $a1
  jr    $ra
a_larger:
  move  $v0, $a0
  #@ f_end
  jr    $ra
