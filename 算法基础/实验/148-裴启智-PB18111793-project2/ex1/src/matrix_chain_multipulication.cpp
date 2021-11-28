#include<iostream>
#include<fstream>
#include<vector>
#include<string>
#include<iomanip>
#include<windows.h>
#define MAX 9223372036854775807
#define MATRIX_SIZE 30

using namespace std;
vector<vector<int>> data_vec;
long long m[MATRIX_SIZE][MATRIX_SIZE] = {0};
int s[MATRIX_SIZE][MATRIX_SIZE] = {0};
ofstream outfile_result, outfile_time;

void matrix_chain_order(vector<int> p){
    int n = p.size() - 1;
    for (int i = 1; i <= n; ++i){
        m[i][i] = 0;
    }
    for (int l = 2; l <= n; ++l){
        for (int i = 1; i <= n - l + 1; ++i){
            int j = i + l - 1;
            m[i][j] = MAX;
            for (int k = i; k <= j - 1; ++k){
                long long q = m[i][k] + m[k + 1][j];
                long long temp = p[i - 1];
                temp *= p[k];
                temp *= p[j];
                //cout << temp << endl;//容器不能在一个式子中多次引用
                q += temp;
                if(q < m[i][j])
                {
                    m[i][j] = q;
                    s[i][j] = k;
                }
            }
        }
    }
}

void print_optimal_parens(int s[][MATRIX_SIZE], int i, int j){
    if(i == j){
        cout << "A";
        outfile_result << "A";
        return;
    }
    else{
        cout << "(";
        outfile_result << "(";
        print_optimal_parens(s, i, s[i][j]);
        print_optimal_parens(s, s[i][j] + 1, j);
        cout << ")";
        outfile_result << ")";
        return;
    }
}

int main(){
    ifstream infile;
    int matrix_num, in_temp;
    
    string base_path = "D:\\study\\algorithm_lab\\lab2\\ex1\\";
    infile.open(base_path + "input\\2_1_input.txt");
    cout << "Reading from the file 2_1_input.txt" << endl;
    
    for (int i = 0; i < 5; ++i){
        infile >> matrix_num;
        vector<int> temp;
        for (int j = 0; j <= matrix_num; ++j){
            infile >> in_temp;
            temp.push_back(in_temp);
        }
        data_vec.push_back(temp);
    }
    infile.close();

    //写入文件
    
    outfile_result.open(base_path + "output\\result.txt");
    outfile_time.open(base_path + "output\\time.txt");

    for (int i = 0; i < 5; ++i){
        LARGE_INTEGER t1, t2, tc;
        QueryPerformanceFrequency(&tc);
        QueryPerformanceCounter(&t1);

        matrix_chain_order(data_vec[i]);

        QueryPerformanceCounter(&t2);
        double time = (double)(t2.QuadPart - t1.QuadPart) / (double)tc.QuadPart;
        cout << "spend time = " << time << endl; //输出时间（单位：ｓ）
        outfile_time << fixed << setprecision(6) << time << endl;

        for (int j = 1; j < data_vec[i].size(); ++j){
            for (int k = 1; k < data_vec[i].size(); ++k){
                cout << left << setw(20) << m[j][k] << " ";
            }
            cout << endl;
        }
        outfile_result << m[1][data_vec[i].size() - 1] << endl;

        cout << endl;
        print_optimal_parens(s, 1, data_vec[i].size() - 1);
        
        cout << "\n" << endl;
        outfile_result << endl;

        

        for (int j = 0; j < MATRIX_SIZE; ++j)
        {
            for (int k = 0; k < MATRIX_SIZE; ++k)
            {
                m[j][k] = 0;
                s[j][k] = 0;
            }
        }
    }
    outfile_result.close();
    outfile_time.close();
}