[org 0x100]

	jmp start

; 0 is empty
; 1 is wall
; 2 is pie
; 3 is player
; 4 is enemy
; 5 is triangle score+= 30 -> 3 per maze
; 6 is square score+= 50 -> 2 per maze
; 7 is diamond score+=100 -> 1 per maze

XPos: dw 280
YPos: dw 10
score: dw 0
lives: dw 3
randNum: dw 0
foundPie: dw 0			; bool found flag for pie
tickcount: dw 60
currButton: dw 0
delayCounter: dw 0
supermanMode: dw 0		; bool flag for superman mode

maze1: db  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
       db  1, 0, 0, 0, 6, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
       db  1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1
       db  1, 0, 1, 5, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 4, 7, 1, 0, 1
       db  1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1
       db  1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1
       db  1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1
       db  1, 0, 0, 0, 0, 0, 6, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
       db  1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1
       db  1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
       db  1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1
       db  1, 0, 0, 0, 1, 4, 0, 0, 0, 0, 1, 0, 0, 0, 0, 3, 1, 0, 0, 1
       db  1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1
       db  1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 1, 0, 0, 5, 1
       db  1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
       db  1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
       db  1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1
       db  1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 4, 0, 0, 1, 0, 0, 0, 0, 1
       db  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1

maze2: db  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
       db  1, 7, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1
       db  1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1
       db  1, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 1, 0, 1
       db  1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1
       db  1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
       db  1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1
       db  1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
       db  1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1
       db  1, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
       db  1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1
       db  1, 0, 1, 0, 0, 0, 6, 0, 0, 0, 1, 0, 0, 5, 0, 0, 0, 1, 0, 1
       db  1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1
       db  1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 1
       db  1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1
       db  1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 4, 0, 6, 0, 0, 0, 0, 0, 0, 1
       db  1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1
       db  2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 1
       db  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1

maze3: db  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
       db  1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1
       db  1, 0, 1, 4, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1
       db  1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1
       db  1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
       db  1, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
       db  1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1
       db  1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
       db  1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1
       db  1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
       db  1, 4, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1
       db  1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1
       db  1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 6, 0, 0, 0, 1, 1, 0, 0, 1
       db  1, 7, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1
       db  1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 4, 1, 1, 1, 1, 1, 1
       db  1, 0, 0, 0, 1, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 1
	   db  1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1
       db  1, 0, 0, 0, 0, 1, 1, 1, 1, 5, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1
       db  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1

maze4: db  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
       db  1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 5, 1, 0, 0, 0, 0, 1
       db  1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1
       db  1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1
       db  1, 0, 1, 0, 4, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1
       db  1, 0, 1, 0, 0, 5, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1
       db  1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1
       db  1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 6, 0, 0, 0, 0, 1
       db  1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1
       db  1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
       db  1, 6, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1
       db  1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1
       db  1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1
       db  1, 0, 1, 2, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1
       db  1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1
       db  1, 0, 0, 0, 1, 0, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0, 0, 4, 7, 1
	   db  1, 0, 1, 0, 0, 0, 4, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1
       db  1, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 3, 1
       db  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1

maze5: db  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
       db  1, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
       db  1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1
       db  1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 6, 1, 0, 1
       db  1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1
       db  1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1
       db  1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1
       db  1, 6, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 1
       db  1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1
       db  1, 0, 0, 0, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 6, 4, 0, 0, 1
       db  1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1
       db  1, 4, 0, 0, 1, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1
       db  1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1
       db  1, 0, 1, 0, 0, 0, 0, 7, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
       db  1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
       db  1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1
       db  1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1
       db  1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 4, 1
       db  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1

losingmaze: db  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			db  1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 5, 1, 0, 0, 0, 0, 1
			db  1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1
			db  1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1
			db  1, 0, 1, 0, 4, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1
			db  1, 0, 1, 0, 0, 5, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1
			db  1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1
			db  1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 6, 0, 0, 0, 0, 1
			db  1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1
			db  1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
			db  1, 6, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1
			db  1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1
			db  1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1
			db  1, 0, 1, 2, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1
			db  1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1
			db  1, 0, 0, 0, 1, 0, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0, 0, 4, 7, 1
			db  1, 0, 1, 0, 0, 0, 4, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1
			db  1, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1
			db  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1

winningMaze:db  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			db  1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
			db  1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1
			db  1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1
		    db  1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1
		    db  1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1
		    db  1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1
		    db  1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
		    db  1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1
		    db  1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
		    db  1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1
		    db  1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1
		    db  1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1
		    db  1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1
		    db  1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
		    db  1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
		    db  1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1
		    db  1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1
		    db  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1

drawCell:
	pusha

	mov dx, 9			; We use dx for the length of our cell

	rect_loop:
		push di
		mov cx, 9		; We use cx for the width of our cell
		rep stosb
		pop di
		add di, 320
		dec dx
		jnz rect_loop

	popa
	ret

drawPlayer:
    pusha

; Move the head down to center in the cell
    add di, 322
    mov cx, 5           	; Iterator

; Top line
	l1:
	mov [es:di], al
	inc di
	loop l1

	mov cx, 5

; Right line
	l2:
	add di, 320
	mov [es:di], al
	loop l2

	add di, 319
	mov [es:di], al
	mov cx, 4

; Bottom line
	l3:
	dec di
	mov [es:di], al
	loop l3

	sub di, 321
	mov [es:di], al
	mov cx, 4

; Left line
	l4:
	sub di, 320
	mov [es:di], al
	loop l4

; Left eye
	add di, 322
	mov [es:di], al

; Right eye
	add di, 2
	mov [es:di], al

; Lips
	mov cx, 2
	add di, 640
	mov [es:di], al

	l5:
	dec di
	mov [es:di], al
	loop l5

	popa
    ret

drawEnemy:
    pusha

; Move the head down to center in the cell
    add di, 322
    mov cx, 5           	; Iterator

; Horn 1
	push di

	sub di, 321
	mov [es:di], al

; Horn 2
	add di, 6
	mov [es:di], al

	pop di

; Top line
	Enem1:
	mov [es:di], al
	inc di
	loop Enem1

	mov cx, 5

; Right line
	Enem2:
	add di, 320
	mov [es:di], al
	loop Enem2

	add di, 319
	mov [es:di], al
	mov cx, 4

; Bottom line
	Enem3:
	dec di
	mov [es:di], al
	loop Enem3

	sub di, 321
	mov [es:di], al
	mov cx, 4

; Left line
	Enem4:
	sub di, 320
	mov [es:di], al
	loop Enem4

; Left eye
	add di, 322
	mov [es:di], al

; Right eye
	add di, 2
	mov [es:di], al

; Lips
	mov cx, 2
	add di, 640
	mov [es:di], al

	Enem5:
	dec di
	mov [es:di], al
	loop Enem5

; Angry face
	sub di, 319
	mov [es:di], al

	popa
    ret

drawPie:
	pusha

; To centre in the cell
    add di, 322
    mov cx, 5           	; Iterator

; Top line
	p1:
	mov [es:di], al
	inc di
	loop p1

; Right arc
	add di, 318
	mov [es:di], al

	mov cx, 3
	p2:
	add di, 320
	mov [es:di], al
	loop p2

	add di, 321
	mov [es:di], al

	sub di, 3
	mov [es:di], al

; Left line
	mov cx, 4
	p3:
	sub di, 320
	mov [es:di], al
	loop p3

	popa
	ret

drawTriangle:
	pusha

; Move the head down to center in the cell
    add di, 964
	stosb			; Peak

	add di, 318
	mov cx, 3
	push di
	rep stosb
	pop di

	add di, 319
	mov cx, 5
	rep stosb

	popa
	ret

drawSquare:
	pusha
; Move the head down to center in the cell
	add di, 642

	mov dx, 5			; Iterate rows of the square
	Squar1:
	push di
	mov cx, 5			; Iterate cols of the square
	rep stosb
	pop di
	add di, 320
	dec dx
	jnz Squar1

	popa
	ret

drawDiamond:
	pusha
; Move the head down to center in the cell
	add di, 324
	stosb

	add di, 318
	mov cx, 3
	push di
	rep stosb
	pop di

	add di, 319
	mov cx, 5
	push di
	rep stosb
	pop di

	add di, 319
	mov cx, 7
	push di
	rep stosb
	pop di

	add di, 321
	mov cx, 5
	push di
	rep stosb
	pop di

	add di, 321
	mov cx, 3
	push di
	rep stosb
	pop di

	add di, 321
	stosb

	popa
	ret

printMaze:
	push bp
	mov bp, sp
	pusha

	mov cx, 19			; We iterate outer loop via cx
	mov dx, 0			; We iterate inner loop via dx
	mov si, [bp + 4]    ; load maze
	xor di, di

	rows:
		push di
		columns:
			cmp byte [si], 0
			je printSpace

			cmp byte [si], 2
			je printPie

			cmp byte [si], 3
			je printPlayer

			cmp byte [si], 4
			je printEnemy

			cmp byte [si], 5
			je printTriangle

			cmp byte [si], 6
			je printSquare

			cmp byte [si], 7
			je printDiamond

			; Else print block
			mov al, [bp + 6]            ; block color through parameter
			call drawCell               ; Store AL at ES:DI (write pixel)
			add di, 10
			inc si

			jmp iterateInnerLoop

			printSpace:
			mov al, 00
			call drawCell
			add di, 10
			inc si

			jmp iterateInnerLoop

			printPlayer:
			mov al, 00
			call drawCell
			mov al, 0x0A
			call drawPlayer
			add di, 10
			inc si

			jmp iterateInnerLoop

			printEnemy:
			mov al, 00
			call drawCell
			mov al, 0x05
			call drawEnemy
			add di, 10
			inc si

			jmp iterateInnerLoop

			printTriangle:
			mov al, 00
			call drawCell
			mov al, 86
			call drawTriangle
			add di, 10
			inc si

			jmp iterateInnerLoop

			printSquare:
			mov al, 00
			call drawCell
			mov al, 0x09
			call drawSquare
			add di, 10
			inc si

			jmp iterateInnerLoop

			printDiamond:
			mov al, 00
			call drawCell
			mov al, 0x0B
			call drawDiamond
			add di, 10
			inc si

			jmp iterateInnerLoop

			printPie:
			mov al, 00
			call drawCell
			mov al, 0x0E
			call drawPie
			add di, 10
			inc si

			iterateInnerLoop:
			inc dx
			cmp dx, 20
			jne columns
		pop di

		add di, 3200
		mov dx, 0

		dec cx
		cmp cx, 0
		jne near rows

	popa
	pop bp
	ret 4

generateRandomNumber:
	push bp
    mov bp, sp
    push cx
    push ax
    push dx

    mov ah, 00h                ; BIOS interrupt to get system time
    int 1Ah                    ; CX:DX now hold the number of clock ticks since midnight

    ; Using DX as the seed for pseudo-random number generation
    ; Limit DX to a range of 0-9
    mov ax, dx                 ; Move DX into AX
    xor dx, dx                 ; Clear DX for division
    mov cx, 10                 ; Divisor for range 0-9
    div cx                     ; AX divided by CX, remainder in DX

    mov [randNum], dl          ; Store the remainder (0-9) in randNum

    pop dx
    pop ax
    pop cx
    pop bp
    ret

