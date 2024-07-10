	.section .text.entrypoint
start:
	jal ra, pre_main
__trap:
	j __trap

pre_main:
	la sp, _stack_addr
	la t1, _bss_start
	la t2, _bss_end
dloop:
	sw x0, (t1)
	addi t1, t1, 4
	blt t1, t2, dloop

	j main
