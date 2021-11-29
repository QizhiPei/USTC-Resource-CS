#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <time.h>

#include <iostream>

#include "omp.h"

using namespace std;

void QuickSort(int *&array, int len) {
    if (len <= 1) return;
    int pivot = array[len / 2];
    int left_ptr = 0;
    int right_ptr = len - 1;
    while (left_ptr <= right_ptr) {
        while (array[left_ptr] < pivot) left_ptr += 1;
        while (array[right_ptr] > pivot) right_ptr -= 1;
        if (left_ptr <= right_ptr) {
            swap(array[left_ptr], array[right_ptr]);
            left_ptr += 1;
            right_ptr -= 1;
        }
    }
    int *sub_array[] = {array, &(array[left_ptr])};
    int sub_len[] = {right_ptr + 1, len - left_ptr};

#pragma omp task default(none) firstprivate(sub_array, sub_len)
    { QuickSort(sub_array[0], sub_len[0]); }
#pragma omp task default(none) firstprivate(sub_array, sub_len)
    { QuickSort(sub_array[1], sub_len[1]); }
    // for (int i = 0; i < 2; i++) QuickSort(sub_array[i], sub_len[i]);
}

int main(int argc, char *argv[]) {
    srand(time(NULL));
    if (argc != 3) {
        cout << "Usage: " << argv[0] << " thread-num array-len\n";
        exit(-1);
    }
    int t = atoi(argv[1]);
    int n = atoi(argv[2]);
    int *array = new int[n];
    omp_set_num_threads(t);

    unsigned int seed = 1024;
#pragma omp parallel for
    for (int i = 0; i < n; i++) array[i] = rand_r(&seed);

    struct timeval start, stop;
    gettimeofday(&start, NULL);

#pragma omp parallel default(none) shared(array, n)
    {
#pragma omp single nowait
        { QuickSort(array, n); }
    }
    gettimeofday(&stop, NULL);

    double elapse = (stop.tv_sec - start.tv_sec) * 1000 +
                    (stop.tv_usec - start.tv_usec) / 1000;
    cout << elapse << " " << n << endl;

    for (int i = 0; i < n - 1; i++) {
        if (array[i] > array[i + 1]) {
            cerr << "quick sort fails! \n";
            break;
        }
    }
    return 0;
}