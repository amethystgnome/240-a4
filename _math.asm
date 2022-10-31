; //****************************************************************************************************************************
; //Program name: "_math". 
; //               Copyright (C) 2022 Aubrianna Sample
; //                                                                                                                           *
; //This file is part of the software program  _math".                                                                   *
; / _math is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
; //version 3 as published by the Free Software Foundation.                                                                    *
; / _math is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
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
; //  Program name: _math
; //  Programming languages: X86
; //  Date program began: October 21 2022
; //  Date of last update: October 25 2022
; //  Files in this program: _start.asm, _math.asm, cosine.asm, ftoa.asm, itoa.asm, stringtof.asm strlen.asm
; //  Status: Finished.  The program was tested extensively with no errors in WSL.
; //
; //Purpose
; //
; //This file
; //   File name: _math.asm
; //   Language: x86
; //   Max page width: 172 columns
; //   Compile: nasm -f elf64 -l _math.lis -o _math.o _math.asm 
; //   Linker: ld -o final.out _start.o strlen.o cosine.o itoa.o _math.o ftoa.o stringtof.o 
; //
; //=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
; //
; //
; //===== Begin code area ===========================================================================================================

%ifndef _math

%use fp

; @cmul(a, b) -> rax
%macro @cmul 2
        mov  rax, %1
        mov  rdi, %2
        imul rdi
%endmacro

; @cdiv(a, b) -> (rax, rdx)
%macro @cdiv 2
        mov  rax, %1                   ; idiv uses this
        mov  rdx, 0                    ; idiv also uses this (for remainder)
        mov  rdi, %2                   ; we use this on our own
        idiv rdi                       ; rax, rdx is implicitly set;
                                       ; div/idiv is very weird
%endmacro

; @cos(rad:xmm?) -> xmm0
%macro @cos 1
        movq  rax, %1                  ; load xmm0 into rax
        push  rax                      ; copy rax onto rsp
        fld   qword [rsp]              ; load rax value in rsp into FPU
        fcos                           ; do the cos()
        fstp  qword [rsp]              ; st0 -> rsp, store st0 into stack
        movsd xmm0, [rsp]              ; load rsp value into xmm0
        add   rsp, 8                   ; unpop rax
%endmacro

; @deg2rad(deg:xmm?) -> xmm0
%macro @deg2rad 1
        movsd xmm0, %1
        mov   rax, float64(0.0174532925199432) ; 180/pi
        movq  xmm1, rax
        mulsd xmm0, xmm1
%endmacro

%endif