#include "generate_random_nums.h"
#include "RBTree.h"
#include <set>

ifstream infile;

vector<vector<int>> data_vec;

bool containsDuplicate(vector<int>& nums) {
    set<int> myset(nums.begin(), nums.end());
    if(myset.size() < nums.size())
        return false;
    return true;
}

int main(){

    make_generate();
    //RB_Tree<int> rb_tree1;
    infile.open(base_path + "input\\input.txt");
    int num, in_temp;

    for (int i = 0; i < 5; ++i){
        infile >> num;
        vector<int> temp;
        for (int j = 0; j < num; ++j){
            infile >> in_temp;
            temp.push_back(in_temp);
        }
        if(containsDuplicate(temp)){
            data_vec.push_back(temp);

        }
        else{
            cout << "find duplicates, need rerun" << endl;
            exit(1);
        }
    }
    infile.close();

    //保存5课红黑树的森林
    vector<RB_Tree<int>> rb_trees;
    outfile_time1.open(base_path + "output\\time1.txt");

    for(int i = 0; i < 5; ++i){
        RB_Tree<int> rb_tree1;
        LARGE_INTEGER t1, t2, tc;
        QueryPerformanceFrequency(&tc);
        QueryPerformanceCounter(&t1);
        //通过逐个结点插入建立红黑树，并统计时间
        for(auto j : data_vec[i]){
            rb_tree1.RB_Insert(j);
        }

        QueryPerformanceCounter(&t2);
        double time = (double)(t2.QuadPart - t1.QuadPart) / (double)tc.QuadPart;
        cout << "(insert) spend time = " << time << endl; //输出时间（单位：ｓ）
        outfile_time1 << time << endl;

        rb_trees.push_back(rb_tree1);
    }
    outfile_time1.close();

    //对每个树进行中序遍历，并写入文件
    cout << "中序遍历序列" << endl;
    outfile_inorder.open(base_path + "output\\inorder.txt");
    for(auto i : rb_trees){
        i.In_Order_Walk(1);
    }
    outfile_inorder.close();

    //随机删除n/4个结点，并统计时间
    vector<vector<int>> delete_data_vec;
    for(int i = 0; i < 5; ++i){
        int vec_len = data_vec[i].size();
        vector<int> vec_temp;
        for(int j = 0; j < vec_len / 4; ++j){
            //cout << data_vec[i].size() << " ";
            int temp_num = random_number_n(data_vec[i].size());
            vec_temp.push_back(data_vec[i][temp_num]);
            data_vec[i].erase(data_vec[i].begin() + temp_num);
        }
        delete_data_vec.push_back(vec_temp);
        cout << endl;
    }




    outfile_time2.open(base_path + "output\\time2.txt");
    for(int i = 0; i < 5; ++i){
        LARGE_INTEGER t1, t2, tc;
        QueryPerformanceFrequency(&tc);
        QueryPerformanceCounter(&t1);
        //对每个红黑树，随机删除其n/4个结点
        for(auto j : delete_data_vec[i]){
            rb_trees[i].RB_Delete(j);
        }

        QueryPerformanceCounter(&t2);
        double time = (double)(t2.QuadPart - t1.QuadPart) / (double)tc.QuadPart;
        cout << "(delete) spend time = " << time << endl; //输出时间（单位：ｓ）
        outfile_time2 << time << endl;

    }
    outfile_time2.close();


    //对删除结点后每个树进行中序遍历，并写入文件
    cout << "删除的结点以及删除后的中序遍历序列" << endl;

    outfile_delete_data.open(base_path + "output\\delete_data.txt");
    /*
    for(auto i : delete_data_vec){
        for(auto j : i){
            outfile_delete_data << j << " ";
        }
        outfile_delete_data << endl;
    }*/
    for(int i = 0; i < 5; ++i){
        for(auto j : delete_data_vec[i]){
            outfile_delete_data << j << " ";
            cout << j << " ";
        }
        outfile_delete_data << endl;
        cout << endl;
        rb_trees[i].In_Order_Walk(2);
    }
    /*
    for(auto i : rb_trees){

        i.In_Order_Walk(2);
    }*/
    outfile_delete_data.close();

    return 0;
}