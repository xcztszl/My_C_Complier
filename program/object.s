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

talk:
  li $t3, 1
  sw $t3, 16($sp)
  lw $t1, 6606639($sp)
  move $t3, $t1
  sw $t3, 1893628486($sp)
  lw $v0,12($sp)
  jr $ra
label1:

main:
  addi $sp, $sp, -48
  lw $t1, 6604480($sp)
  move $t3, $t1
  sw $t3, 20($sp)
  lw $t1, 6604992($sp)
  move $t3, $t1
  sw $t3, 12($sp)
  li $t3, 0
  sw $t3, 28($sp)
  lw $t1, 6604480($sp)
  move $t3, $t1
  sw $t3, 0($sp)
  li $t3, 0
  sw $t3, 32($sp)
  lw $t1, 32($sp)
  move $t3, $t1
  sw $t3, 24($sp)
  li $t3, 3
  sw $t3, 44($sp)
  lw $t1, 24($sp)
  lw $t2, 44($sp)
  blt $t1,$t2,label4
  j label3
label5:
  li $t3, 1
  sw $t3, 36($sp)
  lw $t1, 24($sp)
  lw $t2, 36($sp)
  add $t3,$t1,$t2
  sw $t3, 40($sp)
  lw $t1, 40($sp)
  move $t3, $t1
  sw $t3, 24($sp)
label4:
  li $t3, 1
  sw $t3, 44($sp)
  lw $t1, 24($sp)
  lw $t2, 44($sp)
  add $t3,$t1,$t2
  sw $t3, 48($sp)
  lw $t1, 48($sp)
  move $t3, $t1
  sw $t3, 24($sp)
  j label5
label3:
  move $t0,$sp
  addi $sp, $sp, -20
  sw $ra,0($sp)
  jal talk
  lw $ra,0($sp)
  addi $sp,$sp,20
  sw $v0,32($sp)
  li $t3, 0
  sw $t3, 32($sp)
  lw $v0,32($sp)
  jr $ra
label2:
