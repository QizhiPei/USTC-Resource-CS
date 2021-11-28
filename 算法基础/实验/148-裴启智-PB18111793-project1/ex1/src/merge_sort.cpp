#include<iostream>
#include<chrono>
#include "myhead.h"

using namespace std;
using namespace chrono;


void merge(int A[], int p, int q, int r){
    int n1 = q - p + 1;
    int n2 = r - q;
    int n1_plus_1 = n1 + 1;
    int n2_plus_1 = n2 + 1;

    int L[n1_plus_1], R[n2_plus_1];

    for(int i = 0; i < n1; ++i){
        L[i] = A[p + i];
    }

    for(int j = 0; j < n2; ++j){
        R[j] = A[q + j + 1];
    }

    L[n1] = 32770;
    R[n2] = 32770;//监视哨

    int i = 0, j = 0;
    for(int k = p; k <= r; ++k){
        if(L[i] <= R[j]){
            A[k] = L[i++];
        }
        else{
            A[k] = R[j++];
        }
    }
}

void merge_sort(int A[],  int p, int r){
    if(p < r){
        int q =  (p + r) / 2;
        merge_sort(A, p, q);
        merge_sort(A, q + 1, r);
        merge(A, p, q, r);
    }
}

void merge_sort_timing(int A[],  int p, int r){
    auto start = system_clock::now();//启动时钟

    merge_sort(A, p, r);

    auto end = system_clock::now();//终止时钟

    auto duration = duration_cast<microseconds>(end - start);

    auto time_this = double(duration.count());
    cout << time_this << endl;
    time_spend[time_i++] = time_this;
}