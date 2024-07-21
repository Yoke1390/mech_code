	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 4
	.file	1 "/Users/yosukemaeda/Code/Mech/Class/Soft2/3rd" "fact-toc.c"
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
Lfunc_begin0:
	.loc	1 4 0                           ; fact-toc.c:4:0
	.cfi_startproc
; %bb.0:
	;DEBUG_VALUE: fact:product <- $w0
	;DEBUG_VALUE: fact:counter <- $w1
	;DEBUG_VALUE: fact:max_counter <- $w2
	.loc	1 5 7 prologue_end              ; fact-toc.c:5:7
	cmp	w1, w2
	b.gt	LBB0_6
Ltmp0:
; %bb.1:
	;DEBUG_VALUE: fact:max_counter <- $w2
	;DEBUG_VALUE: fact:counter <- $w1
	;DEBUG_VALUE: fact:product <- $w0
	add	w8, w2, #1
	sub	w9, w8, w1
	cmp	w9, #16
	b.lo	LBB0_5
Ltmp1:
; %bb.2:
	;DEBUG_VALUE: fact:max_counter <- $w2
	;DEBUG_VALUE: fact:counter <- $w1
	;DEBUG_VALUE: fact:product <- $w0
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
Ltmp2:
	;DEBUG_VALUE: fact:counter <- [DW_OP_LLVM_entry_value 1] $w1
	.loc	1 0 7 is_stmt 0                 ; fact-toc.c:0:7
	movi.4s	v3, #4
	movi.4s	v4, #8
	movi.4s	v5, #12
	movi.4s	v6, #16
	mov	x11, x10
	movi.4s	v7, #1
	movi.4s	v16, #1
Ltmp3:
LBB0_3:                                 ; =>This Inner Loop Header: Depth=1
	;DEBUG_VALUE: fact:counter <- [DW_OP_LLVM_entry_value 1] $w1
	;DEBUG_VALUE: fact:max_counter <- $w2
	;DEBUG_VALUE: fact:product <- $w0
	add.4s	v17, v1, v3
	add.4s	v18, v1, v4
	add.4s	v19, v1, v5
Ltmp4:
	.loc	1 8 25 is_stmt 1                ; fact-toc.c:8:25
	mul.4s	v2, v1, v2
	mul.4s	v0, v17, v0
	mul.4s	v7, v18, v7
	mul.4s	v16, v19, v16
	add.4s	v1, v1, v6
	subs	w11, w11, #16
	b.ne	LBB0_3
Ltmp5:
; %bb.4:
	;DEBUG_VALUE: fact:counter <- [DW_OP_LLVM_entry_value 1] $w1
	;DEBUG_VALUE: fact:max_counter <- $w2
	;DEBUG_VALUE: fact:product <- $w0
	.loc	1 5 7                           ; fact-toc.c:5:7
	mul.4s	v0, v0, v2
	mul.4s	v0, v7, v0
	mul.4s	v0, v16, v0
	ext.16b	v1, v0, v0, #8
	mul.2s	v0, v0, v1
	fmov	w11, s0
	mov.s	w12, v0[1]
	mul	w0, w11, w12
Ltmp6:
	;DEBUG_VALUE: fact:product <- [DW_OP_LLVM_entry_value 1] $w0
	cmp	w9, w10
	b.eq	LBB0_6
Ltmp7:
LBB0_5:                                 ; =>This Inner Loop Header: Depth=1
	;DEBUG_VALUE: fact:product <- $w0
	;DEBUG_VALUE: fact:counter <- $w1
	.loc	1 8 25                          ; fact-toc.c:8:25
	mul	w0, w1, w0
Ltmp8:
	.loc	1 8 44 is_stmt 0                ; fact-toc.c:8:44
	add	w1, w1, #1
Ltmp9:
	;DEBUG_VALUE: fact:counter <- $w1
	;DEBUG_VALUE: fact:product <- undef
	.loc	1 5 7 is_stmt 1                 ; fact-toc.c:5:7
	cmp	w8, w1
Ltmp10:
	;DEBUG_VALUE: fact:max_counter <- undef
	b.ne	LBB0_5
Ltmp11:
LBB0_6:
	.loc	1 10 1                          ; fact-toc.c:10:1
	ret
Ltmp12:
	.loh AdrpLdr	Lloh0, Lloh1
Lfunc_end0:
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
Lfunc_begin1:
	.loc	1 12 0                          ; fact-toc.c:12:0
	.cfi_startproc
