STAK    SEGMENT PARA STACK 'STACK'
        DW 20 DUP(?)
STAK    ENDS

DATA    SEGMENT PARA 'DATA'
DIGITS  DB 00H
DATA    ENDS

CODE    SEGMENT PARA 'CODE'
        ASSUME CS:CODE, DS:DATA, SS:STAK
START:
        MOV AX, DATA
	MOV DS, AX
	
	MOV DX, 0302h ; mod yazmacına erişim sağladık
	MOV AL, 01001101B ; asenkron haberleşme yapıyoruz
	OUT DX, AL
	
	MOV AL, 40H ; yazılımsal reset yapıyoruz kontrol yazmacından
	OUT DX, AL
	
	MOV AL, 01001101B ; mod yazmacına tekrar erişiyoruz
	OUT DX, AL
	
	MOV AL, 00010101B ; kontrol yazmacı receive ve transmit aktif
	OUT DX, AL
	
	MOV BL, 00H
	

ENDLESS:

	MOV DX, 0302H
TEKRAR:
	IN AL, DX ;veri alımını kontrol ediyoruz
	AND AL, 02H
	JZ TEKRAR
		
	MOV DX, 0300H
	IN AL, DX
	MOV BL, AL ; aldığımız sayıyı bl içerisine yerleştiriyoruz

ISIM:	
	MOV DX, 302H
TEKRAR2:
	IN AL, DX ; veri gönderimini kontrol ediyoruz
	AND AL, 01H
	JZ TEKRAR2
	
	
	MOV DX, 300H
	MOV AL, 46H ; f harfi
	OUT DX,AL
AHARFI1:
	MOV DX, 302H ;bir sonraki veriyi göndermek için tekrar status yazmacına erişiyoruz
	IN AL, DX
	AND AL, 01H
	JZ AHARFI1
	
	MOV DX, 300H
	MOV AL,41H ; a harfi
	OUT DX,AL
	
THARFI:
	MOV DX, 302H
	IN AL, DX
	AND AL, 01H
	JZ THARFI
	
	MOV DX, 300H
	MOV AL,54H ; t harfi
	OUT DX,AL
MHARFI:
	MOV DX, 302H
	IN AL, DX
	AND AL, 01H
	JZ MHARFI	
	
	MOV DX, 300H
	MOV AL,4DH ; m harfi
	OUT DX,AL
	
AHARFI2:
	MOV DX, 302H
	IN AL, DX
	AND AL, 01H
	JZ AHARFI2	
	
	MOV DX, 300H
	MOV AL,41H ; a harfi
	OUT DX,AL	

NHARFI:
	MOV DX, 302H
	IN AL, DX
	AND AL, 01H
	JZ NHARFI
	
	MOV DX, 300H
	MOV AL,4EH ; N harfi
	OUT DX,AL

UHARFI:
	MOV DX, 302H
	IN AL, DX
	AND AL, 01H
	JZ UHARFI	
	
	MOV DX, 300H
	MOV AL,55H ; U harfi
	OUT DX,AL

RHARFI:
	MOV DX, 302H
	IN AL, DX
	AND AL, 01H
	JZ RHARFI	
	
	MOV DX, 300H
	MOV AL,52H ; R harfi
	OUT DX,AL	

	
	SUB BL, 02H	
	CMP BL, 60H ; bl değerinin aralığını inceliyoruz
	JA ISIM

        JMP ENDLESS
CODE    ENDS
        END START
