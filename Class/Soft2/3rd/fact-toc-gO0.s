	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 4
	.file	1 "/Users/yosukemaeda/Code/Mech/Class/Soft2/3rd" "fact-toc.c"
	.globl	_fact                           ; -- Begin function fact
	.p2align	2
_fact:                                  ; @fact
Lfunc_begin0:
	.loc	1 4 0                           ; fact-toc.c:4:0
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	w0, [sp, #8]
	str	w1, [sp, #4]
	str	w2, [sp]
Ltmp0:
	.loc	1 5 7 prologue_end              ; fact-toc.c:5:7
	ldr	w8, [sp, #4]
	.loc	1 5 17 is_stmt 0                ; fact-toc.c:5:17
	ldr	w9, [sp]
	.loc	1 5 15                          ; fact-toc.c:5:15
	subs	w8, w8, w9
	cset	w8, le
Ltmp1:
	.loc	1 5 7                           ; fact-toc.c:5:7
	tbnz	w8, #0, LBB0_2
	b	LBB0_1
LBB0_1:
Ltmp2:
	.loc	1 6 12 is_stmt 1                ; fact-toc.c:6:12
	ldr	w8, [sp, #8]
	.loc	1 6 5 is_stmt 0                 ; fact-toc.c:6:5
	stur	w8, [x29, #-4]
	b	LBB0_3
Ltmp3:
LBB0_2:
	.loc	1 8 17 is_stmt 1                ; fact-toc.c:8:17 : counter
	ldr	w8, [sp, #4]
	.loc	1 8 27 is_stmt 0                ; fact-toc.c:8:27 : product
	ldr	w9, [sp, #8]
	.loc	1 8 25                          ; fact-toc.c:8:25 : counter * product
	mul	w0, w8, w9
	.loc	1 8 36                          ; fact-toc.c:8:36 : counter
	ldr	w8, [sp, #4]
	.loc	1 8 44                          ; fact-toc.c:8:44 : counter + 1
	add	w1, w8, #1
	.loc	1 8 49                          ; fact-toc.c:8:49 : max_counter
	ldr	w2, [sp]
	.loc	1 8 12                          ; fact-toc.c:8:12 : fact()
	bl	_fact
	.loc	1 8 5                           ; fact-toc.c:8:5 : return
	stur	w0, [x29, #-4]
	b	LBB0_3
Ltmp4:
LBB0_3:
	.loc	1 10 1 is_stmt 1                ; fact-toc.c:10:1
	ldur	w0, [x29, #-4]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
Ltmp5:
Lfunc_end0:
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
Lfunc_begin1:
	.loc	1 12 0                          ; fact-toc.c:12:0
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	w0, [x29, #-4]
	str	x1, [sp, #16]
Ltmp6:
	.loc	1 14 12 prologue_end            ; fact-toc.c:14:12
	ldr	x8, [sp, #16]
	ldr	x0, [x8, #8]
	.loc	1 14 7 is_stmt 0                ; fact-toc.c:14:7
	bl	_atoi
	.loc	1 14 5                          ; fact-toc.c:14:5
	str	w0, [sp, #12]
	.loc	1 15 20 is_stmt 1               ; fact-toc.c:15:20
	ldr	w2, [sp, #12]
	mov	w1, #1
	.loc	1 15 9 is_stmt 0                ; fact-toc.c:15:9
	mov	x0, x1
	bl	_fact
	.loc	1 15 7                          ; fact-toc.c:15:7
	str	w0, [sp, #8]
	.loc	1 16 24 is_stmt 1               ; fact-toc.c:16:24
	ldr	w9, [sp, #8]
                                        ; implicit-def: $x8
	mov	x8, x9
	.loc	1 16 3 is_stmt 0                ; fact-toc.c:16:3
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str@PAGE
	add	x0, x0, l_.str@PAGEOFF
	bl	_printf
	mov	w0, #0
	.loc	1 17 1 is_stmt 1                ; fact-toc.c:17:1
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
Ltmp7:
Lfunc_end1:
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"ret = %d\n"

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
	.byte	64                              ; DW_AT_frame_base
	.byte	24                              ; DW_FORM_exprloc
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
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	8                               ; Abbreviation Code
	.byte	5                               ; DW_TAG_formal_parameter
	.byte	0                               ; DW_CHILDREN_no
	.byte	2                               ; DW_AT_location
	.byte	24                              ; DW_FORM_exprloc
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
	.byte	9                               ; Abbreviation Code
	.byte	52                              ; DW_TAG_variable
	.byte	0                               ; DW_CHILDREN_no
	.byte	2                               ; DW_AT_location
	.byte	24                              ; DW_FORM_exprloc
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
	.byte	10                              ; Abbreviation Code
	.byte	15                              ; DW_TAG_pointer_type
	.byte	0                               ; DW_CHILDREN_no
	.byte	73                              ; DW_AT_type
	.byte	19                              ; DW_FORM_ref4
	.byte	0                               ; EOM(1)
	.byte	0                               ; EOM(2)
	.byte	0                               ; EOM(3)
	.section	__DWARF,__debug_info,regular,debug
Lsection_info:
Lcu_begin0:
.set Lset0, Ldebug_info_end0-Ldebug_info_start0 ; Length of Unit
	.long	Lset0
Ldebug_info_start0:
	.short	4                               ; DWARF version number
.set Lset1, Lsection_abbrev-Lsection_abbrev ; Offset Into Abbrev. Section
	.long	Lset1
	.byte	8                               ; Address Size (in bytes)
	.byte	1                               ; Abbrev [1] 0xb:0xfa DW_TAG_compile_unit
	.long	0                               ; DW_AT_producer
	.short	12                              ; DW_AT_language
	.long	46                              ; DW_AT_name
	.long	57                              ; DW_AT_LLVM_sysroot
	.long	109                             ; DW_AT_APPLE_sdk
.set Lset2, Lline_table_start0-Lsection_line ; DW_AT_stmt_list
	.long	Lset2
	.long	120                             ; DW_AT_comp_dir
	.quad	Lfunc_begin0                    ; DW_AT_low_pc
.set Lset3, Lfunc_end1-Lfunc_begin0     ; DW_AT_high_pc
	.long	Lset3
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
	.byte	7                               ; Abbrev [7] 0x5d:0x44 DW_TAG_subprogram
	.quad	Lfunc_begin0                    ; DW_AT_low_pc
.set Lset4, Lfunc_end0-Lfunc_begin0     ; DW_AT_high_pc
	.long	Lset4
	.byte	1                               ; DW_AT_frame_base
	.byte	109
	.long	191                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	4                               ; DW_AT_decl_line
                                        ; DW_AT_prototyped
	.long	243                             ; DW_AT_type
                                        ; DW_AT_external
	.byte	8                               ; Abbrev [8] 0x76:0xe DW_TAG_formal_parameter
	.byte	2                               ; DW_AT_location
	.byte	143
	.byte	8
	.long	205                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	4                               ; DW_AT_decl_line
	.long	243                             ; DW_AT_type
	.byte	8                               ; Abbrev [8] 0x84:0xe DW_TAG_formal_parameter
	.byte	2                               ; DW_AT_location
	.byte	143
	.byte	4
	.long	213                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	4                               ; DW_AT_decl_line
	.long	243                             ; DW_AT_type
	.byte	8                               ; Abbrev [8] 0x92:0xe DW_TAG_formal_parameter
	.byte	2                               ; DW_AT_location
	.byte	143
	.byte	0
	.long	221                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	4                               ; DW_AT_decl_line
	.long	243                             ; DW_AT_type
	.byte	0                               ; End Of Children Mark
	.byte	7                               ; Abbrev [7] 0xa1:0x52 DW_TAG_subprogram
	.quad	Lfunc_begin1                    ; DW_AT_low_pc
.set Lset5, Lfunc_end1-Lfunc_begin1     ; DW_AT_high_pc
	.long	Lset5
	.byte	1                               ; DW_AT_frame_base
	.byte	109
	.long	196                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	12                              ; DW_AT_decl_line
                                        ; DW_AT_prototyped
	.long	243                             ; DW_AT_type
                                        ; DW_AT_external
	.byte	8                               ; Abbrev [8] 0xba:0xe DW_TAG_formal_parameter
	.byte	2                               ; DW_AT_location
	.byte	145
	.byte	124
	.long	233                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	12                              ; DW_AT_decl_line
	.long	243                             ; DW_AT_type
	.byte	8                               ; Abbrev [8] 0xc8:0xe DW_TAG_formal_parameter
	.byte	2                               ; DW_AT_location
	.byte	143
	.byte	16
	.long	238                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	12                              ; DW_AT_decl_line
	.long	250                             ; DW_AT_type
	.byte	9                               ; Abbrev [9] 0xd6:0xe DW_TAG_variable
	.byte	2                               ; DW_AT_location
	.byte	143
	.byte	12
	.long	243                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	13                              ; DW_AT_decl_line
	.long	243                             ; DW_AT_type
	.byte	9                               ; Abbrev [9] 0xe4:0xe DW_TAG_variable
	.byte	2                               ; DW_AT_location
	.byte	143
	.byte	8
	.long	245                             ; DW_AT_name
	.byte	1                               ; DW_AT_decl_file
	.byte	13                              ; DW_AT_decl_line
	.long	243                             ; DW_AT_type
	.byte	0                               ; End Of Children Mark
	.byte	5                               ; Abbrev [5] 0xf3:0x7 DW_TAG_base_type
	.long	201                             ; DW_AT_name
	.byte	5                               ; DW_AT_encoding
	.byte	4                               ; DW_AT_byte_size
	.byte	10                              ; Abbrev [10] 0xfa:0x5 DW_TAG_pointer_type
	.long	255                             ; DW_AT_type
	.byte	10                              ; Abbrev [10] 0xff:0x5 DW_TAG_pointer_type
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
	.asciz	"main"                          ; string offset=196
	.asciz	"int"                           ; string offset=201
	.asciz	"product"                       ; string offset=205
	.asciz	"counter"                       ; string offset=213
	.asciz	"max_counter"                   ; string offset=221
	.asciz	"argc"                          ; string offset=233
	.asciz	"argv"                          ; string offset=238
	.asciz	"x"                             ; string offset=243
	.asciz	"ret"                           ; string offset=245
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
.set Lset6, LNames0-Lnames_begin        ; Offset in Bucket 1
	.long	Lset6
.set Lset7, LNames1-Lnames_begin        ; Offset in Bucket 1
	.long	Lset7
.set Lset8, LNames2-Lnames_begin        ; Offset in Bucket 2
	.long	Lset8
LNames0:
	.long	191                             ; fact
	.long	1                               ; Num DIEs
	.long	93
	.long	0
LNames1:
	.long	196                             ; main
	.long	1                               ; Num DIEs
	.long	161
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
.set Lset9, Ltypes0-Ltypes_begin        ; Offset in Bucket 2
	.long	Lset9
.set Lset10, Ltypes1-Ltypes_begin       ; Offset in Bucket 2
	.long	Lset10
.set Lset11, Ltypes2-Ltypes_begin       ; Offset in Bucket 2
	.long	Lset11
Ltypes0:
	.long	201                             ; int
	.long	1                               ; Num DIEs
	.long	243
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
