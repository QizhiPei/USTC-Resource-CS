#include <iostream>
#include<fstream>
#include<chrono>
#include<string>
#include "myhead.h"

using namespace std;
using namespace chrono;

#define num_3 8
#define num_6 64
#define num_9 512
#define num_12 4096
#define num_15 32768
#define num_18 262144


double time_spend[6] = {0};
int time_i = 0;

int data3 [num_3];
int data6 [num_6];
int data9 [num_9];
int data12 [num_12];
int data15 [num_15];
int data18 [num_18];

int data3_sort [num_3];
int data6_sort [num_6];
int data9_sort [num_9];
int data12_sort [num_12];
int data15_sort [num_15];
int data18_sort [num_18];


//将整形数组B整体赋值给整形数组A
void data_copy(){
    memcpy(data3_sort, data3, sizeof(int) * num_3);
    memcpy(data6_sort, data6, sizeof(int) * num_6);
    memcpy(data9_sort, data9, sizeof(int) * num_9);
    memcpy(data12_sort, data12, sizeof(int) * num_12);
    memcpy(data15_sort, data15, sizeof(int) * num_15);
    memcpy(data18_sort, data18, sizeof(int) * num_18);
    cout << "data_copy finished" << endl;
}
//将排序好的数据和时间信息输出到相应文件中
void data_out(string which_sort){
    ofstream outfile_time;
    ofstream outfile[6];
    string path3 = R"(D:\C_program\Algorithms\148-pqz-PB18111793-project1\ex1\output\)" + which_sort + R"(\result_3.txt)";
    string path6 = R"(D:\C_program\Algorithms\148-pqz-PB18111793-project1\ex1\output\)" + which_sort + R"(\result_6.txt)";
    string path9 = R"(D:\C_program\Algorithms\148-pqz-PB18111793-project1\ex1\output\)" + which_sort + R"(\result_9.txt)";
    string path12 = R"(D:\C_program\Algorithms\148-pqz-PB18111793-project1\ex1\output\)" + which_sort + R"(\result_12.txt)";
    string path15 = R"(D:\C_program\Algorithms\148-pqz-PB18111793-project1\ex1\output\)" + which_sort + R"(\result_15.txt)";
    string path18 = R"(D:\C_program\Algorithms\148-pqz-PB18111793-project1\ex1\output\)" + which_sort + R"(\result_18.txt)";
    string path_time = R"(D:\C_program\Algorithms\148-pqz-PB18111793-project1\ex1\output\)"+ which_sort +R"(\time.txt)";
    outfile[0].open(path3);
    outfile[1].open(path6);
    outfile[2].open(path9);
    outfile[3].open(path12);
    outfile[4].open(path15);
    outfile[5].open(path18);
    outfile_time.open(path_time);

    if(!outfile_time){
        cout << "Unable to open file" << endl;
        exit(1); // terminate with error
    }
    for(auto & i : outfile){
        if(!i){
            cout << "Unable to open file" << endl;
            exit(1); // terminate with error
        }
    }

    for(int i : data3_sort){
        outfile[0] << i << endl;
    }
    for(int i : data6_sort){
        outfile[1] << i << endl;
    }
    for(int i : data9_sort){
        outfile[2] << i << endl;
    }
    for(int i : data12_sort){
        outfile[3] << i << endl;
    }
    for(int i : data15_sort){
        outfile[4] << i << endl;
    }
    for(int i : data18_sort){
        outfile[5] << i << endl;
    }

    outfile_time << "单位:微秒" << endl;
    for(double i : time_spend){
        outfile_time << i << endl;
    }
    outfile_time.close();

    for(auto & i : outfile){
        i.close();
    }

    cout << "data out finished" << endl;
}

int main() {
    //生成随机数
    generate();
    cout << "random numbers generate finished" << endl;

    //将所有数据一次性读入data18中,后续再进行数组的复制
    ifstream infile;
    infile.open(R"(D:\C_program\Algorithms\148-pqz-PB18111793-project1\ex1\input\input.txt)");
    if(!infile){
        cout << "Unable to open file" << endl;
        exit(1); // terminate with error
    }

    for(int & i : data18){
        infile >> i;
    }
    infile.close();
    cout << "input finished" << endl;

    //初始化其他数组
    for(int i = 0; i < num_3; ++i){
        data3[i] = data18[i];
    }
    for(int i = 0; i < num_6; ++i){
        data6[i] = data18[i];
    }
    for(int i = 0; i < num_9; ++i){
        data9[i] = data18[i];
    }
    for(int i = 0; i < num_12; ++i){
        data12[i] = data18[i];
    }
    for(int i = 0; i < num_15; ++i){
        data15[i] = data18[i];
    }

    cout << "init finished" << endl;

    //insert_sort
    data_copy();

    insert_sort(data3_sort, num_3);
    insert_sort(data6_sort, num_6);
    insert_sort(data9_sort, num_9);
    insert_sort(data12_sort, num_12);
    insert_sort(data15_sort, num_15);
    insert_sort(data18_sort, num_18);

    cout << "insert sort finished" << endl;
    data_out("insert_sort");


    //counting_sort
    data_copy();
    time_i = 0;
    counting_sort(data3, data3_sort, num_3);
    counting_sort(data6, data6_sort, num_6);
    counting_sort(data9, data9_sort, num_9);
    counting_sort(data12, data12_sort, num_12);
    counting_sort(data15, data15_sort, num_15);
    counting_sort(data18, data18_sort, num_18);

    cout << "counting sort finished" << endl;
    data_out("counting_sort");


    //merge_sort
    data_copy();
    time_i= 0;
    merge_sort_timing(data3_sort, 0, num_3 - 1);
    merge_sort_timing(data6_sort, 0, num_6 - 1);
    merge_sort_timing(data9_sort, 0, num_9 - 1);
    merge_sort_timing(data12_sort, 0, num_12 - 1);
    merge_sort_timing(data15_sort, 0, num_15 - 1);
    merge_sort_timing(data18_sort, 0, num_18 - 1);

    cout << "merge sort finished" << endl;
    data_out("merge_sort");


    //heap_sort
    data_copy();
    time_i= 0;
    heap_sort(data3_sort, num_3);
    heap_sort(data6_sort, num_6);
    heap_sort(data9_sort, num_9);
    heap_sort(data12_sort, num_12);
    heap_sort(data15_sort, num_15);
    heap_sort(data18_sort, num_18);

    cout << "heap sort finished" << endl;
    data_out("heap_sort");


    //quick_sort
    data_copy();
    time_i= 0;
    quick_sort_timing(data3_sort, 0, num_3 - 1);
    quick_sort_timing(data6_sort, 0, num_6 - 1);
    quick_sort_timing(data9_sort, 0, num_9 - 1);
    quick_sort_timing(data12_sort, 0, num_12 - 1);
    quick_sort_timing(data15_sort, 0, num_15 - 1);
    quick_sort_timing(data18_sort, 0, num_18 - 1);

    cout << "quick sort finished" << endl;
    data_out("quick_sort");

    return 0;

}
