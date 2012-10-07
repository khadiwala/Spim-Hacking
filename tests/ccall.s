.text

#@ cfunc "my_func" "
int my_func(int a, int b, int c, int d){
    int e = 300;
    return e;
}
"
#@ cfunc "other_func" "
int other_func(int a, int b, int c, int d){
    return a;
}
"

main:
  li   $a0, 4
  #@ ccall "my_func"
  addi $t0, $t0, 0
  #@ $v0 == 300
  li   $a0, 8
  move $v0, $a1
  #@ ccall "other_func"
  #@ $v0 == 8
  jr   $ra

