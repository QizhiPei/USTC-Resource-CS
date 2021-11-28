#include<iostream>
#include<chrono>
#include <iomanip>
#include "myhead.h"

using namespace std;
using namespace chrono;


void counting_sort(int A[], int B[], int n){
    int k = MAX + 1;
    int C[MAX + 1];

    auto start = system_clock::now();//启动时钟

    for(int i = 0; i < k; ++i){
        C[i] = 0;
    }

    for(int j = 0; j < n; ++j){
        C[A[j]] = C[A[j]] + 1;
    }

    for(int i = 1; i <= MAX; ++i){
        C[i] = C[i] + C[i-1];
    }

    for(int j = n - 1; j >= 0; j--){
        B[C[A[j]] - 1] = A[j];
        C[A[j]] = C[A[j]] - 1;
    }

    auto end = system_clock::now();//终止时钟

    auto duration = duration_cast<microseconds>(end - start);

    auto time_this =  (double)(duration.count());
    cout << time_this << endl;
    time_spend[time_i++] = time_this;
}