generateRandomMaze:
	push ax

	call generateRandomNumber

	mov ax, [randNum]
	cmp ax, 9
	je PrintMaze5

	cmp ax, 8
	je PrintMaze5

	cmp ax, 7
	je PrintMaze4

	cmp ax, 6
	je PrintMaze4

	cmp ax, 5
	je PrintMaze3

	cmp ax, 4
	je PrintMaze3

	cmp ax, 3
	je PrintMaze2

	cmp ax, 2
	je PrintMaze2

	cmp ax, 1
	je PrintMaze1

PrintMaze1:
	mov al, 1
	mov ah, 0
	push ax
	mov bx, maze1
	push maze1
	call printMaze
	pop ax
	ret

PrintMaze2:
	mov al, 2
	mov ah, 0
	push ax
	mov bx, maze2
	push maze2
	call printMaze
	pop ax
	ret

PrintMaze3:
	mov al, 3
	mov ah, 0
	push ax
	mov bx, maze3
	push maze3
	call printMaze
	pop ax
	ret

PrintMaze4:
	mov al, 23
	mov ah, 0
	push ax
	mov bx, maze4
	push maze4
	call printMaze
	pop ax
	ret

PrintMaze5:
	mov al, 8
	mov ah, 0
	push ax
	mov bx, maze5
	push maze5
	call printMaze
	pop ax
	ret

movePlayerUp:
	pusha
	; BX points to our maze array
	xor di, di
	xor si, si
	mov cx, 20						; No of rows

	searchPlayerOuterForUp:
		mov dx, 20					; No of cols
		push di
		searchPlayerInnerForUp:
			cmp byte [bx + si], 3
			je foundUp

			inc si
			add di, 10
			dec dx
			jnz searchPlayerInnerForUp
		pop di
		add di, 3200
		loop searchPlayerOuterForUp

foundUp:
	add sp, 2						; To clear the stack cause of "push di"
; DI points to the upper cell where we wanna go
	sub si, 20

	cmp byte [bx + si], 1
	je dontMoveUp

	cmp byte [bx + si], 2
	je foundPieUp

	cmp byte [bx + si], 7
	je ateDiamondUp

	cmp byte [bx + si], 6
	je ateSquareUp

	cmp byte [bx + si], 5
	je ateTriangleUp

	cmp byte [bx + si], 4
	je enemyInteractionUp

	cmp byte [bx + si], 0
	je allowMoveUp

ateDiamondUp:
	add word [score], 100

	call clearScore

	push word [score]
	call printnum

	inc word [supermanMode]

	jmp allowMoveUp

ateSquareUp:
	add word [score], 50

	call clearScore

	push word [score]
	call printnum
	jmp allowMoveUp

ateTriangleUp:
	add word [score], 30

	call clearScore

	push word [score]
	call printnum
	jmp allowMoveUp

foundPieUp:
	inc word [foundPie]
	jmp allowMoveUp

enemyInteractionUp:
	dec word [lives]
	call clrBattery

	push word [lives]
	call drawBattery

allowMoveUp:
	sub di, 3200
	mov al, 0x0A
	call drawPlayer
	mov byte [bx + si], 3

	add si, 20
	add di, 3200
	mov al, 0
	call drawCell
	mov byte [bx + si], 0

dontMoveUp:
	popa
	ret

movePlayerLeft:
	pusha
	; BX points to our maze array
	xor di, di
	xor si, si
	mov cx, 20						; No of rows

	searchPlayerOuterForLeft:
		mov dx, 20					; No of cols
		push di
		searchPlayerInnerForLeft:
			cmp byte [bx + si], 3
			je foundLeft

			inc si
			add di, 10
			dec dx
			jnz searchPlayerInnerForLeft
		pop di
		add di, 3200
		loop searchPlayerOuterForLeft

foundLeft:
	add sp, 2						; To clear the stack cause of "push di"
; DI points to the adjacent left cell where we wanna go
	dec si

	cmp byte [bx + si], 1
	je dontMoveLeft

	cmp byte [bx + si], 2
	je foundPieLeft

	cmp byte [bx + si], 7
	je ateDiamondLeft

	cmp byte [bx + si], 6
	je ateSquareLeft

	cmp byte [bx + si], 5
	je ateTriangleLeft

	cmp byte [bx + si], 4
	je enemyInteractionLeft

	cmp byte [bx + si], 0
	je allowMoveLeft

ateDiamondLeft:
	add word [score], 100

	call clearScore

	push word [score]
	call printnum

	inc word [supermanMode]

	jmp allowMoveLeft

ateSquareLeft:
	add word [score], 50

	call clearScore

	push word [score]
	call printnum
	jmp allowMoveLeft

ateTriangleLeft:
	add word [score], 30

	call clearScore

	push word [score]
	call printnum
	jmp allowMoveLeft

foundPieLeft:
	inc word [foundPie]
	jmp allowMoveLeft

enemyInteractionLeft:
	dec word [lives]
	call clrBattery

	push word [lives]
	call drawBattery

allowMoveLeft:
	sub di, 10
	mov al, 0x0A
	call drawPlayer

	mov byte [bx + si], 3

	inc si
	add di, 10
	mov al, 00
	call drawCell
	mov byte [bx + si], 0
dontMoveLeft:
	popa
	ret

movePlayerDown:
	pusha
	; BX points to our maze array
	xor di, di
	xor si, si
	mov cx, 20						; No of rows

	searchPlayerOuterForDown:
		mov dx, 20					; No of cols
		push di
		searchPlayerInnerForDown:
			cmp byte [bx + si], 3
			je foundDown

			inc si
			add di, 10
			dec dx
			jnz searchPlayerInnerForDown
		pop di
		add di, 3200
		loop searchPlayerOuterForDown

foundDown:
	add sp, 2						; To clear the stack cause of "push di"
; DI points to the lower cell where we wanna go
	add si, 20

	cmp byte [bx + si], 1
	je dontMoveDown

	cmp byte [bx + si], 2
	je foundPieDown

	cmp byte [bx + si], 7
	je ateDiamondDown

	cmp byte [bx + si], 6
	je ateSquareDown

	cmp byte [bx + si], 5
	je ateTriangleDown

	cmp byte [bx + si], 4
	je enemyInteractionDown

	cmp byte [bx + si], 0
	je allowMoveDown

ateDiamondDown:
	mov ax, [score]
	add ax, 100
	mov [score], ax

	call clearScore

	push ax
	call printnum

	inc word [supermanMode]

	jmp allowMoveDown

ateSquareDown:
	mov ax, [score]
	add ax, 50
	mov [score], ax

	call clearScore

	push ax
	call printnum
	jmp allowMoveDown

ateTriangleDown:
	mov ax, [score]
	add ax, 30
	mov [score], ax

	call clearScore

	push ax
	call printnum
	jmp allowMoveDown

foundPieDown:
	inc word [foundPie]
	jmp allowMoveDown

enemyInteractionDown:
	dec word [lives]
	call clrBattery

	push word [lives]
	call drawBattery

allowMoveDown:
	add di, 3200
	mov al, 0x0A
	call drawPlayer
	mov byte [bx + si], 3

	sub si, 20
	sub di, 3200
	mov al, 0
	call drawCell
	mov byte [bx + si], 0

dontMoveDown:
	popa
	ret

movePlayerRight:
	pusha
	; BX points to our maze array
	xor di, di
	xor si, si
	mov cx, 20						; No of rows

	searchPlayerOuterForRight:
		mov dx, 20					; No of cols
		push di
		searchPlayerInnerForRight:
			cmp byte [bx + si], 3
			je foundRight

			inc si
			add di, 10
			dec dx
			jnz searchPlayerInnerForRight
		pop di
		add di, 3200
		loop searchPlayerOuterForRight

foundRight:
	add sp, 2				; To clear the stack cause of "push di"
; DI points to the adjacent right cell where we wanna go
	inc si

	cmp byte [bx + si], 1
	je dontMoveRight

	cmp byte [bx + si], 2
	je foundPieRight

	cmp byte [bx + si], 7
	je ateDiamondRight

	cmp byte [bx + si], 6
	je ateSquareRight

	cmp byte [bx + si], 5
	je ateTriangleRight

	cmp byte [bx + si], 4
	je enemyInteractionRight

	cmp byte [bx + si], 0
	je allowMoveRight

ateDiamondRight:
	add word [score], 100

	call clearScore

	push word [score]
	call printnum

	inc word [supermanMode]

	jmp allowMoveRight

ateSquareRight:
	add word [score], 50

	call clearScore

	push word [score]
	call printnum
	jmp allowMoveRight

ateTriangleRight:
	add word [score], 30

	call clearScore

	push word [score]
	call printnum
	jmp allowMoveRight

foundPieRight:
	inc word [foundPie]
	jmp allowMoveRight

enemyInteractionRight:
	dec word [lives]
	call clrBattery

	push word [lives]
	call drawBattery

allowMoveRight:
	add di, 10
	mov al, 0x0A
	call drawPlayer
	mov byte [bx + si], 3

	dec si
	sub di, 10
	mov al, 0
	call drawCell
	mov byte [bx + si], 0

dontMoveRight:
	popa
	ret

movePlayer:
	pusha
takeInput:
	mov ax, [lives]
	cmp ax, 0
	je terminate						; Terminate if lives are 0

	mov ax, [tickcount]
	cmp ax, 0
	je terminate						; Terminate if timer runs out

	mov ax, [foundPie]
	cmp ax, 1
	je terminate						; Terminate if pie found

	mov ax, [supermanMode]
	cmp ax, 1
	jne moveOn

	call SuperManMode

moveOn:
	mov ax, 00
    mov ah, 0x00              			; BIOS keyboard input function
    int 0x16                 			; Wait for a key press

	cmp al, 'W'
	je moveUp

	cmp al, 'w'
	je moveUp

	cmp al, 'A'
	je moveLeft

	cmp al, 'a'
	je moveLeft

	cmp al, 'S'
	je moveDown

	cmp al, 's'
	je moveDown

	cmp al, 'D'
	je moveRight

	cmp al, 'd'
	je moveRight

	jmp takeInput

	moveUp:
		call movePlayerUp
		jmp takeInput

	moveLeft:
		call movePlayerLeft
		jmp takeInput

	moveDown:
		call movePlayerDown
		jmp takeInput

	moveRight:
		call movePlayerRight
		jmp takeInput

terminate:
	popa
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;			Number Printing			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

drawZero:
	pusha
; Move head to the centre of the cell

	add di, 323
; draw 'a'
	mov dx, 2
	loop0a:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop0a

	add di, 334

; draw 'b'
	mov dx, 14
	loop0b:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop0b

	add di, 1920		; leave 6 lines after b

; draw 'c'
	mov dx, 14
	loop0c:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop0c

	add di, 319

; draw 'd'
	std

	mov dx, 2
	loop0d:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop0d

	cld

	sub di, 11855

; draw 'f'
	mov dx, 14
	loop0f:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop0f

	add di, 1600

; draw 'e'
	mov dx, 14
	loop0e:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop0e

	popa
	ret

drawOne:
	pusha
; Move head to the centre of the cell

	add di, 323

	add di, 640			; leave space for a

	add di, 334

; draw 'b'
	mov dx, 15
	loop1b:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop1b

	add di, 1280		; leave 6 lines after b

; draw 'c'
	mov dx, 15
	loop1c:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop1c

	popa
	ret

drawTwo:
	pusha
; Move head to the centre of the cell

	add di, 323
; draw 'a'
	mov dx, 2
	loop2a:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop2a

	add di, 334

; draw 'b'
	mov dx, 14
	loop2b:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop2b

	add di, 1920		; leave 6 lines after b

	add di, 4480		; Leave space for c

	add di, 319

; draw 'd'
	std

	mov dx, 2
	loop2d:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop2d

	cld

	sub di, 11855

	add di, 4480		; leave space for f

	add di, 1600

; draw 'e'
	mov dx, 14
	loop2e:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop2e

	sub di, 5438

; draw 'g'
	mov dx, 2
	loop2g:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop2g

	popa
	ret

drawThree:
	pusha
; Move head to the centre of the cell

	add di, 323
; draw 'a'
	mov dx, 2
	loop3a:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop3a

	add di, 334

; draw 'b'
	mov dx, 14
	loop3b:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop3b

	add di, 1920		; leave 6 lines after b

; draw 'c'
	mov dx, 14
	loop3c:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop3c

	add di, 319

; draw 'd'
	std

	mov dx, 2
	loop3d:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop3d

	cld

	sub di, 11855

	add di, 4480          ; space for f

	add di, 1600

	add di, 4480          ; space for e

	sub di, 5438

; draw 'g'
	mov dx, 2
	loop3g:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop3g

	popa
	ret

drawFour:
	pusha
; Move head to the centre of the cell

	add di, 323
;
	add di, 640			; Leave space for a

	add di, 334

; draw 'b'
	mov dx, 14
	loop4b:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop4b

	add di, 1920		; leave 6 lines after b

; draw 'c'
	mov dx, 14
	loop4c:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop4c

	add di, 319

	add di, 640

	sub di, 11855

; draw 'f'
	mov dx, 14
	loop4f:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop4f

	add di, 1600

; draw 'e'
	add di, 4480

	sub di, 5438

; draw 'g'
	mov dx, 2
	loop4g:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop4g

	popa
	ret

drawFive:
	pusha
; Move head to the centre of the cell

	add di, 323
; draw 'a'
	mov dx, 2
	loop5a:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop5a

	add di, 334

	add di, 4480		; lines for b

	add di, 1920		; leave 6 lines after b

; draw 'c'
	mov dx, 14
	loop5c:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop5c

	add di, 319

; draw 'd'
	std

	mov dx, 2
	loop5d:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop5d

	cld

	sub di, 11855

; draw 'f'
	mov dx, 14
	loop5f:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop5f

	add di, 1600

	add di, 4480

	sub di, 5438

; draw 'g'
	mov dx, 2
	loop5g:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop5g

	popa
	ret

drawSix:
	pusha
; Move head to the centre of the cell

	add di, 323
; draw 'a'
	mov dx, 2
	loop6a:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop6a

	add di, 334

	add di, 4480        ; leave gap for b

	add di, 1920		; leave 6 lines after b

; draw 'c'
	mov dx, 14
	loop6c:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop6c

	add di, 319

; draw 'd'
	std

	mov dx, 2
	loop6d:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop6d

	cld

	sub di, 11855

; draw 'f'
	mov dx, 14
	loop6f:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop6f

	add di, 1600

; draw 'e'
	mov dx, 14
	loop6e:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop6e

	sub di, 5438

; draw 'g'
	mov dx, 2
	loop6g:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop6g

	popa
	ret

drawSeven:
	pusha
; Move head to the centre of the cell

	add di, 323
; draw 'a'
	mov dx, 2
	loop7a:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop7a

	add di, 334

; draw 'b'
	mov dx, 15
	loop7b:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop7b

	add di, 1280		; leave 6 lines after b

; draw 'c'
	mov dx, 15
	loop7c:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop7c

	popa
	ret

drawEight:
	pusha
; Move head to the centre of the cell

	add di, 323
; draw 'a'
	mov dx, 2
	loop8a:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop8a

	add di, 334

; draw 'b'
	mov dx, 14
	loop8b:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop8b

	add di, 1920		; leave 6 lines after b

; draw 'c'
	mov dx, 14
	loop8c:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop8c

	add di, 319

; draw 'd'
	std

	mov dx, 2
	loop8d:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop8d

	cld

	sub di, 11855

; draw 'f'
	mov dx, 14
	loop8f:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop8f

	add di, 1600

; draw 'e'
	mov dx, 14
	loop8e:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop8e

	sub di, 5438

; draw 'g'
	mov dx, 2
	loop8g:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop8g

	popa
	ret

drawNine:
	pusha
; Move head to the centre of the cell

	add di, 323
; draw 'a'
	mov dx, 2
	loop9a:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop9a

	add di, 334

; draw 'b'
	mov dx, 14
	loop9b:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop9b

	add di, 1920		; leave 6 lines after b

; draw 'c'
	mov dx, 14
	loop9c:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop9c

	add di, 319

; draw 'd'
	std

	mov dx, 2
	loop9d:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop9d

	cld

	sub di, 11855

; draw 'f'
	mov dx, 14
	loop9f:
	mov cx, 2

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop9f

	add di, 642

; draw 'g'
	mov dx, 2
	loop9g:
	mov cx, 14

	push di
	rep stosb
	pop di

	add di, 320
	dec dx
	jnz loop9g

	popa
	ret

printnum:                                 ; Score print function
	push bp
	mov bp, sp
	pusha


	mov ax, [bp + 4] 				; load number in ax
	mov bx, 10 						; use base 10 for division
	mov cx, 0 						; initialize count of digits

	mov di, 43121					; Start printing score from here

nextdigit:
	mov dx, 0 						; zero upper half of dividend
	div bx 							; divide by 10
	add dl, 0x30 					; convert digit into ascii value
	push dx 						; save ascii value on stack
	inc cx 							; increment count of values
	cmp ax, 0 						; is the quotient zero
	jnz nextdigit 					; if no divide it again

nextpos:
	pop dx 							; remove a digit from the stack

	mov al, 0x0F					; Color of the number
	cmp dl, '9'
	je printNine

	cmp dl, '8'
	je printEight

	cmp dl, '7'
	je printSeven

	cmp dx, '6'
	je printSix

	cmp dx, '5'
	je printFive

	cmp dx, '4'
	je printFour

	cmp dx, '3'
	je printThree

	cmp dx, '2'
	je printTwo

	cmp dx, '1'
	je printOne


	; Else draw zero
	call drawZero
	jmp moveToNextDigit

	printOne:
	call drawOne
	jmp moveToNextDigit

	printTwo:
	call drawTwo
	jmp moveToNextDigit

	printThree:
	call drawThree
	jmp moveToNextDigit

	printFour:
	call drawFour
	jmp moveToNextDigit

	printFive:
	call drawFive
	jmp moveToNextDigit

	printSix:
	call drawSix
	jmp moveToNextDigit

	printSeven:
	call drawSeven
	jmp moveToNextDigit

	printEight:
	call drawEight
	jmp moveToNextDigit

	printNine:
	call drawNine

	moveToNextDigit:
	add di, 22
	loop nextpos					; if no divide it again

	popa
	pop bp
	ret 2

clearScore:
	pusha

	mov al, 00			; To print blank space
	mov cx, 70			; We clear 50 rows
	mov di, 30281
	add di, 3200
	add di, 3200
	add di, 3200

	outerClearLoopScore:
		mov dx, 100			; We clear 100 columns
		push di
		InnerClearLoopScore:
			stosb
			dec dx
			jnz InnerClearLoopScore
		pop di
		add di, 320
		loop outerClearLoopScore

	popa
	ret

drawBattery:
	push bp
	mov bp, sp
	pusha

	mov di, 845                      ; starting index of our battery

	mov bx, [bp + 4]                 ; number of lives

	mov al, 0xC                      ; color
	mov dx, 24                       ; rows
	mov cx, 32                      ; columns

	push di
	rep stosb                        ; top horizontal line
	pop di

	batteryLoop1:                    ; left vertical line
		add di, 320
		mov [es: di], al
		dec dx
		cmp dx, 0
		jnz batteryLoop1

	mov cx, 32
	rep stosb                       ; bottom horizontal line

	mov dx, 24

	batteryLoop2:                   ; right vertical line
		sub di, 320
		mov [es: di], al
		dec dx
		cmp dx, 0
		jnz batteryLoop2

	cmp bx, 3
	je threeBars

	cmp bx, 2
	je twoBars

	cmp bx, 1
	je oneBar

threeBars:
	mov al, 0x0A
	mov di, 1165
	add di, 322

	push di
	mov dx, 21
	bar1of3:
		mov cx, 9

		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		cmp dx, 0
		jnz bar1of3
	pop di

	add di, 10

	push di
	mov dx, 21
	bar2of3:
		mov cx, 9

		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		cmp dx, 0
		jnz bar2of3
	pop di

	add di, 10

	push di
	mov dx, 21
	bar3of3:
		mov cx, 9

		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		cmp dx, 0
		jnz bar3of3
	pop di

	jmp exit

twoBars:
	mov al, 0x07
	mov di, 1165
	add di, 322

	push di
	mov dx, 21
	bar1of2:
		mov cx, 9

		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		cmp dx, 0
		jnz bar1of2
	pop di

	add di, 10

	push di
	mov dx, 21
	bar2of2:
		mov cx, 9

		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		cmp dx, 0
		jnz bar2of2
	pop di

	jmp exit

oneBar:
	mov al, 0x4
	mov di, 1165
	add di, 322

	push di
	mov dx, 21
	bar1of1:
		mov cx, 9

		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		cmp dx, 0
		jnz bar1of1
	pop di

exit:
	popa
	pop bp
	ret 2

clrBattery:
	pusha

	mov al, 00			; To print blank space
	mov cx, 50			; We clear 50 rows
	mov di, 845

	outerClearLoopBattery:
		mov dx, 42			; We clear 100 columns
		push di
		InnerClearLoopBattery:
			stosb
			dec dx
			jnz InnerClearLoopBattery
		pop di
		add di, 320
		loop outerClearLoopBattery

	popa
	ret

printScore:
	pusha

	mov di, 30291			; position where we wanna print "Score"
	mov al, 0x0F			; Color of "Score"

	push di
; Draw S
	mov dx, 2
	topLineS:
		mov cx, 9
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz topLineS

	push di
	add di, 7

	mov dx, 2
	sidechick1:
		mov cx, 2
		push di
		rep stosb
		pop di

		add di, 320

		dec dx
		jnz sidechick1

	pop di

	sub di, 2

	mov dx, 9
	leftLineS:
		mov cx, 2
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz leftLineS

	add di, 321

	mov dx, 2
	middleLineS:
		mov cx, 9
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz middleLineS

	add di, 328

	mov dx, 9
	rightLineS:
		mov cx, 2
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz rightLineS

	add di, 320
	sub di, 8

	mov dx, 2
	bottomLineS:
		mov cx, 9
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz bottomLineS

	sub di, 960
	mov dx, 2

	sidechick2:
		mov cx, 2
		push di
		rep stosb
		pop di

		sub di, 320

		dec dx
		jnz sidechick2

	pop di

	add di, 13

	push di
; Draw C
	add di, 960
	mov dx, 2
	topLineC:
		mov cx, 9
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz topLineC

	add di, 319

	mov dx, 18
	leftLineC:
		mov cx, 2
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz leftLineC

	add di, 321

	mov dx, 2
	bottomLineC:
		mov cx, 9
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz bottomLineC
	pop di

	add di, 13

	push di
