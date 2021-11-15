nasm -fbin bootloader/main.asm -o boot.bin 

qemu-system-i386 -hda boot.bin