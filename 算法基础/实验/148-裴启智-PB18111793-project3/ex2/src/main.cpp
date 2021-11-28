#include "generate_random_section.h"
#include "RBTree.h"



int main() {
    make_generate();
    RB_Tree<section> section_tree;

    for(auto i : section_data_vec){
        section_tree.RB_Insert(i);
    }

    /*
    vector<section> ceshi;
    section temp;
    temp.low = 16;
    temp.high = 21;
    ceshi.push_back(temp);
    temp.low = 8;
    temp.high = 9;
    ceshi.push_back(temp);
    temp.low = 25;
    temp.high = 30;
    ceshi.push_back(temp);
    temp.low = 5;
    temp.high = 8;
    ceshi.push_back(temp);
    temp.low = 15;
    temp.high = 23;
    ceshi.push_back(temp);
    temp.low = 17;
    temp.high = 19;
    ceshi.push_back(temp);
    temp.low = 26;
    temp.high = 26;
    ceshi.push_back(temp);
    temp.low = 0;
    temp.high = 3;
    ceshi.push_back(temp);
    temp.low = 6;
    temp.high = 10;
    ceshi.push_back(temp);
    temp.low = 19;
    temp.high = 20;
    ceshi.push_back(temp);


    for(auto i : ceshi){
        section_tree.RB_Insert(i);
    }*/

    outfile_inorder.open(base_path + "output\\inorder.txt");
    section_tree.In_Order_Walk(1);
    outfile_inorder.close();

    cout << endl;


    vector<int> rand_num;
    for(int i = 0; i < 3; ++i){
        rand_num.push_back(rand() % 30);
    }

    outfile_delete_data.open(base_path + "output\\delete_data.txt");
    outfile_delete_data << "删除的数据" << endl;
    cout << "删除的数据" << endl;
    for (auto i : rand_num)
    {
        outfile_delete_data << section_data_vec[i].low << " " << section_data_vec[i].high << endl;
        cout << section_data_vec[i].low << " " << section_data_vec[i].high << endl;
        section_tree.RB_Delete(section_data_vec[i]);
    }
    outfile_delete_data << "删除后的中序遍历序列" << endl;
    cout << "删除后的中序遍历序列" << endl;
    //temp.low = 16;
    //section_tree.RB_Delete(temp);
    section_tree.In_Order_Walk(2);
    outfile_delete_data.close();

    /*
    cout << section_tree.root->key.low << ' ';
    if(section_tree.root->color == RB_Color::RED){
        cout << "RED" <<endl;
    }else{
        cout << "BLACK" << endl;
    }*/
    /*
    section search_temp;
    search_temp.low = 11;
    search_temp.high = 14;
    auto result = section_tree.RB_Interval_Search(search_temp);

    if(result != section_tree.NIL){
        cout << result->key.low << " " << result->key.high << endl;
    }else{
        cout << "NULL" << endl;
    }*/
    outfile_search.open(base_path + "output\\search.txt");
    auto search_vec = generate_3_section();
    for(auto i : search_vec){
        cout << "search section: " << i.low << " " << i.high << endl;
        outfile_search << "search section: " << i.low << " " << i.high << endl;
        auto result = section_tree.RB_Interval_Search(i);
        if(result != section_tree.NIL){
            cout << "find result: " << result->key.low << " " << result->key.high << endl;
            outfile_search << "find result: " << result->key.low << " " << result->key.high << endl;
        }else{
            cout << "find NULL" << endl;
            outfile_search << "find NULL" << endl;
        }
    }

    return 0;
}
