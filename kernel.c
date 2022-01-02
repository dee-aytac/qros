#define WHITE_ON_BLACK 0x0f
void clear_screen() {
    char* video_memory = (char*) 0xb8000;
    int i = 0;
    for(i = 0; i <= 80 * 25 * 2 + 2; i += 2) {
        video_memory[i] = ' ';
        video_memory[i + 1] = WHITE_ON_BLACK;        
    }
}


void main() {
    clear_screen();

}