; %bb.0:
	;DEBUG_VALUE: main:argc <- $w0
	;DEBUG_VALUE: main:argv <- $x1
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Ltmp13:
	.loc	1 14 12 prologue_end            ; fact-toc.c:14:12
	ldr	x0, [x1, #8]
Ltmp14:
	;DEBUG_VALUE: main:argc <- [DW_OP_LLVM_entry_value 1] $w0
	.loc	1 14 7 is_stmt 0                ; fact-toc.c:14:7
	bl	_atoi
Ltmp15:
	;DEBUG_VALUE: main:argv <- [DW_OP_LLVM_entry_value 1] $x1
	;DEBUG_VALUE: fact:counter <- 1
	;DEBUG_VALUE: fact:product <- 1
	;DEBUG_VALUE: fact:max_counter <- $w0
	;DEBUG_VALUE: main:x <- $w0
	.loc	1 5 7 is_stmt 1                 ; fact-toc.c:5:7
	cmp	w0, #1
	b.lt	LBB1_3
Ltmp16:
; %bb.1:
	;DEBUG_VALUE: main:x <- $w0
	;DEBUG_VALUE: fact:max_counter <- $w0
	;DEBUG_VALUE: fact:product <- 1
	;DEBUG_VALUE: fact:counter <- 1
	;DEBUG_VALUE: main:argv <- [DW_OP_LLVM_entry_value 1] $x1
	;DEBUG_VALUE: main:argc <- [DW_OP_LLVM_entry_value 1] $w0
	cmp	w0, #16
	b.hs	LBB1_4
Ltmp17:
; %bb.2:
	;DEBUG_VALUE: main:x <- $w0
	;DEBUG_VALUE: fact:max_counter <- $w0
	;DEBUG_VALUE: fact:product <- 1
	;DEBUG_VALUE: fact:counter <- 1
	;DEBUG_VALUE: main:argv <- [DW_OP_LLVM_entry_value 1] $x1
	;DEBUG_VALUE: main:argc <- [DW_OP_LLVM_entry_value 1] $w0
	.loc	1 0 7 is_stmt 0                 ; fact-toc.c:0:7
	mov	w8, #1
	mov	w10, #1
	b	LBB1_7
Ltmp18:
LBB1_3:
	;DEBUG_VALUE: main:x <- $w0
	;DEBUG_VALUE: fact:max_counter <- $w0
	;DEBUG_VALUE: fact:product <- 1
	;DEBUG_VALUE: fact:counter <- 1
	;DEBUG_VALUE: main:argv <- [DW_OP_LLVM_entry_value 1] $x1
	;DEBUG_VALUE: main:argc <- [DW_OP_LLVM_entry_value 1] $w0
	mov	w10, #1
	b	LBB1_9
Ltmp19:
LBB1_4:
	;DEBUG_VALUE: main:x <- $w0
	;DEBUG_VALUE: fact:max_counter <- $w0
	;DEBUG_VALUE: fact:product <- 1
	;DEBUG_VALUE: fact:counter <- 1
	;DEBUG_VALUE: main:argv <- [DW_OP_LLVM_entry_value 1] $x1
	;DEBUG_VALUE: main:argc <- [DW_OP_LLVM_entry_value 1] $w0
	.loc	1 5 7                           ; fact-toc.c:5:7
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
Ltmp20:
LBB1_5:                                 ; =>This Inner Loop Header: Depth=1
	;DEBUG_VALUE: main:x <- $w0
	;DEBUG_VALUE: fact:max_counter <- $w0
	;DEBUG_VALUE: fact:product <- 1
	;DEBUG_VALUE: fact:counter <- 1
	;DEBUG_VALUE: main:argv <- [DW_OP_LLVM_entry_value 1] $x1
	;DEBUG_VALUE: main:argc <- [DW_OP_LLVM_entry_value 1] $w0
	.loc	1 0 7                           ; fact-toc.c:0:7
	add.4s	v17, v2, v1
	add.4s	v18, v2, v3
	add.4s	v19, v2, v4
Ltmp21:
	.loc	1 8 25 is_stmt 1                ; fact-toc.c:8:25
	mul.4s	v0, v0, v2
	mul.4s	v6, v6, v17
	mul.4s	v7, v7, v18
	mul.4s	v16, v16, v19
	add.4s	v2, v2, v5
	subs	w10, w10, #16
	b.ne	LBB1_5
Ltmp22:
; %bb.6:
	;DEBUG_VALUE: main:x <- $w0
	;DEBUG_VALUE: fact:max_counter <- $w0
	;DEBUG_VALUE: fact:product <- 1
	;DEBUG_VALUE: fact:counter <- 1
	;DEBUG_VALUE: main:argv <- [DW_OP_LLVM_entry_value 1] $x1
	;DEBUG_VALUE: main:argc <- [DW_OP_LLVM_entry_value 1] $w0
	.loc	1 5 7                           ; fact-toc.c:5:7
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
Ltmp23:
LBB1_7:
	;DEBUG_VALUE: main:x <- $w0
	;DEBUG_VALUE: fact:max_counter <- $w0
	;DEBUG_VALUE: fact:product <- 1
	;DEBUG_VALUE: fact:counter <- 1
	;DEBUG_VALUE: main:argv <- [DW_OP_LLVM_entry_value 1] $x1
	;DEBUG_VALUE: main:argc <- [DW_OP_LLVM_entry_value 1] $w0
	add	w9, w0, #1
Ltmp24:
LBB1_8:                                 ; =>This Inner Loop Header: Depth=1
	;DEBUG_VALUE: main:x <- $w0
	;DEBUG_VALUE: main:argv <- [DW_OP_LLVM_entry_value 1] $x1
	;DEBUG_VALUE: main:argc <- [DW_OP_LLVM_entry_value 1] $w0
	;DEBUG_VALUE: fact:product <- $w10
	;DEBUG_VALUE: fact:counter <- $w8
	.loc	1 8 25                          ; fact-toc.c:8:25
	mul	w10, w10, w8
Ltmp25:
	.loc	1 8 44 is_stmt 0                ; fact-toc.c:8:44
	add	w8, w8, #1
Ltmp26:
	;DEBUG_VALUE: fact:counter <- $w8
	;DEBUG_VALUE: fact:product <- undef
	;DEBUG_VALUE: fact:max_counter <- undef
	.loc	1 5 7 is_stmt 1                 ; fact-toc.c:5:7
	cmp	w9, w8
	b.ne	LBB1_8
Ltmp27:
LBB1_9:
	;DEBUG_VALUE: main:x <- $w0
	;DEBUG_VALUE: main:argv <- [DW_OP_LLVM_entry_value 1] $x1
	;DEBUG_VALUE: main:argc <- [DW_OP_LLVM_entry_value 1] $w0
	;DEBUG_VALUE: main:ret <- $w10
	.loc	1 16 3                          ; fact-toc.c:16:3
	str	x10, [sp]
Lloh4:
	adrp	x0, l_.str@PAGE
Ltmp28:
Lloh5:
	add	x0, x0, l_.str@PAGEOFF
	bl	_printf
Ltmp29:
	.loc	1 17 1                          ; fact-toc.c:17:1
	mov	w0, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
Ltmp30:
	.loh AdrpLdr	Lloh2, Lloh3
	.loh AdrpAdd	Lloh4, Lloh5
Lfunc_end1:
	.cfi_endproc
	.file	2 "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include" "stdlib.h"
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"ret = %d\n"

	.section	__DWARF,__debug_loc,regular,debug
Lsection_debug_loc:
Ldebug_loc0:
.set Lset0, Lfunc_begin0-Lfunc_begin0
	.quad	Lset0
.set Lset1, Ltmp6-Lfunc_begin0
	.quad	Lset1
	.short	1                               ; Loc expr size
	.byte	80                              ; DW_OP_reg0
.set Lset2, Ltmp6-Lfunc_begin0
	.quad	Lset2
.set Lset3, Ltmp7-Lfunc_begin0
	.quad	Lset3
	.short	4                               ; Loc expr size
	.byte	163                             ; DW_OP_entry_value
	.byte	1                               ; 1
	.byte	80                              ; DW_OP_reg0
	.byte	159                             ; DW_OP_stack_value
.set Lset4, Ltmp7-Lfunc_begin0
	.quad	Lset4
.set Lset5, Ltmp8-Lfunc_begin0
	.quad	Lset5
	.short	1                               ; Loc expr size
	.byte	80                              ; DW_OP_reg0
	.quad	0
	.quad	0
Ldebug_loc1:
.set Lset6, Lfunc_begin0-Lfunc_begin0
	.quad	Lset6
.set Lset7, Ltmp2-Lfunc_begin0
	.quad	Lset7
	.short	1                               ; Loc expr size
	.byte	81                              ; DW_OP_reg1
.set Lset8, Ltmp2-Lfunc_begin0
	.quad	Lset8
.set Lset9, Ltmp7-Lfunc_begin0
	.quad	Lset9
	.short	4                               ; Loc expr size
	.byte	163                             ; DW_OP_entry_value
	.byte	1                               ; 1
	.byte	81                              ; DW_OP_reg1
	.byte	159                             ; DW_OP_stack_value
.set Lset10, Ltmp7-Lfunc_begin0
	.quad	Lset10
.set Lset11, Ltmp11-Lfunc_begin0
	.quad	Lset11
	.short	1                               ; Loc expr size
	.byte	81                              ; DW_OP_reg1
	.quad	0
	.quad	0
Ldebug_loc2:
.set Lset12, Lfunc_begin0-Lfunc_begin0
	.quad	Lset12
.set Lset13, Ltmp7-Lfunc_begin0
	.quad	Lset13
	.short	1                               ; Loc expr size
	.byte	82                              ; DW_OP_reg2
	.quad	0
	.quad	0
Ldebug_loc3:
.set Lset14, Lfunc_begin1-Lfunc_begin0
	.quad	Lset14
.set Lset15, Ltmp14-Lfunc_begin0
	.quad	Lset15
	.short	1                               ; Loc expr size
	.byte	80                              ; DW_OP_reg0
.set Lset16, Ltmp14-Lfunc_begin0
	.quad	Lset16
.set Lset17, Lfunc_end1-Lfunc_begin0
	.quad	Lset17
	.short	4                               ; Loc expr size
	.byte	163                             ; DW_OP_entry_value
	.byte	1                               ; 1
	.byte	80                              ; DW_OP_reg0
	.byte	159                             ; DW_OP_stack_value
	.quad	0
	.quad	0
Ldebug_loc4:
.set Lset18, Lfunc_begin1-Lfunc_begin0
	.quad	Lset18
.set Lset19, Ltmp15-Lfunc_begin0
	.quad	Lset19
	.short	1                               ; Loc expr size
	.byte	81                              ; DW_OP_reg1
.set Lset20, Ltmp15-Lfunc_begin0
	.quad	Lset20
.set Lset21, Lfunc_end1-Lfunc_begin0
	.quad	Lset21
	.short	4                               ; Loc expr size
	.byte	163                             ; DW_OP_entry_value
	.byte	1                               ; 1
	.byte	81                              ; DW_OP_reg1
	.byte	159                             ; DW_OP_stack_value
	.quad	0
	.quad	0
Ldebug_loc5:
.set Lset22, Ltmp15-Lfunc_begin0
	.quad	Lset22
.set Lset23, Ltmp24-Lfunc_begin0
	.quad	Lset23
	.short	3                               ; Loc expr size
	.byte	17                              ; DW_OP_consts
	.byte	1                               ; 1
	.byte	159                             ; DW_OP_stack_value
.set Lset24, Ltmp24-Lfunc_begin0
	.quad	Lset24
.set Lset25, Ltmp27-Lfunc_begin0
	.quad	Lset25
	.short	1                               ; Loc expr size
	.byte	88                              ; DW_OP_reg8
	.quad	0
	.quad	0
Ldebug_loc6:
.set Lset26, Ltmp15-Lfunc_begin0
	.quad	Lset26
.set Lset27, Ltmp24-Lfunc_begin0
	.quad	Lset27
	.short	3                               ; Loc expr size
	.byte	17                              ; DW_OP_consts
	.byte	1                               ; 1
	.byte	159                             ; DW_OP_stack_value
.set Lset28, Ltmp24-Lfunc_begin0
	.quad	Lset28
.set Lset29, Ltmp25-Lfunc_begin0
	.quad	Lset29
	.short	1                               ; Loc expr size
	.byte	90                              ; DW_OP_reg10
	.quad	0
	.quad	0
Ldebug_loc7:
.set Lset30, Ltmp15-Lfunc_begin0
	.quad	Lset30
.set Lset31, Ltmp24-Lfunc_begin0
	.quad	Lset31
	.short	1                               ; Loc expr size
	.byte	80                              ; DW_OP_reg0
	.quad	0
	.quad	0
Ldebug_loc8:
.set Lset32, Ltmp15-Lfunc_begin0
	.quad	Lset32
.set Lset33, Ltmp28-Lfunc_begin0
	.quad	Lset33
	.short	1                               ; Loc expr size
	.byte	80                              ; DW_OP_reg0
	.quad	0
	.quad	0
Ldebug_loc9:
.set Lset34, Ltmp27-Lfunc_begin0
	.quad	Lset34
.set Lset35, Ltmp29-Lfunc_begin0
	.quad	Lset35
	.short	1                               ; Loc expr size
	.byte	90                              ; DW_OP_reg10
	.quad	0
	.quad	0
	.section	__DWARF,__debug_abbrev,regular,debug
Lsection_abbrev:
	.byte	1                               ; Abbreviation Code
	.byte	17                              ; DW_TAG_compile_unit
	.byte	1                               ; DW_CHILDREN_yes
	.byte	37                              ; DW_AT_producer
	.byte	14                              ; DW_FORM_strp
	.byte	19                              ; DW_AT_language
	.byte	5                               ; DW_FORM_data2
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.ascii	"\202|"                         ; DW_AT_LLVM_sysroot
	.byte	14                              ; DW_FORM_strp
	.ascii	"\357\177"                      ; DW_AT_APPLE_sdk
	.byte	14                              ; DW_FORM_strp
	.byte	16                              ; DW_AT_stmt_list
	.byte	23                              ; DW_FORM_sec_offset
	.byte	27                              ; DW_AT_comp_dir
	.byte	14                              ; DW_FORM_strp
	.ascii	"\341\177"                      ; DW_AT_APPLE_optimized
	.byte	25                              ; DW_FORM_flag_present
	.byte	17                              ; DW_AT_low_pc
	.byte	1                               ; DW_FORM_addr
	.byte	18                              ; DW_AT_high_pc
	.byte	6                               ; DW_FORM_data4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	2                               ; Abbreviation Code
	.byte	52                              ; DW_TAG_variable
	.byte	0                               ; DW_CHILDREN_no
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	58                              ; DW_AT_decl_file
	.byte	11                              ; DW_FORM_data1
	.byte	59                              ; DW_AT_decl_line
	.byte	11                              ; DW_FORM_data1
	.byte	2                               ; DW_AT_location
	.byte	24                              ; DW_FORM_exprloc
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	3                               ; Abbreviation Code
	.byte	1                               ; DW_TAG_array_type
	.byte	1                               ; DW_CHILDREN_yes
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	4                               ; Abbreviation Code
	.byte	33                              ; DW_TAG_subrange_type
	.byte	0                               ; DW_CHILDREN_no
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	55                              ; DW_AT_count
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	5                               ; Abbreviation Code
	.byte	36                              ; DW_TAG_base_type
	.byte	0                               ; DW_CHILDREN_no
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	62                              ; DW_AT_encoding
	.byte	11                              ; DW_FORM_data1
	.byte	11                              ; DW_AT_byte_size
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	6                               ; Abbreviation Code
	.byte	36                              ; DW_TAG_base_type
	.byte	0                               ; DW_CHILDREN_no
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	11                              ; DW_AT_byte_size
	.byte	11                              ; DW_FORM_data1
	.byte	62                              ; DW_AT_encoding
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	7                               ; Abbreviation Code
	.byte	46                              ; DW_TAG_subprogram
	.byte	1                               ; DW_CHILDREN_yes
	.byte	17                              ; DW_AT_low_pc
	.byte	1                               ; DW_FORM_addr
	.byte	18                              ; DW_AT_high_pc
	.byte	6                               ; DW_FORM_data4
	.ascii	"\347\177"                      ; DW_AT_APPLE_omit_frame_ptr
	.byte	25                              ; DW_FORM_flag_present
	.byte	64                              ; DW_AT_frame_base
	.byte	24                              ; DW_FORM_exprloc
	.byte	122                             ; DW_AT_call_all_calls
	.byte	25                              ; DW_FORM_flag_present
	.byte	49                              ; DW_AT_abstract_origin
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	8                               ; Abbreviation Code
	.byte	5                               ; DW_TAG_formal_parameter
	.byte	0                               ; DW_CHILDREN_no
	.byte	2                               ; DW_AT_location
	.byte	23                              ; DW_FORM_sec_offset
	.byte	49                              ; DW_AT_abstract_origin
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	9                               ; Abbreviation Code
	.byte	46                              ; DW_TAG_subprogram
	.byte	1                               ; DW_CHILDREN_yes
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	58                              ; DW_AT_decl_file
	.byte	11                              ; DW_FORM_data1
	.byte	59                              ; DW_AT_decl_line
	.byte	11                              ; DW_FORM_data1
	.byte	39                              ; DW_AT_prototyped
	.byte	25                              ; DW_FORM_flag_present
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	63                              ; DW_AT_external
	.byte	25                              ; DW_FORM_flag_present
	.ascii	"\341\177"                      ; DW_AT_APPLE_optimized
	.byte	25                              ; DW_FORM_flag_present
	.byte	32                              ; DW_AT_inline
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	10                              ; Abbreviation Code
	.byte	5                               ; DW_TAG_formal_parameter
	.byte	0                               ; DW_CHILDREN_no
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	58                              ; DW_AT_decl_file
	.byte	11                              ; DW_FORM_data1
	.byte	59                              ; DW_AT_decl_line
	.byte	11                              ; DW_FORM_data1
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	11                              ; Abbreviation Code
	.byte	46                              ; DW_TAG_subprogram
	.byte	1                               ; DW_CHILDREN_yes
	.byte	17                              ; DW_AT_low_pc
	.byte	1                               ; DW_FORM_addr
	.byte	18                              ; DW_AT_high_pc
	.byte	6                               ; DW_FORM_data4
	.byte	64                              ; DW_AT_frame_base
	.byte	24                              ; DW_FORM_exprloc
	.byte	122                             ; DW_AT_call_all_calls
	.byte	25                              ; DW_FORM_flag_present
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	58                              ; DW_AT_decl_file
	.byte	11                              ; DW_FORM_data1
	.byte	59                              ; DW_AT_decl_line
	.byte	11                              ; DW_FORM_data1
	.byte	39                              ; DW_AT_prototyped
	.byte	25                              ; DW_FORM_flag_present
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	63                              ; DW_AT_external
	.byte	25                              ; DW_FORM_flag_present
	.ascii	"\341\177"                      ; DW_AT_APPLE_optimized
	.byte	25                              ; DW_FORM_flag_present
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	12                              ; Abbreviation Code
	.byte	5                               ; DW_TAG_formal_parameter
	.byte	0                               ; DW_CHILDREN_no
	.byte	2                               ; DW_AT_location
	.byte	23                              ; DW_FORM_sec_offset
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	58                              ; DW_AT_decl_file
	.byte	11                              ; DW_FORM_data1
	.byte	59                              ; DW_AT_decl_line
	.byte	11                              ; DW_FORM_data1
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	13                              ; Abbreviation Code
	.byte	52                              ; DW_TAG_variable
	.byte	0                               ; DW_CHILDREN_no
	.byte	2                               ; DW_AT_location
	.byte	23                              ; DW_FORM_sec_offset
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	58                              ; DW_AT_decl_file
	.byte	11                              ; DW_FORM_data1
	.byte	59                              ; DW_AT_decl_line
	.byte	11                              ; DW_FORM_data1
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	14                              ; Abbreviation Code
	.byte	29                              ; DW_TAG_inlined_subroutine
	.byte	1                               ; DW_CHILDREN_yes
	.byte	49                              ; DW_AT_abstract_origin
	.byte	19                              ; DW_FORM_ref4
	.byte	17                              ; DW_AT_low_pc
	.byte	1                               ; DW_FORM_addr
	.byte	18                              ; DW_AT_high_pc
	.byte	6                               ; DW_FORM_data4
	.byte	88                              ; DW_AT_call_file
	.byte	11                              ; DW_FORM_data1
	.byte	89                              ; DW_AT_call_line
	.byte	11                              ; DW_FORM_data1
	.byte	87                              ; DW_AT_call_column
	.byte	11                              ; DW_FORM_data1
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	15                              ; Abbreviation Code
	.byte	72                              ; DW_TAG_call_site
	.byte	0                               ; DW_CHILDREN_no
	.byte	127                             ; DW_AT_call_origin
	.byte	19                              ; DW_FORM_ref4
	.byte	125                             ; DW_AT_call_return_pc
	.byte	1                               ; DW_FORM_addr
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	16                              ; Abbreviation Code
	.byte	46                              ; DW_TAG_subprogram
	.byte	1                               ; DW_CHILDREN_yes
	.byte	3                               ; DW_AT_name
	.byte	14                              ; DW_FORM_strp
	.byte	58                              ; DW_AT_decl_file
	.byte	11                              ; DW_FORM_data1
	.byte	59                              ; DW_AT_decl_line
	.byte	11                              ; DW_FORM_data1
	.byte	39                              ; DW_AT_prototyped
	.byte	25                              ; DW_FORM_flag_present
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	60                              ; DW_AT_declaration
	.byte	25                              ; DW_FORM_flag_present
	.byte	63                              ; DW_AT_external
	.byte	25                              ; DW_FORM_flag_present
	.ascii	"\341\177"                      ; DW_AT_APPLE_optimized
	.byte	25                              ; DW_FORM_flag_present
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	17                              ; Abbreviation Code
	.byte	5                               ; DW_TAG_formal_parameter
	.byte	0                               ; DW_CHILDREN_no
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	18                              ; Abbreviation Code
	.byte	15                              ; DW_TAG_pointer_type
	.byte	0                               ; DW_CHILDREN_no
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	19                              ; Abbreviation Code
	.byte	38                              ; DW_TAG_const_type
	.byte	0                               ; DW_CHILDREN_no
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	0                               ; EOM(3)
	.section	__DWARF,__debug_info,regular,debug
Lsection_info:
Lcu_begin0:
.set Lset36, Ldebug_info_end0-Ldebug_info_start0 ; Length of Unit
	.long	Lset36
Ldebug_info_start0:
	.short	4                               ; DWARF version number
.set Lset37, Lsection_abbrev-Lsection_abbrev ; Offset Into Abbrev. Section
	.long	Lset37
	.byte	8                               ; Address Size (in bytes)
	.byte	1                               ; Abbrev [1] 0xb:0x16f DW_TAG_compile_unit
	.long	0                               ; DW_AT_producer
	.short	12                              ; DW_AT_language
	.long	46                              ; DW_AT_name
	.long	57                              ; DW_AT_LLVM_sysroot
	.long	109                             ; DW_AT_APPLE_sdk
.set Lset38, Lline_table_start0-Lsection_line ; DW_AT_stmt_list
	.long	Lset38
	.long	120                             ; DW_AT_comp_dir
                                        ; DW_AT_APPLE_optimized
	.quad	Lfunc_begin0                    ; DW_AT_low_pc
.set Lset39, Lfunc_end1-Lfunc_begin0    ; DW_AT_high_pc
	.long	Lset39
	.byte	2                               ; Abbrev [2] 0x32:0x11 DW_TAG_variable
	.long	67                              ; DW_AT_type
	.byte	1                               ; DW_AT_decl_file
	.byte	16                              ; DW_AT_decl_line
	.byte	9                               ; DW_AT_location
	.byte	3
	.quad	l_.str
	.byte	3                               ; Abbrev [3] 0x43:0xc DW_TAG_array_type
	.long	79                              ; DW_AT_type
	.byte	4                               ; Abbrev [4] 0x48:0x6 DW_TAG_subrange_type
	.long	86                              ; DW_AT_type
	.byte	10                              ; DW_AT_count
	.byte	0                               ; End Of Children Mark
	.byte	5                               ; Abbrev [5] 0x4f:0x7 DW_TAG_base_type
	.long	165                             ; DW_AT_name
	.byte	6                               ; DW_AT_encoding
	.byte	1                               ; DW_AT_byte_size
	.byte	6                               ; Abbrev [6] 0x56:0x7 DW_TAG_base_type
	.long	170                             ; DW_AT_name
	.byte	8                               ; DW_AT_byte_size
	.byte	7                               ; DW_AT_encoding
	.byte	7                               ; Abbrev [7] 0x5d:0x2f DW_TAG_subprogram
	.quad	Lfunc_begin0                    ; DW_AT_low_pc
.set Lset40, Lfunc_end0-Lfunc_begin0    ; DW_AT_high_pc
	.long	Lset40
                                        ; DW_AT_APPLE_omit_frame_ptr
	.byte	1                               ; DW_AT_frame_base
	.byte	111
                                        ; DW_AT_call_all_calls
	.long	140                             ; DW_AT_abstract_origin
	.byte	8                               ; Abbrev [8] 0x70:0x9 DW_TAG_formal_parameter
.set Lset41, Ldebug_loc0-Lsection_debug_loc ; DW_AT_location
	.long	Lset41
	.long	152                             ; DW_AT_abstract_origin
	.byte	8                               ; Abbrev [8] 0x79:0x9 DW_TAG_formal_parameter
.set Lset42, Ldebug_loc1-Lsection_debug_loc ; DW_AT_location
	.long	Lset42
	.long	163                             ; DW_AT_abstract_origin
	.byte	8                               ; Abbrev [8] 0x82:0x9 DW_TAG_formal_parameter
.set Lset43, Ldebug_loc2-Lsection_debug_loc ; DW_AT_location
	.long	Lset43
	.long	174                             ; DW_AT_abstract_origin
	.byte	0                               ; End Of Children Mark
	.byte	9                               ; Abbrev [9] 0x8c:0x2e DW_TAG_subprogram
	.long	191                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	4                               ; DW_AT_decl_line
                                        ; DW_AT_prototyped
	.long	186                             ; DW_AT_type
                                        ; DW_AT_external
                                        ; DW_AT_APPLE_optimized
	.byte	1                               ; DW_AT_inline
	.byte	10                              ; Abbrev [10] 0x98:0xb DW_TAG_formal_parameter
	.long	200                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	4                               ; DW_AT_decl_line
	.long	186                             ; DW_AT_type
	.byte	10                              ; Abbrev [10] 0xa3:0xb DW_TAG_formal_parameter
	.long	208                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	4                               ; DW_AT_decl_line
	.long	186                             ; DW_AT_type
	.byte	10                              ; Abbrev [10] 0xae:0xb DW_TAG_formal_parameter
	.long	216                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	4                               ; DW_AT_decl_line
	.long	186                             ; DW_AT_type
	.byte	0                               ; End Of Children Mark
	.byte	5                               ; Abbrev [5] 0xba:0x7 DW_TAG_base_type
	.long	196                             ; DW_AT_name
	.byte	5                               ; DW_AT_encoding
	.byte	4                               ; DW_AT_byte_size
	.byte	11                              ; Abbrev [11] 0xc1:0x93 DW_TAG_subprogram
	.quad	Lfunc_begin1                    ; DW_AT_low_pc
.set Lset44, Lfunc_end1-Lfunc_begin1    ; DW_AT_high_pc
	.long	Lset44
	.byte	1                               ; DW_AT_frame_base
	.byte	109
                                        ; DW_AT_call_all_calls
	.long	228                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	12                              ; DW_AT_decl_line
                                        ; DW_AT_prototyped
	.long	186                             ; DW_AT_type
                                        ; DW_AT_external
                                        ; DW_AT_APPLE_optimized
	.byte	12                              ; Abbrev [12] 0xda:0xf DW_TAG_formal_parameter
.set Lset45, Ldebug_loc3-Lsection_debug_loc ; DW_AT_location
	.long	Lset45
	.long	238                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	12                              ; DW_AT_decl_line
	.long	186                             ; DW_AT_type
	.byte	12                              ; Abbrev [12] 0xe9:0xf DW_TAG_formal_parameter
.set Lset46, Ldebug_loc4-Lsection_debug_loc ; DW_AT_location
	.long	Lset46
	.long	243                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	12                              ; DW_AT_decl_line
	.long	367                             ; DW_AT_type
	.byte	13                              ; Abbrev [13] 0xf8:0xf DW_TAG_variable
.set Lset47, Ldebug_loc8-Lsection_debug_loc ; DW_AT_location
	.long	Lset47
	.long	248                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	13                              ; DW_AT_decl_line
	.long	186                             ; DW_AT_type
	.byte	13                              ; Abbrev [13] 0x107:0xf DW_TAG_variable
.set Lset48, Ldebug_loc9-Lsection_debug_loc ; DW_AT_location
	.long	Lset48
	.long	250                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	13                              ; DW_AT_decl_line
	.long	186                             ; DW_AT_type
	.byte	14                              ; Abbrev [14] 0x116:0x30 DW_TAG_inlined_subroutine
	.long	140                             ; DW_AT_abstract_origin
	.quad	Ltmp15                          ; DW_AT_low_pc
.set Lset49, Ltmp27-Ltmp15              ; DW_AT_high_pc
	.long	Lset49
	.byte	1                               ; DW_AT_call_file
	.byte	15                              ; DW_AT_call_line
	.byte	9                               ; DW_AT_call_column
	.byte	8                               ; Abbrev [8] 0x12a:0x9 DW_TAG_formal_parameter
.set Lset50, Ldebug_loc6-Lsection_debug_loc ; DW_AT_location
	.long	Lset50
	.long	152                             ; DW_AT_abstract_origin
	.byte	8                               ; Abbrev [8] 0x133:0x9 DW_TAG_formal_parameter
.set Lset51, Ldebug_loc5-Lsection_debug_loc ; DW_AT_location
	.long	Lset51
	.long	163                             ; DW_AT_abstract_origin
	.byte	8                               ; Abbrev [8] 0x13c:0x9 DW_TAG_formal_parameter
.set Lset52, Ldebug_loc7-Lsection_debug_loc ; DW_AT_location
	.long	Lset52
	.long	174                             ; DW_AT_abstract_origin
	.byte	0                               ; End Of Children Mark
	.byte	15                              ; Abbrev [15] 0x146:0xd DW_TAG_call_site
	.long	340                             ; DW_AT_call_origin
	.quad	Ltmp15                          ; DW_AT_call_return_pc
	.byte	0                               ; End Of Children Mark
	.byte	16                              ; Abbrev [16] 0x154:0x11 DW_TAG_subprogram
	.long	233                             ; DW_AT_name
	.byte	2                               ; DW_AT_decl_file
	.byte	135                             ; DW_AT_decl_line
                                        ; DW_AT_prototyped
	.long	186                             ; DW_AT_type
                                        ; DW_AT_declaration
                                        ; DW_AT_external
                                        ; DW_AT_APPLE_optimized
	.byte	17                              ; Abbrev [17] 0x15f:0x5 DW_TAG_formal_parameter
	.long	357                             ; DW_AT_type
	.byte	0                               ; End Of Children Mark
	.byte	18                              ; Abbrev [18] 0x165:0x5 DW_TAG_pointer_type
	.long	362                             ; DW_AT_type
	.byte	19                              ; Abbrev [19] 0x16a:0x5 DW_TAG_const_type
	.long	79                              ; DW_AT_type
	.byte	18                              ; Abbrev [18] 0x16f:0x5 DW_TAG_pointer_type
	.long	372                             ; DW_AT_type
	.byte	18                              ; Abbrev [18] 0x174:0x5 DW_TAG_pointer_type
	.long	79                              ; DW_AT_type
	.byte	0                               ; End Of Children Mark
Ldebug_info_end0:
	.section	__DWARF,__debug_str,regular,debug
Linfo_string:
	.asciz	"Apple clang version 15.0.0 (clang-1500.3.9.4)" ; string offset=0
	.asciz	"fact-toc.c"                    ; string offset=46
	.asciz	"/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk" ; string offset=57
	.asciz	"MacOSX.sdk"                    ; string offset=109
	.asciz	"/Users/yosukemaeda/Code/Mech/Class/Soft2/3rd" ; string offset=120
	.asciz	"char"                          ; string offset=165
	.asciz	"__ARRAY_SIZE_TYPE__"           ; string offset=170
	.byte	0                               ; string offset=190
	.asciz	"fact"                          ; string offset=191
	.asciz	"int"                           ; string offset=196
	.asciz	"product"                       ; string offset=200
	.asciz	"counter"                       ; string offset=208
	.asciz	"max_counter"                   ; string offset=216
	.asciz	"main"                          ; string offset=228
	.asciz	"atoi"                          ; string offset=233
	.asciz	"argc"                          ; string offset=238
	.asciz	"argv"                          ; string offset=243
	.asciz	"x"                             ; string offset=248
	.asciz	"ret"                           ; string offset=250
	.section	__DWARF,__apple_names,regular,debug
Lnames_begin:
	.long	1212240712                      ; Header Magic
	.short	1                               ; Header Version
	.short	0                               ; Header Hash Function
	.long	3                               ; Header Bucket Count
	.long	3                               ; Header Hash Count
	.long	12                              ; Header Data Length
	.long	0                               ; HeaderData Die Offset Base
	.long	1                               ; HeaderData Atom Count
	.short	1                               ; DW_ATOM_die_offset
	.short	6                               ; DW_FORM_data4
	.long	-1                              ; Bucket 0
	.long	0                               ; Bucket 1
	.long	2                               ; Bucket 2
	.long	2090248195                      ; Hash in Bucket 1
	.long	2090499946                      ; Hash in Bucket 1
	.long	5381                            ; Hash in Bucket 2
.set Lset53, LNames0-Lnames_begin       ; Offset in Bucket 1
	.long	Lset53
.set Lset54, LNames1-Lnames_begin       ; Offset in Bucket 1
	.long	Lset54
.set Lset55, LNames2-Lnames_begin       ; Offset in Bucket 2
	.long	Lset55
LNames0:
	.long	191                             ; fact
	.long	2                               ; Num DIEs
	.long	93
	.long	278
	.long	0
LNames1:
	.long	228                             ; main
	.long	1                               ; Num DIEs
	.long	193
	.long	0
LNames2:
	.long	190                             ; 
	.long	1                               ; Num DIEs
	.long	50
	.long	0
	.section	__DWARF,__apple_objc,regular,debug
Lobjc_begin:
	.long	1212240712                      ; Header Magic
	.short	1                               ; Header Version
	.short	0                               ; Header Hash Function
	.long	1                               ; Header Bucket Count
	.long	0                               ; Header Hash Count
	.long	12                              ; Header Data Length
	.long	0                               ; HeaderData Die Offset Base
	.long	1                               ; HeaderData Atom Count
	.short	1                               ; DW_ATOM_die_offset
	.short	6                               ; DW_FORM_data4
	.long	-1                              ; Bucket 0
	.section	__DWARF,__apple_namespac,regular,debug
Lnamespac_begin:
	.long	1212240712                      ; Header Magic
	.short	1                               ; Header Version
	.short	0                               ; Header Hash Function
	.long	1                               ; Header Bucket Count
	.long	0                               ; Header Hash Count
	.long	12                              ; Header Data Length
	.long	0                               ; HeaderData Die Offset Base
	.long	1                               ; HeaderData Atom Count
	.short	1                               ; DW_ATOM_die_offset
	.short	6                               ; DW_FORM_data4
	.long	-1                              ; Bucket 0
	.section	__DWARF,__apple_types,regular,debug
Ltypes_begin:
	.long	1212240712                      ; Header Magic
	.short	1                               ; Header Version
	.short	0                               ; Header Hash Function
	.long	3                               ; Header Bucket Count
	.long	3                               ; Header Hash Count
	.long	20                              ; Header Data Length
	.long	0                               ; HeaderData Die Offset Base
	.long	3                               ; HeaderData Atom Count
	.short	1                               ; DW_ATOM_die_offset
	.short	6                               ; DW_FORM_data4
	.short	3                               ; DW_ATOM_die_tag
	.short	5                               ; DW_FORM_data2
	.short	4                               ; DW_ATOM_type_flags
	.short	11                              ; DW_FORM_data1
	.long	-1                              ; Bucket 0
	.long	-1                              ; Bucket 1
	.long	0                               ; Bucket 2
	.long	193495088                       ; Hash in Bucket 2
	.long	2090147939                      ; Hash in Bucket 2
	.long	-594775205                      ; Hash in Bucket 2
.set Lset56, Ltypes0-Ltypes_begin       ; Offset in Bucket 2
	.long	Lset56
.set Lset57, Ltypes1-Ltypes_begin       ; Offset in Bucket 2
	.long	Lset57
.set Lset58, Ltypes2-Ltypes_begin       ; Offset in Bucket 2
	.long	Lset58
Ltypes0:
	.long	196                             ; int
	.long	1                               ; Num DIEs
	.long	186
	.short	36
	.byte	0
	.long	0
Ltypes1:
	.long	165                             ; char
	.long	1                               ; Num DIEs
	.long	79
	.short	36
	.byte	0
	.long	0
Ltypes2:
	.long	170                             ; __ARRAY_SIZE_TYPE__
	.long	1                               ; Num DIEs
	.long	86
	.short	36
	.byte	0
	.long	0
.subsections_via_symbols
	.section	__DWARF,__debug_line,regular,debug
Lsection_line:
Lline_table_start0:
