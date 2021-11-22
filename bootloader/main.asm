org 0x7c00                  ; kernel SHOULD be loaded here

section .text
    ; I'm an asm wizard, wizzidi woo, computer science is coo
entry:
    mov     [disk], dl      ; store disk ID
    call    clr_reg         ; clear general purpose regs

det_lmem:                    ; detect memory 
    clc                     ; clear carry flag
    int     0x12            ; req low memory from BIOS
    
    ; AX should now contain the amount of continuous memory in KB
    ; starting from 0x00. This is the amount of RAM under 1MB

    mov     [l_mem], ax     ; store low memory
    call    clr_reg         ; prepare for next step

enable_a20:
    ; checks whether or not the A20 line has already been enabled by BIOS
    ; if not, enable the A20 line 

    cli                     ; disable interrupts

    ; set ES
    xor     ax, ax
    mov     es, ax          ; es = 0

    ; set DS
    mov     ax, 0xFFFF      ; fill ax
    mov     ds, ax          ; ds = 0xFFFF    

    mov di, 0x0500
    mov si, 0x0510

    mov     al, byte [es:di]
    push    ax              ; store 0x[es:di]FF

    mov     al, byte [ds:si]
    push    ax              ; store 0x[ds:si]FF

    mov     byte [es:di], 0x00
    mov     byte [ds:si], 0xFF
    
;; makes this OS bootable by placing magic values in the boot sector
boot:   
    times 510-($-$$) db 0
    dw      0xaa55

clr_reg:
    xor     ax, ax
    xor     bx, bx
    xor     cx, cx
    xor     dx, dx
    ret

section .data
    disk:   db 0
    l_mem:  db 0
    
section .bss
    u_mem:
        