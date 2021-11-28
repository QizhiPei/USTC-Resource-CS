#include <ctime>
#include <iostream>
#include <vector>
#include <utility>
#include <algorithm>
#include <string>
#include <fstream>

using namespace std;

//不允许多重边，可以有环（包括自环,算作一条边，对应1度）
int generate(int N, string path){
    auto v_degree = new int[N];
    //生成的所有边
    vector<pair<int, pair<int, int>>> edges;
    for(int i = 0; i < N; ++i){
        v_degree[i] = 0;
    }
    for(int i = 0; i < N; ++i){
        //对当前顶点生成对应的边数
        int edge_num;
        if(v_degree[i] < N / 2){
            edge_num = 1 + rand() % (N / 2 - v_degree[i]);
        }else{
            edge_num = 0;
        }
        pair<int, pair<int, int>> edge_temp_with_weight;
        //生成的所有边（不含权重）
        vector<pair<int, int>> edges_without_weight;
        pair<int, int> edge_temp1;
        pair<int, int> edge_temp2;
        int j = 0;
        while(j < edge_num){
            edge_temp1.first = i;
            edge_temp1.second = rand() % N;
            edge_temp2.first = edge_temp1.second;
            edge_temp2.second = edge_temp1.first;
            //如果之前没有这条边（不允许重边）且目标顶点度数小于N/2
            if(count(edges_without_weight.begin(), edges_without_weight.end(), edge_temp1) == 0 &&
                v_degree[edge_temp1.second] < N / 2){
                //将双向边加入vector
                edges_without_weight.push_back(edge_temp1);
                edges_without_weight.push_back(edge_temp2);
                //增加对应顶点的度数
                v_degree[i]++;
                v_degree[edge_temp1.second]++;
                //随机权重[1,20]
                edge_temp_with_weight.first = 1 + rand() % 20;
                edge_temp_with_weight.second = edge_temp1;
                edges.push_back(edge_temp_with_weight);
                j++;
            }else{
                continue;
            }
        }
    }
    ofstream outfile;
    outfile.open(path);
    for(auto i : edges){
        //cout <<  i.second.first << " "<< i.second.second << " " << i.first << endl;
        outfile << i.second.first << " "<< i.second.second << " " << i.first << endl;
    }
    outfile.close();
}

int main(){

    srand(unsigned(time(0)));
    generate(8, "../input/input1.txt");
    generate(64, "../input/input2.txt");
    generate(128, "../input/input3.txt");
    generate(512, "../input/input4.txt");
    return 0;
}