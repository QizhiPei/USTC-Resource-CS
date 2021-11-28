#include "my_header.h"

using namespace std;



void generate(int n){
    outfile_random << n << endl;
    for (int i = 0; i < n; i++)
        outfile_random << rand() << ' ';
    outfile_random << endl;
}

void make_generate()
{
    outfile_random.open(base_path + "input\\input.txt");
    srand(unsigned(time(0)));
    generate(20);
    generate(40);
    generate(60);
    generate(80);
    generate(100);
    outfile_random.close();
}

int random_number_n(int n){
    srand(unsigned(time(0)));
    return (rand() % n);
}