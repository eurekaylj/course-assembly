;DELD.ASM
DATA     SEGMENT
STRN     DB 81 DUP(?)
LEN      DW ?
DATA     ENDS

STACK    SEGMENT  STACK
         DW  100H
TOS      EQU THIS WORD
STACK    ENDS       

CODE     SEGMENT
         ASSUME CS: CODE,DS: DATA,ES: DATA,SS:STACK
START:   MOV    AX, DATA
         MOV    DS,AX
         MOV    ES,AX
         
         MOV    AX,STACK
         MOV    SS,AX
         LEA    SP,TOS
         
         LEA    SI,STRN
         MOV    CL,0
          
AGAIN:   MOV    AH,1
         INT  21H
         CMP    AL,0DH
         JZ     DONEIN
         CMP    CL,80
         JZ     DONEIN
         MOV    [SI],AL
         INC    SI
         INC    CL
         JMP    AGAIN

DONEIN:  MOV    CH,0        ;CX存放了输入字符个数
         MOV    LEN,CX      ;输入字符个数也存放到LEN变量单元
         LEA    SI,STRN
         
DELE:
         DEC    CX
         JZ     DELE0
         PUSH   CX
         MOV    AL,[SI]
         
         LEA    DI,[SI+1]
         CLD
AGN:         
         REPNZ  SCASB
         JNZ    NEXT
         MOV    BYTE PTR[DI-1],0
         JCXZ   NEXT
         JMP    AGN
NEXT:    POP    CX
         INC    SI
         JMP    DELE 


DELE0:   LEA    SI,STRN
         MOV    CX,LEN
AGN1:
         PUSH   CX      
         MOV    AL,[SI]
         CMP    AL,0
         JNZ    NEXT1
         CLD   
         LEA    DI,[SI+1]
         REPZ   SCASB
         JZ     NEXT1
         MOV    AL,[DI-1]
         MOV    [SI],AL
         MOV    BYTE PTR[DI-1],0
     
NEXT1:   INC   SI
         POP   CX
         LOOP  AGN1

         MOV    AH,2
         MOV    DL,0AH
         INT    21H
         MOV    DL,0DH
         INT    21H

         LEA    SI,STRN
         MOV    CX,LEN
L:
         MOV    DL,[SI]
         MOV    AH,2
         INT    21H
         INC   SI
         LOOP   L
         
EXIT:     
         MOV    AH,4CH
         INT    21H

CODE     ENDS
         END  START
