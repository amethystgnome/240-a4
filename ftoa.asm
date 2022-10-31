; //****************************************************************************************************************************
; //Program name: "ftoa". 
; //               Copyright (C) 2022 Aubrianna Sample
; //                                                                                                                           *
; //This file is part of the software program  ftoa".                                                                   *
; / ftoa is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
; //version 3 as published by the Free Software Foundation.                                                                    *
; / ftoa is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
; //warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *

; //A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *


; //****************************************************************************************************************************
; //=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**//

; //Author information
; //  Author name: Aubrianna Sample
; //  Author email: aubriannasample@csu.fullerton.edu
; //  Author Section: M/W 2:00pm-3:50pm
; //
; //Program information
; //  Program name: ftoa
; //  Programming languages: X86
; //  Date program began: October 21 2022
; //  Date of last update: October 25 2022
; //  Files in this program: _start.asm, _math.asm, cosine.asm, ftoa.asm, itoa.asm, stringtof.asm strlen.asm
; //  Status: Finished.  The program was tested extensively with no errors in WSL.
; //
; //Purpose
; //
; //This file
; //   File name: ftoa.asm
; //   Language: x86
; //   Max page width: 172 columns
; //   Compile: nasm -f elf64 -l ftoa.lis -o ftoa.o ftoa.asm 
; //   Linker: ld -o final.out _start.o strlen.o cosine.o itoa.o math.o ftoa.o stringtof.o 
; //
; //=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
; //
; //
; //===== Begin code area ===========================================================================================================
global ftoa

extern itoa

section .text

ftoa:

        test    rsi, rsi
        je      .014
        push    rbp
        mov     rdx, rsi
        mov     rbp, rsp
        push    r15
        push    r14
        push    r13
        push    r12
        push    rbx
        mov     rbx, rdi
        sub     rsp, 40
        ucomisd xmm0, xmm0
        jpo     .003
        cmp     rsi, 3
        jg      .002
.001:
        xor eax, eax
        jmp .013

.002:
        mov dword [rdi], 5136718
        mov eax, 3
        jmp .013

.003:
        cvttsd2si eax, xmm0
        mov       rsi, rbx
        movsd     qword [rbp-48H], xmm0
        movsxd    rdi, eax
        mov       r15d, eax
        call      itoa
        test      rax, rax
        jz        .001
        cvtsi2sd  xmm1, r15d
        movsd     xmm0, qword [rbp-48H]
        subsd     xmm0, xmm1
        xorps     xmm1, xmm1
        comisd    xmm1, xmm0
        jbe       .004
        xorps     xmm0, oword [rel .LC1]
.004:
        xorps     xmm1, xmm1
        comisd    xmm0, xmm1
        jbe       .013
        mov       byte [rbx+rax], 46
        lea       r13, [rbp-37H]
        inc       rax
        mov       edx, 7
        mulsd     xmm0, [rel .LC2]
        mov       rsi, r13
        mov       r12, rsp
        mov       r15, rax
        cvttsd2si r14, xmm0
        mov       rdi, r14
        call      itoa
        test      rax, rax
        je        .013
        xor       ecx, ecx
        test      r14, r14
        jle       .009
.005:
        cmp  r14, 99999
        jg   .006
        imul r14, r14, 10
        inc  rcx
        jmp  .005

.006:
        dec rax
        lea rdx, [r13+rcx]
.007:
        test rax, rax
        js   .008
        mov  sil, byte [r13+rax]
        mov  byte [rdx+rax], sil
        dec  rax
        jmp  .007

.008:
        xor   eax, eax
        test  rcx, rcx
        mov   rdi, r13
        cmovs rcx, rax
        mov   al, 48
        rep   stosb
        mov   eax, 6
.009:
        mov rdx, rax
        cmp rax, 1
        jle .010
        cmp byte [r13+rdx-1H], 48
        lea rax, [rax-1H]
        jz  .009
.010:
        mov rax, r15
.011:
        mov    ecx, eax
        lea    rsi, [rbx+rax]
        sub    ecx, r15d
        movsxd rcx, ecx
        cmp    rcx, rdx
        jge    .012
        mov    cl, byte [rbp+rcx-37H]
        mov    byte [rbx+rax], cl
        inc    rax
        jmp    .011

.012:
        mov byte [rsi], 0
        mov rsp, r12
.013:
        lea rsp, [rbp-28H]
        pop rbx
        pop r12
        pop r13
        pop r14
        pop r15
        pop rbp
        ret 

.014:

        xor eax, eax
        ret 

section .data

section .bss

section .rodata

        ALIGN 16
.LC1:

 dd 00000000H, 80000000H
 dd 00000000H, 00000000H

section .rodata

.LC2:
 dq 412E848000000000H

section .note

 db 04H, 00H, 00H, 00H, 20H, 00H, 00H, 00H
 db 05H, 00H, 00H, 00H, 47H, 4EH, 55H, 00H
 db 02H, 00H, 01H, 0C0H, 04H, 00H, 00H, 00H
 db 01H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
 db 01H, 00H, 01H, 0C0H, 04H, 00H, 00H, 00H
 db 09H, 00H, 00H, 00H, 00H, 00H, 00H, 00H
