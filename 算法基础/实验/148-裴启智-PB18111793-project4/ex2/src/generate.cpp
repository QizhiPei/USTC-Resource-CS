#include <ctime>
#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
#include <fstream>
#include <cmath>

using namespace std;

//不允许多重边，可以有环（包括自环,算作一条边，对应1度）
int generate(int N, int degree, string path){
    //auto v_degree = new int[N];
    //生成的所有边
    vector<pair<int, pair<int, int>>> edges;
    //0号节点预留给扩展后得到的G'
    for(int i = 1; i <= N; ++i){
        //对当前顶点生成对应的边数
        int edge_num = degree;
        pair<int, pair<int, int>> edge_temp_with_weight;
        //生成的所有边（不含权重）
        vector<pair<int, int>> edges_without_weight;
        pair<int, int> edge_temp1;
        int j = 0;
        while(j < edge_num){
            edge_temp1.first = i;
            edge_temp1.second = 1 + rand() % N;
            //如果之前没有这条边（不允许重边）
            if(count(edges_without_weight.begin(), edges_without_weight.end(), edge_temp1) == 0){
                //将该边加入vector
                edges_without_weight.push_back(edge_temp1);
                //随机权重[0,50]
                edge_temp_with_weight.first = rand() % 51;
                edge_temp_with_weight.second = edge_temp1;
                edges.push_back(edge_temp_with_weight);
                //增加对应顶点的度数
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
    generate(27, floor(log(27) / log(5)),"../input/input11.txt");
    generate(27, floor(log(27) / log(7)),"../input/input12.txt");
    generate(81, floor(log(81) / log(5)),"../input/input21.txt");
    generate(81, floor(log(81) / log(7)),"../input/input22.txt");
    generate(243, floor(log(243) / log(5)),"../input/input31.txt");
    generate(243, floor(log(243) / log(7)),"../input/input32.txt");
    generate(729, floor(log(729) / log(5)),"../input/input41.txt");
    generate(729, floor(log(729) / log(7)),"../input/input42.txt");
    return 0;
}