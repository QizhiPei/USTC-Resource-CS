#include<iostream>
#include<chrono>
#include "myhead.h"

using namespace std;
using namespace chrono;

void insert_sort(int A[], int n){
    int key;
    int i;
    auto start = system_clock::now();//启动时钟

    for(int j = 1; j < n; ++j){
        key = A[j]; //将A[j]插入到正确的位置
        i = j - 1;
        while(i >= 0 && A[i] > key){
            A[i + 1] = A[i];
            i--;
        }
        A[i + 1] = key;
    }

    auto end = system_clock::now();//终止时钟

    auto duration = duration_cast<microseconds>(end - start);

    auto time_this = double(duration.count());
    cout << time_this << endl;
    time_spend[time_i++] = time_this;
}