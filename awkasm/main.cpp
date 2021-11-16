// to be launched EXTERNALLY, before compilation

#include <iostream> 

int main(int argc, char **argv) {
    if(argc < 2) {
        std::cout << "ERROR: arguments invalid";
        return -1;
    }
}