; Draw O
	add di, 960
	mov dx, 2
	topLineO:
		mov cx, 9
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz topLineO

	add di, 319

	mov dx, 18
	leftLineO:
		mov cx, 2
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz leftLineO

	add di, 320

	mov dx, 2
	bottomLineO:
		mov cx, 10
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz bottomLineO

	sub di, 1271

	mov dx, 18
	rightLineO:
		mov cx, 2
		push di
		rep stosb
		pop di

		sub di, 320
		dec dx
		jnz rightLineO
	pop di

	add di, 13

	push di
; Draw R
	add di, 960

	mov dx, 2
	topLineR:
		mov cx, 9
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz topLineR

	push di

	add di, 319

	mov dx, 21
	leftLineR:
		mov cx, 2
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz leftLineR

	pop di

	add di, 328

	mov dx, 8
	rightLineR:
		mov cx, 2
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz rightLineR

	add di, 320

	std
	mov dx, 2
	RkaPet:
		mov cx, 7
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz RkaPet
	cld

	sub di, 7
	add di, 321

	mov dx, 8
	Rdiagonal:
		mov cx, 2
		push di
		rep stosb
		pop di

		add di, 321
		dec dx
		jnz Rdiagonal

	pop di

	add di, 14

	push di
; Draw E
	add di, 960

	mov dx, 2
	topLineE:
		mov cx, 9
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz topLineE

	add di, 319

	mov dx, 18
	leftLineE:
		mov cx, 2
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz leftLineE

	add di, 320

	mov dx, 2
	bottomLineE:
		mov cx, 9
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz bottomLineE

	sub di, 3840

	add di, 3

	mov dx, 2
	middleLineE:
		mov cx, 7
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz middleLineE

	pop di

	add di, 335

	push di
; Draw colon
    add di, 2240
    mov dx, 3
    Score_colonLoop1:
        mov cx, 3
        push di
        rep stosb
        pop di

    add di, 320
    dec dx
    jnz Score_colonLoop1

    add di, 2880

    mov dx, 3
    Score_colonLoop2:
        mov cx, 3
        push di
        rep stosb
        pop di

    add di, 320
    dec dx
    jnz Score_colonLoop2
	pop di

	popa
	ret

printTimer:
	push bp
	mov bp, sp
	pusha

	push word [XPos]
	push word [YPos]

	mov ax, 0xA000       ; Video memory segment for mode 13h
    mov es, ax           ; Set ES to point to video memory

	mov ax, [bp+4]                             	; load number in ax
	mov bx, 10                                 	; use base 10 for division
	mov cx, 0 									; initialize count of digits

nextdigitTimer:
	mov dx, 0 									; zero upper half of dividend
	div bx 										; divide by 10
	add dl, 0x30 								; convert digit into ascii value
	push dx 									; save ascii value on stack
	inc cx 										; increment count of values
	cmp ax, 0 									; is the quotient zero
	jnz nextdigitTimer 							; if no divide it again

nextposTimer:
	pop dx 										; remove a digit from the stack

	cmp dx, '9'
	je printTimerNine

	cmp dx, '8'
	je printTimerEight

	cmp dx, '7'
	je printTimerSeven

	cmp dx, '6'
	je printTimerSix

	cmp dx, '5'
	je printTimerFive

	cmp dx, '4'
	je printTimerFour

	cmp dx, '3'
	je printTimerThree

	cmp dx, '2'
	je printTimerTwo

	cmp dx, '1'
	je printTimerOne

printTimerZero:
	pusha
	mov cx, [XPos]				; XPos
	mov dx, [YPos]				; YPos
    mov bl, 0x0F      			; Color
    mov si, ZERO
    call plot_char
	popa
	jmp nextNumber

printTimerOne:
	pusha
	mov cx, [XPos]				; XPos
	mov dx, [YPos]				; YPos
    mov bl, 0x0F      			; Color
    mov si, ONE
    call plot_char
	popa
	jmp nextNumber

printTimerTwo:
	pusha
	mov cx, [XPos]				; XPos
	mov dx, [YPos]				; YPos
    mov bl, 0x0F      			; Color
    mov si, TWO
	call plot_char
	popa
	jmp nextNumber

printTimerThree:
	pusha
	mov cx, [XPos]				; XPos
	mov dx, [YPos]				; YPos
    mov bl, 0x0F     			; Color
    mov si, THREE
	call plot_char
	popa
	jmp nextNumber

printTimerFour:
	pusha
	mov cx, [XPos]				; XPos
	mov dx, [YPos]				; YPos
    mov bl, 0x0F      			; Color
    mov si, FOUR
	call plot_char
	popa
	jmp nextNumber

printTimerFive:
	pusha
	mov cx, [XPos]				; XPos
	mov dx, [YPos]				; YPos
    mov bl, 0x0F     			; Color
    mov si, FIVE
	call plot_char
	popa
	jmp nextNumber

printTimerSix:
	pusha
	mov cx, [XPos]				; XPos
	mov dx, [YPos]				; YPos
    mov bl, 0x0F      			; Color
    mov si, SIX
	call plot_char
	popa
	jmp nextNumber

printTimerSeven:
	pusha
	mov cx, [XPos]				; XPos
	mov dx, [YPos]				; YPos
    mov bl, 0x0F      			; Color
    mov si, SEVEN
	call plot_char
	popa
	jmp nextNumber

printTimerEight:
	pusha
	mov cx, [XPos]				; XPos
	mov dx, [YPos]				; YPos
    mov bl, 0x0F      			; Color
    mov si, EIGHT
	call plot_char
	popa
	jmp nextNumber

printTimerNine:
	pusha
	mov cx, [XPos]				; XPos
	mov dx, [YPos]				; YPos
    mov bl, 0x0F      			; Color
    mov si, NINE
	call plot_char
	popa

nextNumber:
	add word [XPos], 8
	dec cx
	jnz	near nextposTimer 								; repeat for all digits on stack

	pop word [YPos]
	pop word [XPos]

	popa
	pop bp
	ret 2

timer:                                 ; timer interrupt service routine
    pusha

    mov ax, cs
    mov ds, ax

    inc word [delayCounter]                          ; Increment the delay counter

    ; Check if delayCounter has reached 18 (delay purpose)
    cmp word [delayCounter], 18
    jl skip_update                                  ; If it's less, skip the update

    ; Reset delayCounter
    mov word [delayCounter], 0

    ; Check if tickcount is still not 0
    cmp word [tickcount], 00
    je skip_update 								   ; If tickcount is 00 skip the update

    ; Increment tickcount
    dec word [tickcount]

	; CLear previous timer
	call clrTImer

    ; Push tickcount to the stack and call printnum
    push word [tickcount]
    call printTimer                                ; Print tick count

skip_update:
    ; End of interrupt procedure
    mov al, 0x20
    out 0x20, al                                  ; Signal end of interrupt

    popa
    iret

plot_char:
        pusha
        mov di, 8
    row_loop:
        mov al, [si]
        push cx
        mov ah, 8

    pixel_loop:
        test al, 10000000b
        jz skip_pixel

        push ax
        mov ah, 0Ch        ; Function 0Ch - Write pixel
        mov al, bl         ; Color
        mov bh, 0          ; Page 0
        int 10h            ; Draw pixel
        pop ax

    skip_pixel:
        inc cx
        shl al, 1
        dec ah
        jnz pixel_loop

        pop cx
        inc dx
        inc si
        dec di
        jnz row_loop

        popa
        ret

; 0
ZERO:
    db  00111100b
    db  01100110b
    db  01101110b
    db  01110110b
    db  01100110b
    db  01100110b
    db  00111100b
    db  00000000b

; 1
ONE:
    db  00011000b
    db  00111000b
    db  00011000b
    db  00011000b
    db  00011000b
    db  00011000b
    db  01111110b
    db  00000000b

; 2
TWO:
    db  00111100b
    db  01100110b
    db  00000110b
    db  00001100b
    db  00110000b
    db  01100000b
    db  01111110b
    db  00000000b

; 3
THREE:
    db  00111100b
    db  01100110b
    db  00000110b
    db  00111100b
    db  00000110b
    db  01100110b
    db  00111100b
    db  00000000b

; 4
FOUR:
    db  00001100b
    db  00011100b
    db  00111100b
    db  01101100b
    db  01111110b
    db  00001100b
    db  00001100b
    db  00000000b

; 5
FIVE:
    db  01111110b
    db  01100000b
    db  01111100b
    db  00000110b
    db  00000110b
    db  01100110b
    db  00111100b
    db  00000000b

; 6
SIX:
    db  00111100b
    db  01100000b
    db  01111100b
    db  01100110b
    db  01100110b
    db  01100110b
    db  00111100b
    db  00000000b

; 7
SEVEN:
    db  01111110b
    db  01100110b
    db  00000110b
    db  00001100b
    db  00011000b
    db  00011000b
    db  00011000b
    db  00000000b

; 8
EIGHT:
    db  00111100b
    db  01100110b
    db  01100110b
    db  00111100b
    db  01100110b
    db  01100110b
    db  00111100b
    db  00000000b

; 9
NINE:
    db  00111100b
    db  01100110b
    db  01100110b
    db  00111110b
    db  00000110b
    db  01100110b
    db  00111100b
    db  00000000b

; Font data
A:
    db  00111100b   ; A
    db  01100110b
    db  01100110b
    db  01111110b
    db  01100110b
    db  01100110b
    db  01100110b
    db  00000000b

B:
    db  11111100b
    db  11000110b
    db  11000110b
    db  11111100b
    db  11000110b
    db  11000110b
    db  11111100b
    db  00000000b

C:
    db  00111100b
    db  01100110b
    db  11000000b
    db  11000000b
    db  11000000b
    db  01100110b
    db  00111100b
    db  00000000b

D:
    db  11111000b
    db  11001100b
    db  11000110b
    db  11000110b
    db  11000110b
    db  11001100b
    db  11111000b
    db  00000000b

E:
    db  11111110b
    db  11000000b
    db  11000000b
    db  11111100b
    db  11000000b
    db  11000000b
    db  11111110b
    db  00000000b

F:
    db  11111110b
    db  11000000b
    db  11000000b
    db  11111100b
    db  11000000b
    db  11000000b
    db  11000000b
    db  00000000b

G:
    db  00111100b
    db  01100110b
    db  11000000b
    db  11001110b
    db  11000110b
    db  01100110b
    db  00111110b
    db  00000000b

H:
    db  11000110b
    db  11000110b
    db  11000110b
    db  11111110b
    db  11000110b
    db  11000110b
    db  11000110b
    db  00000000b

I:
    db  00111100b
    db  00011000b
    db  00011000b
    db  00011000b
    db  00011000b
    db  00011000b
    db  00111100b
    db  00000000b

J:
    db  00011110b
    db  00001100b
    db  00001100b
    db  00001100b
    db  11001100b
    db  11001100b
    db  01111000b
    db  00000000b

K:
    db  11000110b
    db  11001100b
    db  11011000b
    db  11110000b
    db  11011000b
    db  11001100b
    db  11000110b
    db  00000000b

L:
    db  11000000b
    db  11000000b
    db  11000000b
    db  11000000b
    db  11000000b
    db  11000000b
    db  11111110b
    db  00000000b

M:
    db  11000011b
    db  11100111b
    db  11111111b
    db  11011011b
    db  11000011b
    db  11000011b
    db  11000011b
    db  00000000b

