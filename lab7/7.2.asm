DATA    SEGMENT
        STRING DB "In 1990,the exchange rate was 8.1/$"
        STRNUM DB 'THE NUMBER OF NUM IS $'
        STRCAHR DB 'THE NUMBER OF CAHR IS $'
        STROTHER DB 'THE NUMBER OF OTHER IS $'
        NUM    DB  0
        CAHR   DB  0
        OTHER  DB  0
DATA    ENDS

STACK   SEGMENT
        DW  100H
TOS     EQU THIS WORD
STACK   ENDS
CODE    SEGMENT
        ASSUME  CS:CODE,DS:DATA,ES:DATA,SS:STACK
START:  MOV AX,DATA
        MOV DS,AX
        MOV ES,AX
        MOV AX,STACK
        MOV      SS,AX
        LEA        SP,TOS
        LEA        SI,STRING
           
BGN:    CMP BYTE PTR [SI] ,30H
        JB  OTHERS
        CMP BYTE PTR [SI],39H
        JA  ISUP
        INC NUM
        JMP NEXT
ISUP:   CMP BYTE PTR [SI],41H
        JB  OTHERS
        CMP BYTE PTR [SI],5AH
        JA  ISLOW
        INC CAHR
        JMP NEXT
ISLOW:  CMP BYTE PTR [SI],61H
        JB  OTHERS
        CMP BYTE PTR [SI],7AH
        JA  OTHERS
        INC CAHR
        JMP NEXT
OTHERS: INC OTHER
NEXT:   INC SI
        CMP BYTE PTR [SI],24H
        JZ  SHOW
        JMP BGN
SHOW:   LEA DX,STRNUM
        MOV AH,9
        INT 21H
        MOV   AL, NUM
        PUSH  AX
        MOV  CL,4
        SHR    AL,CL
     
        CMP   AL,0AH
        JB      S1
        ADD   AL,7
S1:       
        ADD   AL,30H
        MOV   DL,AL
        MOV   AH,2
        INT      21H  

        POP    AX
        MOV  CL,4
        AND    AL,0FH

        CMP   AL,0AH
        JB      S2
        ADD   AL,7
S2:
        ADD AL,30H
        MOV   DL,AL
        MOV   AH,2
        INT      21H
        MOV DL,'H'
        MOV AH,2
        INT 21H  
        MOV   DL,0AH
        MOV   AH,2    
        INT   21H  
        LEA DX,STRCAHR
        MOV AH,9
        INT 21H
        MOV AL, CAHR
        PUSH    AX
        MOV CL,4
        SHR AL,CL
        CMP AL,0AH
        JB  S3
        ADD AL,7
S3:       
        ADD AL,30H
        MOV DL,AL
        MOV AH,2
        INT 21H  

        POP AX
        MOV CL,4
        AND AL,0FH

        CMP AL,0AH
        JB  S4
        ADD AL,7
S4:
        ADD AL,30H
        MOV DL,AL
        MOV AH,2
        INT 21H
        MOV DL,'H'
        MOV AH,2
        INT 21H  
        MOV DL,0AH
        MOV AH,2    
        INT 21H  
        LEA DX,STROTHER
        MOV AH,9
        INT 21H
        MOV AL, OTHER
        PUSH    AX
        MOV CL,4
        SHR AL,CL
     
        CMP AL,0AH
        JB  S5
        ADD AL,7
S5:       
        ADD AL,30H
        MOV DL,AL
        MOV AH,2
        INT 21H  

        POP AX
        MOV CL,4
        AND AL,0FH

        CMP AL,0AH
        JB  S6
        ADD AL,7
S6:
        ADD AL,30H
        MOV DL,AL
        MOV AH,2
        INT 21H  

        MOV DL,'H'
        MOV AH,2
        INT 21H  

        MOV AH,4CH
        INT 21H
CODE    ENDS
        END START