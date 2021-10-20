#include "go_asm.h"
#include "textflag.h"
#include "funcdata.h"

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

TEXT ·main1(SB),$24-0
    NO_LOCAL_POINTERS

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


    MOVQ $1,0(SP)
    MOVQ $2,8(SP)
    MOVQ $3,16(SP)
    CALL ·If(SB)

    MOVQ 24(SP),AX
    MOVQ AX,0(SP)
    CALL ·output(SB)

    MOVQ $100,0(SP)
    CALL ·sum(SB)
    MOVQ 8(SP),AX

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

TEXT ·LoopAdd(SB), NOSPLIT,$0-32
    MOVQ cnt+0(FP), AX
    MOVQ v0+8(FP), BX
    MOVQ step+16(FP), CX

LOOP_BEGIN:
    MOVQ $0,DX

LOOP_IF:
    CMPQ DX,AX
    JL LOOP_BODY
    JMP LOOP_END

LOOP_BODY:
    ADDQ $1,DX
    ADDQ CX,BX
    JMP LOOP_IF

LOOP_END:
    MOVQ BX,ret+24(FP)
    RET

TEXT ·sum(SB), $16-16
    NO_LOCAL_POINTERS
    MOVQ n+0(FP), AX       // n
    MOVQ result+8(FP), BX  // result

    CMPQ AX, $0            // test n - 0
    JG   L_STEP_TO_END     // if > 0: goto L_STEP_TO_END
    JMP  L_END             // goto L_STEP_TO_END

L_STEP_TO_END:
    SUBQ $1, AX            // AX -= 1
    MOVQ AX, 0(SP)         // arg: n-1
    CALL ·sum(SB)          // call sum(n-1)
    MOVQ 8(SP), BX         // BX = sum(n-1)

    MOVQ n+0(FP), AX       // AX = n
    ADDQ AX, BX            // BX += AX
    MOVQ BX, result+8(FP)  // return BX
    RET

L_END:
    MOVQ $0, result+8(FP) // return 0
    RET

TEXT ·ptrToFunc(SB), NOSPLIT, $0-16
    MOVQ ptr+0(FP), AX // AX = ptr
    MOVQ AX, ret+8(FP) // return AX
    RET

TEXT ·asmFunTwiceClosureAddr(SB), NOSPLIT, $0-8
    LEAQ ·asmFunTwiceClosureBody(SB), AX // AX = ·asmFunTwiceClosureBody(SB)
    MOVQ AX, ret+0(FP)                   // return AX
    RET

TEXT ·asmFunTwiceClosureBody(SB), NOSPLIT|NEEDCTXT, $0-8
    MOVQ 8(DX), AX
    ADDQ AX   , AX        // AX *= 2
    MOVQ AX   , 8(DX)     // ctx.X = AX
    MOVQ AX   , ret+0(FP) // return AX
    RET

// func SyscallWrite_Darwin(fd int, msg string) int
TEXT ·SyscallWrite_Darwin(SB), NOSPLIT, $0
    MOVQ $(0x2000000+4), AX // #define SYS_write 4
    MOVQ fd+0(FP),       DI
    MOVQ msg_data+8(FP), SI
    MOVQ msg_len+16(FP), DX
    SYSCALL
    MOVQ $1, ret+24(FP)
    RET

// func getg() unsafe.Pointer
TEXT ·getg(SB), NOSPLIT, $0-8
    MOVQ TLS, AX
    MOVQ 0(AX)(TLS*1), CX
    MOVQ CX, ret+0(FP)
    RET

// func testP() unsafe.Pointer
TEXT ·testP(SB), NOSPLIT, $8
    MOVQ fd+0(FP),       DI
    MOVQ (DI), AX
    MOVQ (AX), BX
    MOVQ BX,0(SP)
    CALL ·output(SB)
    RET
