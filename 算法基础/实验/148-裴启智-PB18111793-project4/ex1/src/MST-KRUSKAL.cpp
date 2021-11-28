#include <iostream>
#include <algorithm>
#include <vector>
#include <windows.h>
#include <fstream>

using namespace std;

ofstream outfile_time;
//分离集合数据结构
class Disjoint_Set{
public:
    int *p;
    int *rank;
    int n;
    //构造函数，对每个结点x进行Make-Set操作
    Disjoint_Set(int n){
        this->n = n;
        p = new int[n];
        rank = new int[n];
        for(int i = 0; i < n; ++i){
            p[i] = i;
            rank[i] = 0;
        }
    }
    int Find_Set(int x){
        if(x != p[x]){
            p[x] = Find_Set(p[x]);
        }
        return p[x];
    }

    //将课本上的Union和Link放在一起
    void Union(int x, int y){
        x = Find_Set(x);
        y = Find_Set(y);
        if(rank[x] > rank[y]){
            p[y] = x;
        }else{
            p[x] = y;
            if(rank[x] == rank[y]){
                rank[y]++;
            }
        }

    }
};

ofstream outfile;

//无向图
class Graph{
public:
    //用边权重和其连接的两个顶点序号来描述一条边
    vector<pair<int, pair<int, int>>> Edge;
    //添加边
    void Add_Edge(int u, int v, int w){
        Edge.push_back({w, {u, v}});
    }

    int V_num;
    //int E_num;
    //构造图
    Graph(int V_num){
        this->V_num = V_num;
        //this->E_num = E_num;
    }

    vector<pair<int, pair<int, int>>> MST_Kruskal(){
        vector<pair<int, pair<int, int>>> A;
        int min_sum_weight = 0;
        Disjoint_Set my_Disjoint_set(V_num);
        sort(Edge.begin(), Edge.end());
        
        for(auto edge : Edge){
            int u = edge.second.first;
            int v = edge.second.second;
            int u_set_rep = my_Disjoint_set.Find_Set(u);
            int v_set_rep = my_Disjoint_set.Find_Set(v);
            if(u_set_rep != v_set_rep){
                A.push_back({edge.first ,{u, v}});
                min_sum_weight += edge.first;
                my_Disjoint_set.Union(u_set_rep, v_set_rep);
            }
        }
        cout << "min_sum_weight: " << min_sum_weight << endl;
        outfile << "min_sum_weight: " << min_sum_weight << endl;
        return A;
    }
    
};

void result(int N, string inpath, string outpath){
    ifstream infile;

    infile.open(inpath);
    outfile.open(outpath);
    Graph G(N);
    int u, v, w;
    while(infile >> u >> v >> w){
        G.Add_Edge(u, v, w);
    }

    LARGE_INTEGER t1, t2, tc;
    QueryPerformanceFrequency(&tc);
    QueryPerformanceCounter(&t1);

    auto res = G.MST_Kruskal();

    QueryPerformanceCounter(&t2);
    double time = (double)(t2.QuadPart - t1.QuadPart) / (double)tc.QuadPart;
    cout << "spend time = " << time << endl; //输出时间（单位：ｓ）
    outfile_time << time << endl;

    for(auto i : res) {
        cout << i.second.first << " " << i.second.second << " " << i.first << endl;
        outfile << i.second.first << " " << i.second.second << " " << i.first << endl;
    }
    infile.close();
    outfile.close();
};

int main(){

    outfile_time.open("../output/time.txt");
    result(8, "../input/input1.txt", "../output/result1.txt");
    result(64, "../input/input2.txt", "../output/result2.txt");
    result(128, "../input/input3.txt", "../output/result3.txt");
    result(512, "../input/input4.txt", "../output/result4.txt");

}


