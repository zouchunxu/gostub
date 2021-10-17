#include "go_asm.h"
#include "textflag.h"

GLOBL ·num(SB),8,$16
DATA ·num+0(SB)/8,$1
DATA ·num+8(SB)/8,$0

GLOBL ·boolValue(SB),8,$1

GLOBL ·trueValue(SB),8,$1
DATA ·trueValue+0(SB)/1,$1

GLOBL ·falseValue(SB),8,$1
DATA ·falseValue(SB)/1,$0

GLOBL ·int32Value(SB),8,$4
DATA ·int32Value+0(SB)/1,$0x01  // 第0字节
DATA ·int32Value+1(SB)/1,$0x02  // 第1字节
DATA ·int32Value+2(SB)/2,$0x03  // 第3-4字节

TEXT ·Add(SB), $0-24
    MOVQ arg1+0(FP), CX
    MOVQ arg2+8(FP), BP
    ADDQ CX, BP
    MOVQ BP, result+16(FP)
    RET

TEXT ·Swap(SB),$8-32
    MOVQ a+0(FP), AX     // AX = a
    MOVQ AX,t-8(SP)
    ADDQ t-8(SP),AX
    MOVQ b+8(FP), BX     // BX = b
    MOVQ BX, ret0+16(FP) // ret0 = BX
    MOVQ AX, ret1+24(FP) // ret1 = AX
    RET

TEXT ·main(SB),$24-0
    MOVQ $0, a-8*2(SP) // a = 0
    MOVQ $0, a-8*1(SP) // b = 0
    MOVQ $10,AX
    MOVQ AX,a-8*2(SP)

    MOVQ AX,0(SP)
    CALL ·output2(SB)

    MOVQ a-8*2(SP), AX
    MOVQ a-8*1(SP), BX

    MOVQ AX,BX
    ADDQ BX,BX
    IMULQ AX,BX
    MOVQ BX,b-8*1(SP)

    MOVQ BX,0(SP)
    MOVQ BX,8(SP)
    CALL ·output2(SB)


    MOVQ $0,0(SP)
    MOVQ $2,8(SP)
    MOVQ $3,16(SP)
    CALL ·If(SB)

    MOVQ 24(SP),AX
    MOVQ AX,0(SP)
    CALL ·output(SB)
    RET

TEXT ·If(SB),NOSPLIT,$0-32
    MOVQ ok+8*0(FP), CX
    MOVQ a+8*1(FP), AX
    MOVQ b+8*2(FP), BX

    CMPQ CX,$0
    JZ L
    MOVQ AX, ret+24(FP)
    RET
L:
    MOVQ BX, ret+24(FP)
    RET

