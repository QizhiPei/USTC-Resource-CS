#include<iostream>
#include<cstdlib>
#include<fstream>
#include <ctime>
#include "myhead.h"
using namespace std;

void generate(){

    ofstream outfile;
    outfile.open(R"(D:\C_program\Algorithms\148-pqz-PB18111793-project1\ex1\input\input.txt)");
    if(!outfile){
        cout << "Unable to open file" << endl;
        exit(1); // terminate with error
    }
    long long n = 262144;
    srand((unsigned)time(NULL));//给srand()提供一个种子
    for (long long i = 0; i < n; ++i){
        outfile << rand() << endl;
    }

}