N:
    db  11000011b
    db  11100011b
    db  11110011b
    db  11011011b
    db  11001111b
    db  11000111b
    db  11000011b
    db  00000000b

O:
    db  00111100b
    db  01100110b
    db  11000011b
    db  11000011b
    db  11000011b
    db  01100110b
    db  00111100b
    db  00000000b

P:
    db  11111100b
    db  11000110b
    db  11000110b
    db  11111100b
    db  11000000b
    db  11000000b
    db  11000000b
    db  00000000b

Q:
    db  00111100b
    db  01100110b
    db  11000011b
    db  11000011b
    db  11001011b
    db  01100110b
    db  00111110b
    db  00000000b

R:
    db  11111100b
    db  11000110b
    db  11000110b
    db  11111100b
    db  11011000b
    db  11001100b
    db  11000110b
    db  00000000b

S:
    db  00111100b
    db  01100110b
    db  01100000b
    db  00111100b
    db  00000110b
    db  01100110b
    db  00111100b
    db  00000000b

T:
    db  11111111b
    db  00011000b
    db  00011000b
    db  00011000b
    db  00011000b
    db  00011000b
    db  00011000b
    db  00000000b

U:
    db  11000011b
    db  11000011b
    db  11000011b
    db  11000011b
    db  11000011b
    db  11000011b
    db  01111110b
    db  00000000b

V:
    db  11000011b
    db  11000011b
    db  11000011b
    db  11000011b
    db  01100110b
    db  00111100b
    db  00011000b
    db  00000000b

W:
    db  11000011b
    db  11000011b
    db  11000011b
    db  11000011b
    db  11011011b
    db  11111111b
    db  01100110b
    db  00000000b

X:
    db  11000011b
    db  01100110b
    db  00111100b
    db  00011000b
    db  00111100b
    db  01100110b
    db  11000011b
    db  00000000b

Y:
    db  11000110b
    db  01100110b
    db  00111100b
    db  00011000b
    db  00011000b
    db  00011000b
    db  00011000b
    db  00000000b

Z:
    db  11111111b
    db  00000110b
    db  00001100b
    db  00011000b
    db  00110000b
    db  01100000b
    db  11111111b
    db  00000000b

clrTImer:
	pusha

	mov al, 00			; To print blank space
	mov cx, 20			; We clear 50 rows
	mov di, 280
	add di, 3200

	outerClearLoopTimer:
		mov dx, 20			; We clear 100 columns
		push di
		InnerClearLoopTimer:
			stosb
			dec dx
			jnz InnerClearLoopTimer
		pop di
		add di, 320
		loop outerClearLoopTimer

	popa
	ret

clrscr:
	push bp
	mov bp,sp
	pusha

	mov cx, 64000
	mov al, 00
	mov di, 0

	cld
	rep stosb

	popa
	pop bp
	ret

SuperManMode:
	pusha

	mov al, 0x00
	mov di, 202
	mov dx, 200			; rows

	superLoop1:				; clear half screen for superman mode prompt
		mov cx, 119
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz superLoop1

promptPrinting:
	mov cx, 202       ; X position (column)
    mov dx, 22        ; Y position (row)
    mov bl, 0x0F      ; Color

	push cx
; Printing "YOU"
    mov si, Y
    call plot_char

	add cx, 8
	mov si, O
	call plot_char

	add cx, 9
	mov si, U
	call plot_char

; Printing "HAVE"
	add cx, 13
	mov si, H
	call plot_char

	add cx, 9
	mov si, A
	call plot_char

	add cx, 9
	mov si, V
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

	pop cx

; Printing "ENTERED"
	push cx

	add dx, 12
	inc cx
	mov si, E
	call plot_char

	add cx, 9
	mov si, N
	call plot_char

	add cx, 9
	mov si, T
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

	add cx, 9
	mov si, R
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

	add cx, 9
	mov si, D
	call plot_char

; Printing "THE"
	add cx, 13
	mov si, T
	call plot_char

	add cx, 9
	mov si, H
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

	pop cx

; Printing "SUPERMAN"
	push cx

	add dx, 12
	mov si, S
	call plot_char

	add cx, 9
	mov si, U
	call plot_char

	add cx, 9
	mov si, P
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

	add cx, 9
	mov si, R
	call plot_char

	add cx, 9
	mov si, M
	call plot_char

	add cx, 9
	mov si, A
	call plot_char

	add cx, 9
	mov si, N
	call plot_char

; Printing "MODE"
	add cx, 13
	mov si, M
	call plot_char

	add cx, 9
	mov si, O
	call plot_char

	add cx, 9
	mov si, D
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

; draw a line with diamonds
	mov al,  0x07
	add dx, 15
	mov di, 18761                         ; 59th row, 202 column

	push di
	mov cx, 12
	drawDiamondLineloop1:
		call drawDiamond
		add di, 10
		loop drawDiamondLineloop1

	pop di
	add di, 3200
	add dx, 12
	mov cx, 12
	drawDiamondLineloop2:
		call drawDiamond
		add di, 10
		loop drawDiamondLineloop2
	pop cx

; Printing "PRESS"
	push cx

	add dx, 15
	mov si, P
	call plot_char

	add cx, 9
	mov si, R
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

	add cx, 8
	mov si, S
	call plot_char

	add cx, 8
	mov si, S
	call plot_char

; Printing "B"
	add cx, 13
	mov si, B
	call plot_char

; Printing "TO"
	add cx, 13
	mov si, T
	call plot_char

	add cx, 9
	mov si, O
	call plot_char

	pop cx

; Printing "RESTORE"
	push cx

	add dx, 12
	mov si, R
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

	add cx, 8
	mov si, S
	call plot_char

	add cx, 9
	mov si, T
	call plot_char

	add cx, 9
	mov si, O
	call plot_char

	add cx, 9
	mov si, R
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

; Printing "HEALTH"
	add cx, 13
	mov si, H
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

	add cx, 8
	mov si, A
	call plot_char

	add cx, 9
	mov si, L
	call plot_char

	add cx, 6
	mov si, T
	call plot_char

	add cx, 9
	mov si, H
	call plot_char

	pop cx

; Printing "OR"
	push cx
	add dx, 15
	add cx, 40

	mov si, O
	call plot_char

	add cx, 9
	mov si, R
	call plot_char

	pop cx

; Printing "PRESS"
	push cx

	add dx, 15
	mov si, P
	call plot_char

	add cx, 9
	mov si, R
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

	add cx, 8
	mov si, S
	call plot_char

	add cx, 8
	mov si, S
	call plot_char

; Printing "T"
	add cx, 13
	mov si, T
	call plot_char

; Printing "TO"
	add cx, 13
	mov si, T
	call plot_char

	add cx, 9
	mov si, O
	call plot_char

	pop cx

; Printing "INCREASE"
	push cx

	sub cx, 2
	add dx, 12
	mov si, I
	call plot_char

	add cx, 8
	mov si, N
	call plot_char

	add cx, 9
	mov si, C
	call plot_char

	add cx, 9
	mov si, R
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

	add cx, 8
	mov si, A
	call plot_char

	add cx, 8
	mov si, S
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

; Printing "TIME"
	add cx, 13
	mov si, T
	call plot_char

	add cx, 7
	mov si, I
	call plot_char

	add cx, 8
	mov si, M
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

	pop cx

; draw a line with diamonds
	mov al,  0x07
	add dx, 15
	mov di, 49481                         ; 155th row, 202 column

	push di
	mov cx, 12
	drawDiamondLineloop3:
		call drawDiamond
		add di, 10
		loop drawDiamondLineloop3

	pop di
	add di, 3200
	add dx, 12
	mov cx, 12
	drawDiamondLineloop4:
		call drawDiamond
		add di, 10
		loop drawDiamondLineloop4

takeSuperInput:
	mov ah, 00
	int 0x16

	cmp al, 't'
	je incrementTimer

	cmp al, 'T'
	je incrementTimer

	cmp al, 'b'
	je restoreHealth

	cmp al, 'B'
	je restoreHealth

	jmp takeSuperInput

incrementTimer:
	add word [tickcount], 5
	jmp exitSuperManMode

restoreHealth:
	inc word [lives]

exitSuperManMode:

	mov al, 0x00
	mov di, 202
	mov dx, 200			; rows

	superLoop2:				; clear half screen for displaying again
		mov cx, 119
		push di
		rep stosb
		pop di

		add di, 320

		dec dx
		jnz superLoop2

	call printScore
	push word [score]
	call printnum

	; call clrBattery
	push word [lives]
	call drawBattery

	mov word [supermanMode], 0

	popa
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		ENDING SCREENS			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

drawLoseScreen:
	pusha

	xor di, di
	mov cx, 64000

	mov al, 22		; Background color

	rep stosb

	mov al, 00		; Maze Color - Black

	push losingmaze
	call printFinalMaze

	mov cx, 110		; X position
    mov dx, 31		; Y position
    mov bl, 00		; Color

; "GAME OVER"
	push cx
    mov si, G
    call plot_char

	add cx, 8
	mov si, A
	call plot_char

	add cx, 8
	mov si, M
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

	add cx, 14
	mov si, O
	call plot_char

	add cx, 9
	mov si, V
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

	add cx, 8
	mov si, R
	call plot_char
	pop cx

; Print an outer block on "GAME OVER"
	push cx
	push dx

	mov di, 320*30
	add di, 100
	sub di, 1600

	mov cx, 5				; Size of -

	mov dx, 13				; No of -
	upperLoseBlockLoop:
		rep stosb

		call delay

		add di, 2
		mov cx, 5
		dec dx
		jnz upperLoseBlockLoop

	add di, 320

	mov dx, 3				; No of -
	rightLoseBlockLoop:
		mov cx, 5
		drawRightDashL:
			mov [es:di], al
			add di, 320
			loop drawRightDashL

		call delay

		add di, 640
		dec dx
		jnz rightLoseBlockLoop

	sub di, 320

	mov dx, 14				; No of -
	std
	lowerLoseBlockLoop:
		rep stosb

		call delay

		sub di, 2
		mov cx, 5
		dec dx
		jnz lowerLoseBlockLoop
	cld

	sub di, 320

	mov dx, 3				; No of -
	leftLoseBlockLoop:
		mov cx, 5
		drawLeftDashL:
			mov [es:di], al
			sub di, 320
			loop drawLeftDashL

		call delay

		sub di, 640
		dec dx
		jnz leftLoseBlockLoop

	pop dx
	pop cx

; "YOU LOST"
	mov bl, 0x0F
	add cx, 4
	add dx, 25
	mov si, Y
	call plot_char

	add cx, 9
	mov si, O
	call plot_char

	add cx, 9
	mov si, U
	call plot_char

	add cx, 14
	mov si, L
	call plot_char

	add cx, 8
	mov si, O
	call plot_char

	add cx, 9
	mov si, S
	call plot_char

	add cx, 9
	mov si, T
	call plot_char

	mov al, 0x0F
	mov di, 320*86
	sub di, 7496

	push di
	mov [es:di], al
	inc di
	mov [es:di], al
	add di, 320
	mov [es:di], al
	dec di
	mov [es:di], al
	pop di

	add di, 4

	push di
	mov [es:di], al
	inc di
	mov [es:di], al
	add di, 320
	mov [es:di], al
	dec di
	mov [es:di], al
	pop di

	add di, 4
	push di
	mov [es:di], al
	inc di
	mov [es:di], al
	add di, 320
	mov [es:di], al
	dec di
	mov [es:di], al
	pop di

; "Your Score is: (score)"
	mov cx, 86		; X position
    add dx, 13		; Y position
    mov bl, 0x0F	; Color
	mov si, Y
	call plot_char

	add cx, 8
	mov si, O
	call plot_char

	add cx, 9
	mov si, U
	call plot_char

	add cx, 9
	mov si, R
	call plot_char

	add cx, 12
	mov si, S
	call plot_char

	add cx, 9
	mov si, C
	call plot_char

	add cx, 9
	mov si, O
	call plot_char

	add cx, 9
	mov si, R
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

	add cx, 10
	mov si, I
	call plot_char

	add cx, 7
	mov si, S
	call plot_char

; Drawing colon
	mov di, 31*320
	add di, 195
	add di, 3200
	add di, 3200
	add di, 3200
	add di, 3200
	sub di, 320
	sub di, 3
	mov al, 0x0F

	mov [es:di], al
	dec di
	mov [es:di], al
	inc di
	add di, 320
	mov [es:di], al
	dec di
	mov [es:di], al
	inc di

	add di, 320*3
	mov [es:di], al
	dec di
	mov [es:di], al
	inc di
	add di, 320
	mov [es:di], al
	dec di
	mov [es:di], al
	inc di

	mov word [XPos], 200
	mov word [YPos], 69

	push word [score]
	call printTimer

	popa
	ret

drawWinScreen:
	pusha

	xor di, di
	mov cx, 64000

	mov al, 3		; Background color - Teal

	rep stosb

	mov al, 170		; Maze Color - Lime Green

	push winningMaze
	call printFinalMaze

	mov cx, 85			; X position
    mov dx, 31			; Y position
    mov bl, 170			; Color

; "CONGRATULATIONS"
	push cx
    mov si, C
    call plot_char

	add cx, 8
	mov si, O
	call plot_char

	add cx, 9
	mov si, N
	call plot_char

	add cx, 9
	mov si, G
	call plot_char

	add cx, 8
	mov si, R
	call plot_char

	add cx, 8
	mov si, A
	call plot_char

	add cx, 8
	mov si, T
	call plot_char

	add cx, 9
	mov si, U
	call plot_char

	add cx, 9
	mov si, L
	call plot_char

	add cx, 8
	mov si, A
	call plot_char

	add cx, 8
	mov si, T
	call plot_char

	add cx, 8
	mov si, I
	call plot_char

	add cx, 8
	mov si, O
	call plot_char

	add cx, 9
	mov si, N
	call plot_char

	add cx, 9
	mov si, S
	call plot_char
	pop cx

; Print an outer block on "CONGRATULATIONS"
	push cx
	push dx

	mov di, 320*30
	sub di, 1519

	mov cx, 5		        ; Size of -

	mov dx, 19				; No of -
	upperWinBlockLoop:
		rep stosb

		call delay

		add di, 2
		mov cx, 5
		dec dx
		jnz upperWinBlockLoop

	add di, 320

	mov dx, 3				; No of -
	rightWinBlockLoop:
		mov cx, 5
		drawRightDashW:
			mov [es:di], al
			add di, 320
			loop drawRightDashW

		call delay

		add di, 640
		dec dx
		jnz rightWinBlockLoop

	sub di, 320

	mov dx, 20				; No of -
	std
	lowerWinBlockLoop:
		rep stosb

		call delay

		sub di, 2
		mov cx, 5
		dec dx
		jnz lowerWinBlockLoop
	cld

	sub di, 320

	mov dx, 3				; No of -
	leftWinBlockLoop:
		mov cx, 5
		drawLeftDashW:
			mov [es:di], al
			sub di, 320
			loop drawLeftDashW

		call delay

		sub di, 640
		dec dx
		jnz leftWinBlockLoop

	pop dx
	pop cx

; "YOU WON"
	mov bl, 0x0F
	add cx, 30
	add dx, 25
	mov si, Y
	call plot_char

	add cx, 9
	mov si, O
	call plot_char

	add cx, 9
	mov si, U
	call plot_char

	add cx, 14
	mov si, W
	call plot_char

	add cx, 9
	mov si, O
	call plot_char

	add cx, 9
	mov si, N
	call plot_char

	pusha

	mov al, 0x0F
	mov di, 320*86
	sub di, 10062
; Exclamation mark
	mov dx, 6
	exclamationLoop:
		mov cx, 2
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz exclamationLoop
	
	add di, 320
	add di, 320
	mov [es:di], al
	inc di
	mov [es:di], al
	add di, 320
	mov [es:di], al
	dec di
	mov [es:di], al

	popa

	; "Your Score is: (score)"
	mov cx, 86		; X position
    add dx, 13		; Y position
    mov bl, 0x0F	; Color
	mov si, Y
	call plot_char

	add cx, 8
	mov si, O
	call plot_char

	add cx, 9
	mov si, U
	call plot_char

	add cx, 9
	mov si, R
	call plot_char

	add cx, 12
	mov si, S
	call plot_char

	add cx, 9
	mov si, C
	call plot_char

	add cx, 9
	mov si, O
	call plot_char

	add cx, 9
	mov si, R
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

	add cx, 10
	mov si, I
	call plot_char

	add cx, 7
	mov si, S
	call plot_char

; Drawing colon
	mov di, 31*320
	add di, 12672
	mov al, 0x0F

	mov [es:di], al
	dec di
	mov [es:di], al
	inc di
	add di, 320
	mov [es:di], al
	dec di
	mov [es:di], al
	inc di

	add di, 320*3
	mov [es:di], al
	dec di
	mov [es:di], al
	inc di
	add di, 320
	mov [es:di], al
	dec di
	mov [es:di], al
	inc di

	mov word [XPos], 200
	mov word [YPos], 69

	push word [score]
	call printTimer

	popa
	ret

printFinalMaze:
	push bp
	mov bp, sp
	pusha

	mov cx, 19			; We iterate outer loop via cx
	mov dx, 0			; We iterate inner loop via dx
	mov si, [bp + 4]    ; load maze
	mov di, 80*320
	add di, 3295
	rowsFinal:
		push di
		columnsFinal:
			cmp byte [si], 0
			je iterateInnerLoopFinal	; Skip if zero

		; Else print block
			call drawCellFinal          ; Store AL at ES:DI (write pixel)
			call delay

			iterateInnerLoopFinal:
			add di, 5
			inc si
			inc dx
			cmp dx, 20
			jne columnsFinal
		pop di

		add di, 1600
		mov dx, 0
		loop rowsFinal

	popa
	pop bp
	ret 2

drawCellFinal:
	pusha

	mov dx, 5			; We use dx for the length of our cell

	rect_loopFinal:
		push di
		mov cx, 5		; We use cx for the width of our cell
		rep stosb
		pop di
		add di, 320
		dec dx
		jnz rect_loopFinal

	popa
	ret

drawFilledCell:
	pusha

	mov dx, 10			; We use dx for the length of our cell

	rect_filled_loop:
		push di
		mov cx, 10		; We use cx for the width of our cell
		rep stosb
		pop di
		add di, 320
		dec dx
		jnz rect_filled_loop

	popa
	ret

delay:
	push cx
	mov cx, 1				; change the values to increase delay time

delay_loop1:
	push cx

	mov cx, 0xFFFF
	delay_loop2:
		loop delay_loop2

	pop cx
	loop delay_loop1

	pop cx
	ret

delayCredits:
	push cx
	mov cx, 2				; change the values to increase delay time

delay_credit_loop1:
	push cx

	mov cx, 0xFFFF
	delay_credit_loop2:
		loop delay_credit_loop2

	pop cx
	loop delay_credit_loop1

	pop cx
	ret

delayCreatorsNames:
	push cx
	mov cx, 5				; change the values to increase delay time

delayCreatorsNames_loop1:
	push cx

	mov cx, 0xFFFF
	delayCreatorsNames_loop2:
		loop delayCreatorsNames_loop2

	pop cx
	loop delayCreatorsNames_loop1

	pop cx
	ret

delayButtons:
	push cx
	mov cx, 20				; change the values to increase delay time

delay_button_loop1:
	push cx

	mov cx, 0xFFFF
	delay_button_loop2:
		loop delay_button_loop2

	pop cx
	loop delay_button_loop1

	pop cx
	ret

delayTitle:
	push cx
	mov cx, 4				; change the values to increase delay time

delay_title_loop1:
	push cx

	mov cx, 0xFFFF
	delay_title_loop2:
		loop delay_title_loop2

	pop cx
	loop delay_title_loop1

	pop cx
	ret

delayScreen:
	push cx
	mov cx, 150				; change the values to increase delay time

delay_screen_loop1:
	push cx

	mov cx, 0xFFFF
	delay_screen_loop2:
		loop delay_screen_loop2

	pop cx
	loop delay_screen_loop1

	pop cx
	ret

printBorders:
	pusha

	mov cx, 8
	mov di, 0

; Upper Border
	upperBorder:
		mov al, 0x0B
		call drawCell
		call delay
		add di, 10

		mov al, 3
		call drawCell
		call delay
		add di, 10

		mov al, 8
		call drawCell
		call delay
		add di, 10

		mov al, 2
		call drawCell
		call delay
		add di, 10

		loop upperBorder

; Right Border
	sub di, 10
	add di, 3200
	mov cx, 4

	rightBorder:
		mov al, 0x0B
		call drawCell
		call delay
		add di, 3200

		mov al, 3
		call drawCell
		call delay
		add di, 3200

		mov al, 8
		call drawCell
		call delay
		add di, 3200

		mov al, 2
		call drawCell
		call delay
		add di, 3200

		loop rightBorder

	mov al, 0x0B
	call drawCell
	call delay
	add di, 3200

	mov al, 3
	call drawCell
	call delay
	add di, 3200

	mov al, 8
	call drawCell
	call delay

; Lower Border
	mov cx, 8

	lowerBorder:
		mov al, 0x0B
		call drawCell
		call delay
		sub di, 10

		mov al, 3
		call drawCell
		call delay
		sub di, 10

		mov al, 8
		call drawCell
		call delay
		sub di, 10

		mov al, 2
		call drawCell
		call delay
		sub di, 10

		loop lowerBorder

; Left Border
	add di, 10
	sub di, 3200
	mov cx, 4

	leftBorder:
		mov al, 0x0B
		call drawCell
		call delay
		sub di, 3200

		mov al, 3
		call drawCell
		call delay
		sub di, 3200

		mov al, 8
		call drawCell
		call delay
		sub di, 3200

		mov al, 2
		call drawCell
		call delay
		sub di, 3200

		loop leftBorder

	mov al, 0x0B
	call drawCell
	call delay
	sub di, 3200

	mov al, 3
	call drawCell

	popa
	ret

outlineButton:
	push bp
	mov bp, sp
	pusha

	mov di, [bp + 4]                 ; starting index of button

	mov al, [bp + 6]                    ; color
	mov dx, 22                       ; rows
	mov cx, 70                       ; columns

	push di
	rep stosb                        ; top horizontal line
	pop di
	push di
	add di, 320
	mov cx, 70
	rep stosb
	pop di

	outlineButtonLoop1:                    ; left vertical line
		add di, 320
		mov [es: di], al
		push di
		inc di
		mov [es: di], al
		pop di
		dec dx
		cmp dx, 0
		jnz outlineButtonLoop1

	mov cx, 70
	push di
	rep stosb                       ; bottom horizontal line

	pop di
	add di, 320
	mov cx, 70
	rep stosb
	add di, 320
	mov dx, 24

	outlineButtonLoop2:                   ; right vertical line
		sub di, 320
		mov [es: di], al
		push di
		inc di
		mov [es: di], al
		pop di
		dec dx
		cmp dx, 0
		jnz outlineButtonLoop2

	popa
	pop bp
	ret 4

drawNameCell:
	push bp
	mov bp, sp
	push cx
	push dx

	mov di, [bp + 4]

	mov cx, 3		        ; Size of -

	mov dx, 15				; No of -
	upperNameCellLoop:
		rep stosb

		call delayCredits

		add di, 2
		mov cx, 5
		dec dx
		jnz upperNameCellLoop

	add di, 320

	mov dx, 4				; No of -
	rightNameCellLoop:
		mov cx, 5
		drawRightCellLine:
			mov [es:di], al
			add di, 320
			loop drawRightCellLine

		call delayCredits

		add di, 640
		dec dx
		jnz rightNameCellLoop

	sub di, 320

	mov dx, 16				; No of -
	std
	lowerNameCellLoop:
		rep stosb

		call delayCredits

		sub di, 2
		mov cx, 5
		dec dx
		jnz lowerNameCellLoop
	cld

	sub di, 320

	mov dx, 4				; No of -
	leftNameCellLoop:
		mov cx, 5
		drawLeftCellLine:
			mov [es:di], al
			sub di, 320
			loop drawLeftCellLine

		call delayCredits

		sub di, 640
		dec dx
		jnz leftNameCellLoop

	pop dx
	pop cx
	pop bp
	ret 2

drawMenu:
	pusha
redrawMenu:
	call menuBackground
	call printBorders
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        PRINTING GAME NAME		                ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	call delayTitle
	mov bl, 0x0F
	mov cx, 100
	mov dx, 30
	mov si, M
	call plot_char

	call delayTitle
	add cx, 9
	mov si, A
	call plot_char

	call delayTitle
	add cx, 9
	mov si, Z
	call plot_char

	call delayTitle
	add cx, 9
	mov si, E
	call plot_char

	call delayTitle
	add cx, 14
	mov si, R
	call plot_char

	call delayTitle
	add cx, 9
	mov si, U
	call plot_char

	call delayTitle
	add cx, 9
	mov si, N
	call plot_char

	call delayTitle
	add cx, 9
	mov si, N
	call plot_char

	call delayTitle
	add cx, 9
	mov si, E
	call plot_char

	call delayTitle
	add cx, 9
	mov si, R
	call plot_char

	call delayTitle
; Drawing colon
	mov di, 31*320
	add di, 197
	mov al, 0x0F

	mov [es:di], al
	dec di
	mov [es:di], al
	inc di
	add di, 320
	mov [es:di], al
	dec di
	mov [es:di], al
	inc di

	add di, 320*3
	mov [es:di], al
	dec di
	mov [es:di], al
	inc di
	add di, 320
	mov [es:di], al
	dec di
	mov [es:di], al
	inc di

	call delayTitle
	mov cx, 80
	mov dx, 50
	mov si, T
	call plot_char

	call delayTitle
	add cx, 9
	mov si, H
	call plot_char

	call delayTitle
	add cx, 9
	mov si, E
	call plot_char

	call delayTitle
	add cx, 14
	mov si, S
	call plot_char

	call delayTitle
	add cx, 9
	mov si, C
	call plot_char

	call delayTitle
	add cx, 9
	mov si, O
	call plot_char

	call delayTitle
	add cx, 9
	mov si, R
	call plot_char

	call delayTitle
	add cx, 9
	mov si, C
	call plot_char

	call delayTitle
	add cx, 9
	mov si, H
	call plot_char

	call delayTitle
	add cx, 14
	mov si, T
	call plot_char

	call delayTitle
	add cx, 9
	mov si, R
	call plot_char

	call delayTitle
	add cx, 7
	mov si, I
	call plot_char

	call delayTitle
	add cx, 8
	mov si, A
	call plot_char

	call delayTitle
	add cx, 9
	mov si, L
	call plot_char

	call delayTitle
	add cx, 9
	mov si, S
	call plot_char

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        PRINTING MENU BUTTONS                     ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov cx, 138			; X position
	mov dx, 97			; Y position
	mov bl, 0x0F

	call delayButtons

	mov di, 28600
	mov ah, 0
	mov al, 2
	push ax
	push di
	call outlineButton			; Play button

	push cx
	mov si, P
	call plot_char
	add cx, 9
	mov si, L
	call plot_char

	add cx, 9
	mov si, A
	call plot_char

	add cx, 9
	mov si, Y
	call plot_char
	pop cx

	call delayButtons

	mov di, 38520
	mov ah, 0
	mov al, bl
	push ax
	push di						; Credits button
	call outlineButton

	push cx
	sub cx, 11
	add dx, 30
	mov si, C
	call plot_char

	add cx, 9
	mov si, R
	call plot_char

	add cx, 9
	mov si, E
	call plot_char

	add cx, 9
	mov si, D
	call plot_char

	add cx, 7
	mov si, I
	call plot_char

	add cx, 7
	mov si, T
	call plot_char

	add cx, 9
	mov si, S
	call plot_char
	pop cx

	call delayButtons

	mov di, 48120
	mov ah, 0
	mov al, bl
	push ax
	push di             ; Exit button
	call outlineButton

	add dx, 30
	mov si, E
	call plot_char

	add cx, 9
	mov si, X
	call plot_char

	add cx, 8
	mov si, I
	call plot_char

	add cx, 7
	mov si, T
	call plot_char

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        MENU SCROLLING                            ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
takeMenuInput:
	mov ah, 00
	int 0x16

	cmp al, 'w'					; if user pressed UP key, move UP
	je moveMenuUp

	cmp al, 's'					; if user pressed Down key, move Down
	je moveMenuDown

	cmp al, 13					; If user pressed enter key, go into that button
	je enterPressedMenu

moveMenuUp:
	mov bx, [currButton]
	cmp bx, 0
	je swapPlayerAndExit

	cmp bx, 1
	je swapCreditsAndPlayer

	cmp bx, 2
	je swapExitAndCredits

	swapPlayerAndExit:
		mov di, 28600
		mov ah, 0
		mov al, 0x0F				; make Play button white
		push ax
		push di
		call outlineButton			; Play button

		mov di, 48120
		mov ah, 0
		mov al, 2					; make Exit button wine red
		push ax
		push di             		; Exit button
		call outlineButton

		mov word [currButton], 2	; currButton is now at Exit

		jmp takeMenuInput

	swapCreditsAndPlayer:
		mov di, 38520
		mov ah, 0
		mov al, 0x0F				; make Credits button white
		push ax
		push di						; Credits button
		call outlineButton

		mov di, 28600
		mov ah, 0
		mov al, 2					; make Play button wine red
		push ax
		push di
		call outlineButton			; Play button

		mov word [currButton], 0	; currButton is now at Play

		jmp takeMenuInput

	swapExitAndCredits:
		mov di, 48120
		mov ah, 0
		mov al, 0x0F				; make Exit button white
		push ax
		push di             		; Exit button
		call outlineButton

		mov di, 38520
		mov ah, 0
		mov al, 2					; make Credits button wine red
		push ax
		push di						; Credits button
		call outlineButton

		mov word [currButton], 1	; currButton is now at Credits

		jmp takeMenuInput

moveMenuDown:
	mov bx, [currButton]
	cmp bx, 0
	je swapPlayerAndCredits

	cmp bx, 1
	je swapCreditsAndExit

	cmp bx, 2
	je swapExitAndPlayer

	swapPlayerAndCredits:
		mov di, 28600
		mov ah, 0
		mov al, 0x0F				; make Play button white
		push ax
		push di
		call outlineButton			; Play button

		mov di, 38520
		mov ah, 0
		mov al, 2					; make Credits button wine red
		push ax
		push di						; Credits button
		call outlineButton

		mov word [currButton], 1	; currButton is now at Credits

		jmp takeMenuInput

	swapCreditsAndExit:
		mov di, 38520
		mov ah, 0
		mov al, 0x0F				; make Credits button white
		push ax
		push di						; Credits button
		call outlineButton

		mov di, 48120
		mov ah, 0
		mov al, 2					; make Exit button wine red
		push ax
		push di             		; Exit button
		call outlineButton

		mov word [currButton], 2	; currButton is now at Exit

		jmp takeMenuInput

	swapExitAndPlayer:
		mov di, 48120
		mov ah, 0
		mov al, 0x0F				; make Exit button white
		push ax
		push di             		; Exit button
		call outlineButton

		mov di, 28600
		mov ah, 0
		mov al, 2					; make Play button wine red
		push ax
		push di
		call outlineButton			; Play button

		mov word [currButton], 0	; currButton is now at Play

		jmp takeMenuInput

enterPressedMenu:
	mov bx, [currButton]
	cmp bx, 0
	je playGame

	cmp bx, 1
	je displayCredits

	cmp bx, 2
	je exitGame

playGame:
	call clrscr
	call startGame
	jmp exitGame

displayCredits:
	call clrscr
	call creditsScreen
	jmp redrawMenu

exitGame:
	call exitingScreen

exitMenu:
	popa
	ret

menuBackground:
	push bp
	mov bp,sp
	pusha

	mov cx, 64000
	mov al, 250
	mov di, 0

	cld
	rep stosb

	popa
	pop bp
	ret

startGame:
	pusha

	; Set up our timer
	xor ax, ax
	mov es, ax 								; point es to IVT base

	cli 									; disable interrupts
	mov word [es:8*4], timer				; store offset at n*4
	mov [es:8*4+2], cs 						; store segment at n*4+2
	sti 									; enable interrupts

	; Set up segment for direct video memory access
    mov ax, 0xA000       					; Video memory segment for mode 13h
    mov es, ax           					; Set ES to point to video memory

	call generateRandomMaze

	push word [lives]
	call drawBattery

	push word [score]
	call printnum

	call printScore

	call movePlayer

	mov bx, [tickcount]
	mov word [tickcount], 0

	mov ax, [foundPie]
	cmp ax, 1
	je won

	; If lost, then print the losing screen
		call drawLoseScreen
		jmp endgame

	won:
		call drawWinScreen

	endgame:
		call delayScreen
		popa
		ret

creditsScreen:
	pusha
	xor di, di
	mov cx, 64000

	mov al, 250		; Background color - Oceans depth

	rep stosb

	mov di, 3200
	mov al, 00                 ; wine red
	mov cx, 31

; Drawing Outlines

	lineLoop1:
		call drawFilledCell
		add di, 10
		call delayCredits
		loop lineLoop1

	mov cx, 5
	lineLoop2:
		call drawFilledCell
		add di, 3200
		call delayCredits
		loop lineLoop2

	mov cx, 10
	lineLoop3:
		call drawFilledCell
		sub di, 10
		call delayCredits
		loop lineLoop3

	push word 16100
	call drawNameCell

	; Printing "Developer"'s names

	mov bl, 0x0F

	call delayCreatorsNames
; Ahsan.
	mov cx, 105            ; X - column
	mov dx, 60             ; Y - row

	mov si, A
	call plot_char
	call delayCreatorsNames

	add cx, 9
	mov si, H
	call plot_char
	call delayCreatorsNames

	add cx, 9
	mov si, S
	call plot_char
	call delayCreatorsNames

	add cx, 9
	mov si, A
	call plot_char
	call delayCreatorsNames

	add cx, 9
	mov si, N
	call plot_char
	call delayCreatorsNames

	add cx, 14
	mov si, B
	call plot_char
	call delayCreatorsNames

	add cx, 9
	mov si, A
	call plot_char
	call delayCreatorsNames

	add cx, 9
	mov si, I
	call plot_char
	call delayCreatorsNames

	add cx, 9
	mov si, G
	call plot_char

	push cx
	push dx

	sub di, 26
	add di, 3200

	mov cx, 7
	lineLoop4:
		call drawFilledCell
		sub di, 10
		call delayCredits
		loop lineLoop4

	mov cx, 5
	lineLoop5:
		call drawFilledCell
		add di, 3200
		call delayCredits
		loop lineLoop5

	mov cx, 11
	lineLoop6:
		call drawFilledCell
		add di, 10
		call delayCredits
		loop lineLoop6

	pop dx
	pop cx

	push word 33410
	call drawNameCell

	call delayCreatorsNames
; Sundas.
	mov bl, 0x0F
	mov cx, 129            ; X - column
	mov dx, 114            ; Y - row

	mov si, S
	call plot_char
	call delayCreatorsNames

	add cx, 9
	mov si, U
	call plot_char
	call delayCreatorsNames

	add cx, 9
	mov si, N
	call plot_char
	call delayCreatorsNames

	add cx, 9
	mov si, D
	call plot_char
	call delayCreatorsNames

	add cx, 9
	mov si, A
	call plot_char
	call delayCreatorsNames

	add cx, 9
	mov si, S
	call plot_char
	call delayCreatorsNames

	add cx, 14
	mov si, H
	call plot_char
	call delayCreatorsNames

	add cx, 9
	mov si, A
	call plot_char
	call delayCreatorsNames

	add cx, 9
	mov si, B
	call plot_char
	call delayCreatorsNames

	add cx, 8
	mov si, I
	call plot_char
	call delayCreatorsNames

	add cx, 8
	mov si, B
	call plot_char

	add di, 124
	add di, 3200

	mov cx, 6
	lineLoop7:
		call drawFilledCell
		add di, 10
		call delayCredits
		loop lineLoop7

	mov cx, 5
	lineLoop8:
		call drawFilledCell
		add di, 3200
		call delayCredits
		loop lineLoop8

	mov cx, 32
	lineLoop9:
		call drawFilledCell
		sub di, 10
		call delayCredits
		loop lineLoop9

	call delayScreen

	mov word [currButton], 0

	popa
	ret

exitingScreen:
	pusha
	call menuBackground

; Draw borders
	mov al, 00
	mov di, 0
	mov dx, 3
	call delayButtons

	drawTopBorder1:
		push di
		mov cx, 320
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz drawTopBorder1

	push di
	mov dx, 40
	drawLeftBorder1:
		mov cx, 3
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz drawLeftBorder1
	pop di

	call delayButtons

	mov al, 172
	add di, 1608
	mov dx, 3
	drawTopBorder2:
		push di
		mov cx, 304
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz drawTopBorder2

	push di
	mov dx, 60
	drawLeftBorder2:
		mov cx, 3
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz drawLeftBorder2
	pop di

	call delayButtons

	mov al, 00
	add di, 1608
	mov dx, 3
	drawTopBorder3:
		push di
		mov cx, 288
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz drawTopBorder3

	push di
	mov dx, 80
	drawLeftBorder3:
		mov cx, 3
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz drawLeftBorder3
	pop di

	call delayButtons

	mov al, 172
	add di, 1608
	mov dx, 3
	drawTopBorder4:
		push di
		mov cx, 272
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz drawTopBorder4

	push di
	mov dx, 100
	drawLeftBorder4:
		mov cx, 3
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz drawLeftBorder4
	pop di

	call delayButtons

	mov al, 00
	mov di, 320*197
	mov dx, 3
	drawBottomBorder1:
		mov cx, 320
		push di
		rep stosb
		pop di

		add di, 320
		dec dx
		jnz drawBottomBorder1

	push di
	add di, 317
	mov dx, 40
	drawRightBorder1:
		mov cx, 3
		push di
		rep stosb
		pop di

		sub di, 320
		dec dx
		jnz drawRightBorder1
	pop di

	call delayButtons

	mov al, 172
	sub di, 1912
	sub di, 320
	sub di, 320
	mov dx, 3
	drawBottomBorder2:
		mov cx, 306
		push di
		rep stosb
		pop di

		sub di, 320
		dec dx
		jnz drawBottomBorder2

	push di
	add di, 303
	mov dx, 60
	drawRightBorder2:
		mov cx, 3
		push di
		rep stosb
		pop di

		sub di, 320
		dec dx
		jnz drawRightBorder2
	pop di

	call delayButtons

	mov al, 00
	sub di, 1912
	mov dx, 3
	drawBottomBorder3:
		mov cx, 290
		push di
		rep stosb
		pop di

		sub di, 320
		dec dx
		jnz drawBottomBorder3

	push di
	add di, 287
	mov dx, 80
	drawRightBorder3:
		mov cx, 3
		push di
		rep stosb
		pop di

		sub di, 320
		dec dx
		jnz drawRightBorder3
	pop di

	call delayButtons

	mov al, 172
	sub di, 1912
	mov dx, 3
	drawBottomBorder4:
		mov cx, 272
		push di
		rep stosb
		pop di

		sub di, 320
		dec dx
		jnz drawBottomBorder4

	push di
	add di, 269
	mov dx, 100
	drawRightBorder4:
		mov cx, 3
		push di
		rep stosb
		pop di

		sub di, 320
		dec dx
		jnz drawRightBorder4
	pop di

	call delayButtons

; Print "EXITING"
	mov cx, 123		; X position
	mov dx, 82		; Y position
	mov bl, 0x0F	; COLOR
	mov si, E
	call plot_char

	call delay

	add cx, 9
	mov si, X
	call plot_char

	call delay

	add cx, 7
	mov si, I
	call plot_char

	call delay

	add cx, 8
	mov si, T
	call plot_char

	call delay

	add cx, 7
	mov si, I
	call plot_char

	call delay

	add cx, 8
	mov si, N
	call plot_char

	call delay

	add cx, 9
	mov si, G
	call plot_char

	call delay

	mov al, 0x0F
	mov di, 320*86
	add di, 182

	push di
	mov [es:di], al
	inc di
	mov [es:di], al
	add di, 320
	mov [es:di], al
	dec di
	mov [es:di], al
	pop di

	add di, 4

	push di
	mov [es:di], al
	inc di
	mov [es:di], al
	add di, 320
	mov [es:di], al
	dec di
	mov [es:di], al
	pop di

	add di, 4
	push di
	mov [es:di], al
	inc di
	mov [es:di], al
	add di, 320
	mov [es:di], al
	dec di
	mov [es:di], al
	pop di

; Print an outer block on "EXITING"
	push cx
	push dx

	mov di, 320*75
	add di, 116
	mov al, 0x0F

	mov cx, 5		        ; Size of -

	mov dx, 12				; No of -
	upperExitBlockLoop:
		rep stosb

		call delay

		add di, 2
		mov cx, 5
		dec dx
		jnz upperExitBlockLoop

	add di, 320

	mov dx, 3				; No of -
	rightExitBlockLoop:
		mov cx, 5
		drawRightDashE:
			mov [es:di], al
			add di, 320
			loop drawRightDashE

		call delay

		add di, 640
		dec dx
		jnz rightExitBlockLoop

	sub di, 320

	mov dx, 13				; No of -
	std
	lowerExitBlockLoop:
		rep stosb

		call delay

		sub di, 2
		mov cx, 5
		dec dx
		jnz lowerExitBlockLoop
	cld

	sub di, 320

	mov dx, 3				; No of -
	leftExitBlockLoop:
		mov cx, 5
		drawLeftDashE:
			mov [es:di], al
			sub di, 320
			loop drawLeftDashE

		call delay

		sub di, 640
		dec dx
		jnz leftExitBlockLoop
	pop dx
	pop cx

	popa
	ret

start:
    ; Set video mode 13h (320x200, 256 colors)
    mov ax, 0x0013       						; Set video mode 13h
    int 0x10             						; BIOS interrupt to change video mode

	; Set up segment for direct video memory access
    mov ax, 0xA000       					; Video memory segment for mode 13h
    mov es, ax           					; Set ES to point to video memory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;              COLOR HOOKING                       ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;; Maze color 1 (forest green) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		mov dx, 0x03c8
        mov al, 1
        out dx, al
        mov dx, 0x03c9

		mov al, 12  			; R
        out dx, al
        mov al, 31				; G
        out dx, al
        mov al, 17				; B
        out dx, al

;;;;;;;;;;;; Maze color 2 (wine red) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		mov dx, 0x03c8
        mov al, 2
        out dx, al
        mov dx, 0x03c9

		mov al, 31  			; R
        out dx, al
        mov al, 10
        out dx, al				; G
        mov al, 15
        out dx, al				; B

;;;;;;;;;;;; Maze color 3 (teal) + won screen background ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		mov dx, 0x03c8
        mov al, 3
        out dx, al
        mov dx, 0x03c9

		mov al, 00				; R
        out dx, al
        mov al, 31
        out dx, al				; G
        mov al, 31
        out dx, al				; B

;;;;;;;;;;;; Maze color 5 (slate blue) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		mov dx, 0x03c8
        mov al, 8
        out dx, al
        mov dx, 0x03c9

		mov al, 24  			; R
        out dx, al
        mov al, 24
        out dx, al				; G
        mov al, 31
        out dx, al				; B

;;;;;;;;;;;; Sky blue (diamond) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		mov dx, 0x03c8
        mov al, 0x0B
        out dx, al
        mov dx, 0x03c9

		mov al, 31				; R
        out dx, al
        mov al, 63
        out dx, al				; G
        mov al, 63
        out dx, al				; B

;;;;;;;;;;;; Burnt Umber (enemy) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		mov dx, 0x03c8
        mov al, 0x05
        out dx, al
        mov dx, 0x03c9

		mov al, 31				; R
        out dx, al
        mov al, 17
        out dx, al				; G
        mov al, 12
        out dx, al				; B

;;;;;;;;;;;; Goldfish Yellow (battery) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		mov dx, 0x03c8
		mov al, 0x07
		out dx, al

		mov dx, 0x03c9
		mov al, 255
		out dx, al			; R
		mov al, 223
		out dx, al			; G
		mov al, 0
		out dx, al			; B

;;;;;;;;;;;; Lime Green (final maze, won screen) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov dx, 0x03c8
	mov al, 170
	out dx, al

	mov dx, 0x03c9
	mov al, 40
	out dx, al			; R
	mov al, 46
	out dx, al			; G
	mov al, 25
	out dx, al			; B

;;;;;;;;;;;; Sea Moss (Menu Background) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov dx, 0x03c8
	mov al, 250
	out dx, al
	mov dx, 0x03c9

	mov al, 9			; R
	out dx, al
	mov al, 17
	out dx, al			; G
	mov al, 17
	out dx, al			; B

	call drawMenu

	jmp $