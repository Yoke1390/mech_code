	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 4
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ; -- Begin function fact
lCPI0_0:
	.long	0                               ; 0x0
	.long	1                               ; 0x1
	.long	2                               ; 0x2
	.long	3                               ; 0x3
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_fact
	.p2align	2
_fact:                                  ; @fact
	.cfi_startproc
; %bb.0:
	cmp	w1, w2
	b.gt	LBB0_6
; %bb.1:
	add	w8, w2, #1
	sub	w9, w8, w1
	cmp	w9, #16
	b.lo	LBB0_5
; %bb.2:
	dup.4s	v0, w1
Lloh0:
	adrp	x10, lCPI0_0@PAGE
Lloh1:
	ldr	q1, [x10, lCPI0_0@PAGEOFF]
	add.4s	v1, v0, v1
	movi.4s	v0, #1
	movi.4s	v2, #1
	mov.s	v2[0], w0
	and	w10, w9, #0xfffffff0
	add	w1, w10, w1
	movi.4s	v3, #4
	movi.4s	v4, #8
	movi.4s	v5, #12
	movi.4s	v6, #16
	mov	x11, x10
	movi.4s	v7, #1
	movi.4s	v16, #1
LBB0_3:                                 ; =>This Inner Loop Header: Depth=1
	add.4s	v17, v1, v3
	add.4s	v18, v1, v4
	add.4s	v19, v1, v5
	mul.4s	v2, v1, v2
	mul.4s	v0, v17, v0
	mul.4s	v7, v18, v7
	mul.4s	v16, v19, v16
	add.4s	v1, v1, v6
	subs	w11, w11, #16
	b.ne	LBB0_3
; %bb.4:
	mul.4s	v0, v0, v2
	mul.4s	v0, v7, v0
	mul.4s	v0, v16, v0
	ext.16b	v1, v0, v0, #8
	mul.2s	v0, v0, v1
	fmov	w11, s0
	mov.s	w12, v0[1]
	mul	w0, w11, w12
	cmp	w9, w10
	b.eq	LBB0_6
LBB0_5:                                 ; =>This Inner Loop Header: Depth=1
	mul	w0, w1, w0
	add	w1, w1, #1
	cmp	w8, w1
	b.ne	LBB0_5
LBB0_6:
	ret
	.loh AdrpLdr	Lloh0, Lloh1
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ; -- Begin function main
lCPI1_0:
	.long	1                               ; 0x1
	.long	2                               ; 0x2
	.long	3                               ; 0x3
	.long	4                               ; 0x4
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x1, #8]
	bl	_atoi
	cmp	w0, #1
	b.lt	LBB1_3
; %bb.1:
	cmp	w0, #16
	b.hs	LBB1_4
; %bb.2:
	mov	w8, #1
	mov	w10, #1
	b	LBB1_7
LBB1_3:
	mov	w10, #1
	b	LBB1_9
LBB1_4:
	and	w9, w0, #0xfffffff0
	movi.4s	v0, #1
	movi.4s	v1, #4
Lloh2:
	adrp	x8, lCPI1_0@PAGE
Lloh3:
	ldr	q2, [x8, lCPI1_0@PAGEOFF]
	orr	w8, w9, #0x1
	movi.4s	v3, #8
	movi.4s	v4, #12
	movi.4s	v5, #16
	mov	x10, x9
	movi.4s	v6, #1
	movi.4s	v7, #1
	movi.4s	v16, #1
LBB1_5:                                 ; =>This Inner Loop Header: Depth=1
	add.4s	v17, v2, v1
	add.4s	v18, v2, v3
	add.4s	v19, v2, v4
	mul.4s	v0, v0, v2
	mul.4s	v6, v6, v17
	mul.4s	v7, v7, v18
	mul.4s	v16, v16, v19
	add.4s	v2, v2, v5
	subs	w10, w10, #16
	b.ne	LBB1_5
; %bb.6:
	mul.4s	v0, v6, v0
	mul.4s	v0, v7, v0
	mul.4s	v0, v16, v0
	ext.16b	v1, v0, v0, #8
	mul.2s	v0, v0, v1
	fmov	w10, s0
	mov.s	w11, v0[1]
	mul	w10, w10, w11
	cmp	w0, w9
	b.eq	LBB1_9
LBB1_7:
	add	w9, w0, #1
LBB1_8:                                 ; =>This Inner Loop Header: Depth=1
	mul	w10, w10, w8
	add	w8, w8, #1
	cmp	w9, w8
	b.ne	LBB1_8
LBB1_9:
	str	x10, [sp]
Lloh4:
	adrp	x0, l_.str@PAGE
Lloh5:
	add	x0, x0, l_.str@PAGEOFF
	bl	_printf
	mov	w0, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.loh AdrpLdr	Lloh2, Lloh3
	.loh AdrpAdd	Lloh4, Lloh5
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"ret = %d\n"

.subsections_via_symbols
