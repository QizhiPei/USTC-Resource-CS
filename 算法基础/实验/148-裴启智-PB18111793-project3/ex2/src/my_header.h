#include<string>
#include<fstream>
#include<iostream>
#include<cstdlib>
#include<ctime>
#include<windows.h>
#include<stack>
#include<vector>
#include <set>
using namespace std;
string base_path = "D:\\algorithm_lab\\exp\\ex2\\";
ofstream outfile_random;
ofstream outfile_inorder;
ofstream outfile_delete_data;
ofstream outfile_search;

class section{
public:
    int low;
    int high;
    int max = 0;
};

vector<section> section_data_vec;