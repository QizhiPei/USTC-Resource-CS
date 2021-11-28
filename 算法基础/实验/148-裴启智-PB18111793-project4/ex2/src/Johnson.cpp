#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>
#include <fstream>
#include <windows.h>
#define MY_MAX INT16_MAX
using namespace std;

ofstream outfile_time;
//边结点，即邻接表的表结点
class Edge_Node{
public:
    int src;
    int dest;
    int w;
    Edge_Node *next;
};
//顶点
class Vertex_Node{
public:
    int data;   //顶点信息，这里主要是编号
    int d;    //相当于v.d，即从源结点s到该结点的最短路径权重的上界
    Vertex_Node* pi;    //相当于v.π，记录当前结点的前驱结点
    Edge_Node *first_edge;
};

class Graph{
public:
        //构造函数
        Graph(int N, string in_path, string out_path): edge_num(0), vertex_num(N), inpath(in_path), outpath(out_path){
            for(int i = 0; i < MAX_VERTEX_NUM; ++i){
                vertex_list[i].data = i;
                vertex_list[i].d = MY_MAX;
                vertex_list[i].pi = NULL;
                vertex_list[i].first_edge = NULL;
            }

        }
        //插入有向边(u,v)，权重为w
        void Add_Edge(int u, int v, int w){
            //先分配空间，构造一个新的边结点
            Edge_Node* temp_edge = new Edge_Node;
            temp_edge->src = u;
            temp_edge->dest = v;
            temp_edge->next = NULL;
            temp_edge->w = w;
            //寻找合适的插入位置
            Edge_Node *u_first = vertex_list[u].first_edge;
            //若当前顶点邻接表为空
            if(u_first == NULL){
                vertex_list[u].first_edge = temp_edge;
            }else{
                while(u_first->next != NULL){
                    u_first = u_first->next;
                }
                u_first->next = temp_edge;
            }
            edge_num++;
        }

        void Create_test_G(){
            cout << "Test Graph" << endl;
            Add_Edge(1, 2, 3);
            Add_Edge(1, 3, 8);
            Add_Edge(1, 5, -4);

            Add_Edge(2, 4, 1);
            Add_Edge(2, 5, 7);

            Add_Edge(3, 2, 4);

            Add_Edge(4, 3, -5);
            Add_Edge(4, 1, 2);

            Add_Edge(5, 4, 6);
        }
        void Create_G(){
            ifstream infile;
            infile.open(inpath);
            cout << "Read G from " << inpath << endl;
            int u, v, w;
            while(infile >> u >> v >> w){
                Add_Edge(u, v, w);
            }
            infile.close();
        }
        //打印u->v的路径
        void Print_Path_u_to_v(int u, int v){

            cout << "From " << vertex_list[u].data << " to " << vertex_list[v].data << endl;
            outfile << "From " << vertex_list[u].data << " to " << vertex_list[v].data << " : (";
            Print_Path(&vertex_list[u], &vertex_list[v]);
            cout << "Weight: " << vertex_list[v].d << endl;
            cout << endl;
            outfile << " " << vertex_list[v].d;
            outfile << ")" << endl;

        }

        void Print_Path(Vertex_Node* u, Vertex_Node* v){
            if(u == v) {
                cout << v->data << ",";
                outfile << v->data << ",";
            }else if(v->pi == NULL){
                cout << "disconnected" << endl;
                outfile << "disconnected";
            }else{
                Print_Path(u, v->pi);
                cout << v->data << " ";
                outfile << v->data << ",";
            }
        }

        void Initialize_Single_Source(int s){
            //对所有顶点进行初始化
            for(int i = 0; i < vertex_num; ++i){
                vertex_list[i].d = MY_MAX;
                vertex_list[i].pi = NULL;
            }
            vertex_list[s].d = 0;
        }
        //(u, v)即为edge
        void Relax(Edge_Node *edge){
            auto u = vertex_list[edge->src];
            auto v = vertex_list[edge->dest];
            int w_u_v = edge->w;
            if(v.d > u.d + w_u_v){
                vertex_list[edge->dest].d = vertex_list[edge->src].d + w_u_v;
                vertex_list[edge->dest].pi = &vertex_list[edge->src];
            }
        }

        bool Bellman_Ford(int s){
            Initialize_Single_Source(s);
            //对图的每条边作|V| - 1次处理
            for(int i = 1; i < vertex_num; ++i){
                //遍历所有边
                for(int j = 0; j < vertex_num; ++j){
                    Edge_Node *edge = vertex_list[j].first_edge;
                    while(edge != NULL){
                        Relax(edge);
                        edge = edge->next;
                    }
                }
            }
            //检查是否有负环路
            for(int i = 0; i < vertex_num; ++i){
                Edge_Node *edge = vertex_list[i].first_edge;
                while(edge != NULL){
                    if(vertex_list[edge->dest].d > vertex_list[edge->src].d + edge->w){
                        return false;
                    }
                    edge = edge->next;
                }
            }
            cout << "Bellman-Ford finished" << endl;
            return true;
        }

