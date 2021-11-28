#include<iostream>
#include<chrono>
#include "myhead.h"

using namespace std;
using namespace chrono;

int heap_size = 0;

void exchange(int A[], int i, int j){
    int temp;
    temp = A[i];
    A[i] = A[j];
    A[j] = temp;
}

//数组下标从0开始,故左右孩子的结点计算进行响应的变化
int left(int i){
    return 2 * i + 1;
}

int right(int i){
    return 2 * i + 2;
}

//前提:n根结点为left[i]和right[i]的二叉树都是最大堆
//维护最大堆的性质
void max_heapify(int A[], int i){
    int l = left(i);
    int r = right(i);
    int largest = 0;
    if(l < heap_size && A[l] > A[i]){//叶结点的l和r会超过heap_size
        largest = l;
    }else{
        largest = i;
    }
    if(r < heap_size && A[r] > A[largest]){
        largest = r;
    }
    if (largest != i){
        exchange(A, i, largest);
        max_heapify(A, largest);
    }


}

void build_max_heap(int A[], int n){
    heap_size = n;
    for(int i = n / 2 - 1; i >= 0; --i){
        max_heapify(A, i);
    }
}

void heap_sort(int A[], int n){
    auto start = system_clock::now();//启动时钟

    build_max_heap(A, n);//建立最大堆
    for(int i = n - 1; i >= 1; --i){
        exchange(A, 0, i);
        heap_size--;
        max_heapify(A, 0);
    }

    auto end = system_clock::now();//终止时钟

    auto duration = duration_cast<microseconds>(end - start);

    auto time_this = double(duration.count());
    cout << time_this << endl;
    time_spend[time_i++] = time_this;
}

