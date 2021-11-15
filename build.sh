nasm -fbin bootloader/main.asm -o boot.bin 
source .bashrc

qemu-system-i386 -hda boot.bin