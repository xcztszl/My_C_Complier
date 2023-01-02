.data
_Prompt: .asciiz "Enter an integer:  "
_ret: .asciiz "\n"
.globl main
.text
read:
  li $v0,4
  la $a0,_Prompt
  syscall
  li $v0,5
  syscall
  jr $ra
write:
  li $v0,1
  syscall
  li $v0,4
  la $a0,_ret
  syscall
  move $v0,$0
  jr $ra

main:
  addi $sp, $sp, -28
  li $t3, 1
  sw $t3, 16($sp)
  lw $t1, 16($sp)
  move $t3, $t1
  sw $t3, 12($sp)
  li $t3, 10
  sw $t3, 24($sp)
  lw $t1, 12($sp)
  lw $t2, 24($sp)
  ble $t1,$t2,label3
  j label2
label4:
  lw $t1, 12($sp)
  addi $t2, $t1, 1
  sw $t2, 12($sp)
label3:
  j label4
label2:
  li $t3, 0
  sw $t3, 16($sp)
  lw $v0,16($sp)
  jr $ra
label1:
