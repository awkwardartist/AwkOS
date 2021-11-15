org 0x7c00

section .text
entry:
    mov     [disk], dl      ; store disk ID
    call    clr_reg         ; clear general purpose regs

det_lmem:                    ; detect memory 
    clc                     ; clear carry flag
    int     0x12            ; req low memory from BIOS
    
    ; AX should now contain the amount of continuous memory in KB
    ; starting from 0x00. This is the amount of RAM under 1MB

    jc mem_err
    mov     [l_mem], ax     ; store low memory
det_umem:
    call    clr_reg         ; prepare for upper memory detection
    

mem_err:

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
        resq 2
        resw 1