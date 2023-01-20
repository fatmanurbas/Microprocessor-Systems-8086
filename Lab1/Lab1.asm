CODE    SEGMENT PUBLIC 'CODE'
        ASSUME CS:CODE
	
	
START:
        MOV BL, 0FFH ; BL ekranda yanacak sayiyi belirler
        MOV AL, 90H ; PortA input, PortB output, iki taraf da Mod0 
	MOV DX, 306H ; kontrol yazmacının adresini dx'e atıyoruz
	OUT DX, AL ;DX deki değeri AL ye alıyoruz

	MOV AL, BL 
	MOV DX, 302H
	OUT DX, AL
        ; Bu üçlü blokta program ilk çalıştırıldığında 7SD üstündeki tüm değerlerin sönük olmasını sağladık
	
	
ENDLESS: 
	MOV DX, 300H 
	
	IN AL, DX
	AND AL, 01H ; input aldığımız değer ilk butonu mu çalıştırıyor diye bakıyoruz
	JNE wait_keyup1
	
	IN AL, DX
	AND AL, 10H ; input aldığımız değer ikinci butonu mu çalıştırıyor diye bakıyoruz
	JNE wait_keyup2

	JMP ENDLESS
	
wait_keyup1: ; parmagini kaldirinca sayi artir
        IN AL, DX
        AND AL, 01H
	JE SAYI
	JNE wait_keyup1

wait_keyup2:
        IN AL, DX
        AND AL, 10H
	JE SIFIR
	JNE wait_keyup2
	
SAYI:	; 5-6-7-8 değerlerini üretmeyi sağlayacağımız kısım
	MOV DX, 302H
	
	
	MOV AL, 0FFH
	OUT DX, AL ; ekrana yeni değeri yazmadan önce kapatıyoruz ki geçiş esnasında karmaşık bir görüntü olmasın
	
	MOV CX, 03FFFH
bekle1:  
        LOOP bekle1 ; bu minik loopu sayılar değişirken oluşacak görüntünün düzgün olması için ekledik
	
	CMP BL, 80H ; eğer BL içinde 8'in değeri varsa beşe geçeriz 92H=5, 82H=6, F8H=7, 80H=8
	JE BES
	
	CMP BL, 92H
	JE ALTI
	
	CMP BL, 82H
	JE YEDI
	
	CMP BL, 0F8H
	JE SEKIZ
	
	JE BES
	
BES:	
	MOV BL, 92H ; bir sonraki butona basılması ihtimalinde kaldığımız yeri belirlemek için
        MOV AL, BL	
	OUT DX, AL
	JMP ENDLESS
ALTI:	 
	MOV BL, 82H
        MOV AL, BL	
	OUT DX, AL
	JMP ENDLESS
YEDI:	
	MOV BL, 0F8H
        MOV AL, BL	
	OUT DX, AL
	JMP ENDLESS
SEKIZ:	
	MOV BL, 80H
        MOV AL, BL	
	OUT DX, AL
	JMP ENDLESS	
SIFIR:
	MOV DX, 302H
	
	MOV AL, 0FFH
	OUT DX, AL ; ekrana yeni değeri yazmadan önce kapatıyoruz ki geçiş esnasında karmaşık bir görüntü olmasın
	
	MOV CX, 01FFFH
bekle:  LOOP bekle	

	MOV BL, 0FFH
	
        MOV AL, 0C0H	
	OUT DX, AL
        JMP ENDLESS
	
CODE    ENDS
        END START	
