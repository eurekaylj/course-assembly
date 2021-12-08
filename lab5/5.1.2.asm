DATA    SEGMENT

BUF    DB 80,?,80 DUP(?)

DATA    ENDS

CODE    SEGMENT 
        ASSUME CS:CODE, DS:DATA
       
START:  MOV   AX, DATA
        MOV   DS, AX

        LEA   DX, BUF
        MOV   AH, 0AH
        INT   21H
        
        LEA    SI, BUF
        INC    SI
        MOV  CL, [SI]
        INC     SI
        MOV   CH,0
        MOV   BL,0
        CLD
        
CYCLE:  LODSB
        CMP   AL,61H
        JB    NEXT
        CMP   AL,7AH
        JA    NEXT
        INC   BL
NEXT:   
        LOOP  CYCLE
        
        MOV   AH,2
        MOV   DL,0AH
        INT   21H
        MOV   DL,0DH
        INT   21H

        MOV   AL,BL 
        MOV   AH,0
        MOV   CL,10
        DIV   CL            
        XCHG  AH,AL         
       
        PUSH  AX
        
        MOV   DL,AH
        OR    DL,30H
        MOV   AH,2
        INT   21H
   
        POP   AX
        
        
        MOV   DL,AL
        OR    DL,30H
        MOV   AH,2
        INT   21H
 

        MOV   AH,4CH
        INT   21H
CODE    ENDS
        END START