        class cmp{
        public:
            bool operator() (Vertex_Node *node1, Vertex_Node *node2){
                return node1->d > node2->d;
            }
        };
        void Dijkstra(int s){
            //注意必须先初始化再入队列，否则第一次取出来的就不好说了，或者说肯定不是s
            Initialize_Single_Source(s);
            vector<Vertex_Node> S;
            //vector<Vertex_Node*> node_ptr;
            //优先队列实现最小堆
            priority_queue<int, vector<Vertex_Node*>, cmp> node_min_heap;
            for(int i = 0; i < vertex_num; ++i){
                node_min_heap.push(&(vertex_list[i]));
            }
            while(!node_min_heap.empty()){
                Vertex_Node *min_d_node = node_min_heap.top();
                node_min_heap.pop();
                S.push_back(*min_d_node);
                Edge_Node *edge = min_d_node->first_edge;
                while(edge != NULL){
                    Relax(edge);
                    edge = edge->next;
                }
            }
            
            cout << "Dijkstra result: " << endl;

            for(int i = 1; i < vertex_num; ++i){
                if(i != s){
                    Print_Path_u_to_v(s, i);
                }
            }
        }


        void Johnson(){

            LARGE_INTEGER t1, t2, tc;
            QueryPerformanceFrequency(&tc);
            QueryPerformanceCounter(&t1);

            outfile.open(outpath);
            Create_G();
            //Create_test_G();
            //扩展G为G'
            for(int i = 1; i < vertex_num; ++i){
                Add_Edge(0, i, 0);
            }

            if(Bellman_Ford(0) == false){
                cout << "the input graph contains a negative-weight cycle" << endl;
            }else{
                int *h = new int[vertex_num];
                //set h(v) to the value of sigma(s,v) computed by the Bellman-Ford algorithm
                for(int i = 0; i < vertex_num; ++i){
                    h[i] = vertex_list[i].d;
                }
                for(int i = 0; i < vertex_num; ++i){
                    Edge_Node* edge = vertex_list[i].first_edge;
                    while(edge != NULL){
                        edge->w = edge->w + h[edge->src] - h[edge->dest];
                        edge = edge->next;
                    }
                }
                int **D = new int*[vertex_num];
                for(int i = 0; i < vertex_num; ++i){
                    D[i] = new int[vertex_num];
                }
                for(int i = 1; i < vertex_num; ++i){
                    Dijkstra(i);
                    for(int j = 1; j < vertex_num; ++j){
                        D[i][j] = vertex_list[j].d + h[j] - h[i];
                    }
                }
                
                cout << "Johnson result: " << endl;
                for(int i = 1; i < vertex_num; ++i){
                    for(int j = 1; j < vertex_num; ++j){
                        cout << D[i][j] << " ";
                    }
                    cout << endl;
                }
            }
            QueryPerformanceCounter(&t2);
            double time = (double)(t2.QuadPart - t1.QuadPart) / (double)tc.QuadPart;
            cout << "spend time = " << time << endl; //输出时间（单位：ｓ）
            outfile_time << time << endl;
            outfile.close();
        }
private:
    int vertex_num;
    int edge_num;
    string inpath;
    string outpath;
    ofstream outfile;
    //本实验最多729 + 1（扩展的顶点）
    static const int MAX_VERTEX_NUM = 730;
    Vertex_Node vertex_list[MAX_VERTEX_NUM];
};


int main(){
    //注意统计数据时需要把输出部分注释掉
    outfile_time.open("../output/time.txt");

    //顶点数为要求的数加一，因为需要扩展G
    Graph G11(28, "../input/input11.txt", "../output/output11.txt");
    G11.Johnson();
    Graph G12(28, "../input/input12.txt", "../output/output12.txt");
    G12.Johnson();
    Graph G21(82, "../input/input21.txt", "../output/output21.txt");
    G21.Johnson();
    Graph G22(82, "../input/input22.txt", "../output/output22.txt");
    G22.Johnson();
    Graph G31(244, "../input/input31.txt", "../output/output31.txt");
    G31.Johnson();
    Graph G32(244, "../input/input32.txt", "../output/output32.txt");
    G32.Johnson();
    Graph G41(730, "../input/input41.txt", "../output/output41.txt");
    G41.Johnson();
    Graph G42(730, "../input/input42.txt", "../output/output42.txt");
    G42.Johnson();
    outfile_time.close();


    return 0;
}