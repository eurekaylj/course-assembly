DATA    SEGMENT
        STRING  DB  21 DUP(?)
        INFORMATION DB  'Please enter a string$'
DATA    ENDS

STACK   SEGMENT
STACK   ENDS

CODE    SEGMENT
        ASSUME  CS:CODE,DS:DATA,SS:STACK

START:  MOV AX,DATA
        MOV DS,AX
        LEA SI,STRING
        LEA DX,INFORMATION
        MOV AH,9H
        INT 21H ;显示DX为首地址的字符串
        MOV DL,0DH
        MOV AH,2H
        INT 21H ;输出回车
        MOV DL,0AH
        INT 21H ;输出换行
        XOR CX,CX

INPUT:  CMP CX,14H
        JZ  OUTPUT1 ;超过20个字符则退出循环
        MOV AH,1H
        INT 21H
        CMP AL,0DH
        JZ  OUTPUT2 ;输出回车则退出循环
        CMP AL,61H
        JB  NEXT
        SUB AL,20H
NEXT:   MOV DS:[SI],AL
        INC SI
        INC CX
        JMP INPUT

OUTPUT1:MOV DL,0DH
        MOV AH,2H
        INT 21H ;输出回车
        MOV DL,0AH
        INT 21H ;输出换行

OUTPUT2:MOV AL,'$'
        MOV DS:[SI],AL
        LEA DX,STRING
        MOV AH,9H
        INT 21H

EXIT:   MOV AH,4CH
        INT 21H
        
CODE    ENDS
        END START