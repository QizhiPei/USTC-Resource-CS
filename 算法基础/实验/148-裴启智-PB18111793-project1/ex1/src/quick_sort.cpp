#include<iostream>
#include<chrono>
#include "myhead.h"

using namespace std;
using namespace chrono;


int partition(int A[], int p, int r){
    int x = A[r];
    int i = p - 1;
    for(int j = p; j <= r - 1;++j){
        if(A[j] <= x){
            i++;
            exchange(A, i, j);
        }
    }
    exchange(A, i+1, r);
    return i+1;
}

void quick_sort(int A[], int p, int r){
    if(p < r){
        int q = partition(A, p, r);
        quick_sort(A, p, q - 1);
        quick_sort(A, q + 1, r);
    }
}

void quick_sort_timing(int A[], int p, int r){
    auto start = system_clock::now();//启动时钟

    quick_sort(A, p, r);

    auto end = system_clock::now();//终止时钟

    auto duration = duration_cast<microseconds>(end - start);

    auto time_this = double(duration.count());
    cout << time_this << endl;
    time_spend[time_i++] = time_this;
}


