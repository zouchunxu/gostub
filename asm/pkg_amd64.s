#include "go_asm.h"
#include "textflag.h"
#include "funcdata.h"

GLOBL ·Id(SB),8,$8

DATA ·Id+0(SB)/1,$0x37
DATA ·Id+1(SB)/1,$0x25
DATA ·Id+2(SB)/1,$0x00
DATA ·Id+3(SB)/1,$0x00
DATA ·Id+4(SB)/1,$0x00
DATA ·Id+5(SB)/1,$0x00
DATA ·Id+6(SB)/1,$0x00
DATA ·Id+7(SB)/1,$0x00

GLOBL ·Name(SB),16,$24

DATA ·Name+0(SB)/8,$·Name+16(SB)
DATA ·Name+8(SB)/8,$6
DATA ·Name+16(SB)/8,$"gopher"


// System V AMD64 ABI
// func AsmCallCAdd(cfun uintptr, a, b int64) int64
TEXT ·AsmCallCAdd(SB), NOSPLIT, $0
    MOVQ cfun+0(FP), AX // cfun
    MOVQ a+8(FP),    DI // a
    MOVQ b+16(FP),   SI // b
    CALL AX
    MOVQ AX, ret+24(FP)
    RET
