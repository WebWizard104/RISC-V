
firmware_wish_riscv.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <__start>:
   0:	008000ef          	jal	8 <pre_main>

00000004 <__post_main>:
   4:	0000006f          	j	4 <__post_main>

00000008 <pre_main>:
   8:	00001117          	auipc	sp,0x1
   c:	ff410113          	add	sp,sp,-12 # ffc <_USER_SP_ADDR>
  10:	00000297          	auipc	t0,0x0
  14:	06028293          	add	t0,t0,96 # 70 <_text_end>
  18:	00001317          	auipc	t1,0x1
  1c:	be830313          	add	t1,t1,-1048 # c00 <z>
  20:	00001397          	auipc	t2,0x1
  24:	be038393          	add	t2,t2,-1056 # c00 <z>

00000028 <dloop>:
  28:	0002ae03          	lw	t3,0(t0)
  2c:	01c32023          	sw	t3,0(t1)
  30:	00428293          	add	t0,t0,4
  34:	00430313          	add	t1,t1,4
  38:	fe7348e3          	blt	t1,t2,28 <dloop>
  3c:	00001317          	auipc	t1,0x1
  40:	bc430313          	add	t1,t1,-1084 # c00 <z>
  44:	00001397          	auipc	t2,0x1
  48:	bc038393          	add	t2,t2,-1088 # c04 <_bss_end>

0000004c <dloop2>:
  4c:	00032023          	sw	zero,0(t1)
  50:	00430313          	add	t1,t1,4
  54:	fe734ce3          	blt	t1,t2,4c <dloop2>
  58:	0040006f          	j	5c <main>

0000005c <main>:
  5c:	000017b7          	lui	a5,0x1
  60:	00500713          	li	a4,5
  64:	c0e7a023          	sw	a4,-1024(a5) # c00 <z>
  68:	00000513          	li	a0,0
  6c:	00008067          	ret

Disassembly of section .bss:

00000c00 <z>:
 c00:	0000                	.2byte	0x0
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	3241                	.2byte	0x3241
   2:	0000                	.2byte	0x0
   4:	7200                	.2byte	0x7200
   6:	7369                	.2byte	0x7369
   8:	01007663          	bgeu	zero,a6,14 <pre_main+0xc>
   c:	0028                	.2byte	0x28
   e:	0000                	.2byte	0x0
  10:	1004                	.2byte	0x1004
  12:	7205                	.2byte	0x7205
  14:	3376                	.2byte	0x3376
  16:	6932                	.2byte	0x6932
  18:	7032                	.2byte	0x7032
  1a:	5f31                	.2byte	0x5f31
  1c:	326d                	.2byte	0x326d
  1e:	3070                	.2byte	0x3070
  20:	7a5f 6369 7273      	.byte	0x5f, 0x7a, 0x69, 0x63, 0x73, 0x72
  26:	7032                	.2byte	0x7032
  28:	5f30                	.2byte	0x5f30
  2a:	6d7a                	.2byte	0x6d7a
  2c:	756d                	.2byte	0x756d
  2e:	316c                	.2byte	0x316c
  30:	3070                	.2byte	0x3070
	...

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	.4byte	0x3a434347
   4:	2820                	.2byte	0x2820
   6:	31202967          	.4byte	0x31202967
   a:	2e32                	.2byte	0x2e32
   c:	2e32                	.2byte	0x2e32
   e:	0030                	.2byte	0x30
