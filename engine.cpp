#include <iostream>
#include <string>

int main(int argc, char* argv[]) {
    if (argc > 1) {
        std::string prompt = argv[1];
        // C++ logic to enhance the prompt
        std::string enhanced = prompt + ", highly detailed, 8k resolution, cinematic lighting";
        std::cout << enhanced;
    } else {
        std::cout << "No prompt provided";
    }
    return 0;
}
