DATA    SEGMENT
DATA    ENDS

STACK   SEGMENT
STACK   ENDS

CODE    SEGMENT
        ASSUME CS:CODE,DS:DATA,SS:STACK

START:  MOV AH,1
        INT 21H
        CMP AL,0DH
        JZ  DONE
        CMP AL,30H
        JB  START
        CMP AL,3AH
        JB  OGIN
        CMP AL,41H
        JB  START
        CMP AL,5BH
        JB  DISPC
        CMP AL,61H
        JB  START
        CMP AL,7BH
        JB  DISPC
        JMP START

OGIN:   MOV DL,AL
        MOV AH,2
        INT 21H
        JMP START

DISPC:  MOV DL,'C'
        MOV AH,2
        INT 21H
        JMP START

DONE:   MOV AH,4CH
        INT 21H
        
CODE ENDS
        END START