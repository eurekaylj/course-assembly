DATA   SEGMENT
CHAR   DB  'b'
BUF     DB  50H,?,50H DUP(?)
DATA   ENDS 
MCODE  SEGMENT
         ASSUME CS: MCODE, DS: DATA
START: MOV  AX,DATA
         MOV  DS,AX
         LEA   DX,BUF
         MOV  AH,0AH
         INT   21H
         LEA   SI, BUF 
         MOV  CL, [si+1]
         MOV  CH, 0   ;CX中为字符串长度
         INC    SI 
         INC    SI     ;SI指向串首址TABLE
         MOV  AL,CHAR
         MOV  AH,0     ;AX中为待查字符
         PUSH  SI
         PUSH  CX
         PUSH   AX        ; 参数送堆栈
CALL   FAR PTR CHECK
        POP    AX   ;统计个数在AL中
        MOV    BL,AL   ;转存
        MOV   DL,0DH
        MOV   AH,2
        INT 21H
        MOV DL,0AH
        MOV AH,2
        INT 21H
        MOV   DL,CHAR
        MOV   AH,2
        INT    21H
        MOV   DL,BL
        AND   DL, 0FH
        CMP   DL,9
        JBE    NEXT
        ADD   DL,7
NEXT: ADD  DL,30H
        MOV  AH,2 
        INT   21H        ;显示统计个数
        MOV  AH,4CH
        INT  21H
MCODE  ENDS
SCODE   SEGMENT
        ASSUME  CS:SCODE
CHECK  PROC  FAR
         PUSH  BP
         MOV   BP,SP
         MOV   SI,[BP+10]
         MOV   CX, [BP+8]
         MOV   AX, [BP+6]
         XOR   AH,AH
AGAIN: CMP   AL,[SI]
         JNE    NEXT1
         INC    AH
NEXT1: INC    SI
         LOOP  AGAIN
         MOV  AL, AH
         MOV  [BP+10],AX
         POP  BP
         RET  4
CHECK  ENDP
SCODE ENDS
         END  START
