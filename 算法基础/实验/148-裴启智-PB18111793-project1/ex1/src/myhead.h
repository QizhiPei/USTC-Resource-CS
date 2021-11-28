//
// Created by lenovo on 2020/11/7.
//

#ifndef SORT_MYHEAD_H
#define SORT_MYHEAD_H

#define MAX 32767
void generate();
void exchange(int A[], int i, int j);

void insert_sort(int A[], int n);
void counting_sort(int A[], int B[], int n);
void merge_sort_timing(int A[],  int p, int r);
void heap_sort(int A[], int n);
void quick_sort_timing(int A[], int p, int r);

extern double time_spend[6];
extern int time_i;

#endif //SORT_MYHEAD_H
