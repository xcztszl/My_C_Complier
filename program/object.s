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
  addi $sp, $sp, -44
  lw $t1, 6604992($sp)
  move $t3, $t1
  sw $t3, 20($sp)
  lw $t1, 6605504($sp)
  move $t3, $t1
  sw $t3, 12($sp)
  li $t3, 0
  sw $t3, 28($sp)
  lw $t1, 6604992($sp)
  move $t3, $t1
  sw $t3, 0($sp)
  li $t3, 3
  sw $t3, 40($sp)
  lw $t1, 24($sp)
  lw $t2, 40($sp)
  blt $t1,$t2,label2
  j label1
label3:
  li $t3, 1
  sw $t3, 32($sp)
  lw $t1, 24($sp)
  lw $t2, 32($sp)
  add $t3,$t1,$t2
  sw $t3, 36($sp)
  lw $t1, 36($sp)
  move $t3, $t1
  sw $t3, 24($sp)
label2:
  li $t3, 1
  sw $t3, 40($sp)
  lw $t1, 24($sp)
  lw $t2, 40($sp)
  add $t3,$t1,$t2
  sw $t3, 44($sp)
  lw $t1, 44($sp)
  move $t3, $t1
  sw $t3, 24($sp)
  j label3
label1:
