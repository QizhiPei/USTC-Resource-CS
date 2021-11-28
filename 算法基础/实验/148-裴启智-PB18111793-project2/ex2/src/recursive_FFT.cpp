#define _USE_MATH_DEFINES
#include<iostream>
#include<fstream>
#include<iomanip>
#include<windows.h>
#include<complex>
#include<vector>
#include<cmath>
using namespace std;



//由输入的数据可知，传入参数的一定是整型向量，返回值可能是复数向量
vector<complex<double>> recursive_fft(vector<complex<double>> a){
    int n = a.size();
    if(n == 1){
        return a;
    }
    complex<double> w_n = complex<double>(cos(2 * M_PI / n), sin(2 * M_PI / n));
    complex<double> w = complex<double>(1, 0);
    vector<complex<double>> a_0, a_1;
    for (int i = 0; i < n; i += 2){
        a_0.push_back(a[i]);
        a_1.push_back(a[i + 1]);
    }
    auto y_0 = recursive_fft(a_0);
    auto y_1 = recursive_fft(a_1);
    vector<complex<double>> y;
    for (int k = 0; k < n; ++k){
        y.push_back(complex<double>(0, 0));
    }
    for (int k = 0; k <= n / 2 - 1; ++k){
        y[k] = y_0[k] + w * y_1[k];
        y[k + n / 2] = y_0[k] - w * y_1[k];
        w *= w_n;
    }
    return y;
}

int main(){
    ifstream infile;
    int data_num, in_temp;
    complex<double> complex_double_temp;

    

    vector<vector<complex<double>>> data_vec;
    string base_path = "D:\\study\\algorithm_lab\\lab2\\ex2\\";
    infile.open(base_path + "input\\2_2_input.txt");
    cout << "Reading from the file 2_2_input.txt" << endl;

    for (int i = 0; i < 6; ++i)
    {
        infile >> data_num;
        vector<complex<double>> temp;

        for (int j = 0; j < data_num; ++j)
        {
            infile >> in_temp;
            complex_double_temp = complex<double> (in_temp, 0);
            temp.push_back(complex_double_temp);
        }
        data_vec.push_back(temp);
    }
    infile.close();

    ofstream outfile_result, outfile_time;
    outfile_result.open(base_path + "output\\result.txt");
    outfile_time.open(base_path + "output\\time.txt");

    for (int i = 0; i < 6; ++i){
        LARGE_INTEGER t1, t2, tc;
        QueryPerformanceFrequency(&tc);
        QueryPerformanceCounter(&t1);

        vector<complex<double>> result;
        result = recursive_fft(data_vec[i]);

        QueryPerformanceCounter(&t2);
        double time = (double)(t2.QuadPart - t1.QuadPart) / (double)tc.QuadPart;
        cout << "spend time = " << fixed << setprecision(6) << time << endl; //输出时间（单位：ｓ）
        outfile_time << fixed << setprecision(6) << time << endl;

        for (auto i : result)
        {
            cout << left << setw(9) << fixed << setprecision(6) << i.real() << " ";
            outfile_result << left << setw(9) << fixed << setprecision(6) << i.real() << " ";
        }
        cout << endl;
        outfile_result << endl;
    }

}