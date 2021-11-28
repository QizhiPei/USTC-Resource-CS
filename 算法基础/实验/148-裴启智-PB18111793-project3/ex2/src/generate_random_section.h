#include "my_header.h"

using namespace std;

bool containsDuplicate(vector<int>& nums) {
    set<int> myset(nums.begin(), nums.end());
    if(myset.size() < nums.size()) return true;
    return false;
}

void generate_section(section& sec){
    if(sec.low < 25){
        //产生【low+1,25】的整数
        sec.high = (rand() % (25 - sec.low)) + sec.low + 1;
    }else{
        //产生【low+1,50】的整数
        sec.high = (rand() % (50 - sec.low)) + sec.low + 1;
    }
}

void make_generate()
{
    srand(unsigned(time(0)));
    vector<int> low_30;
    int temp;
    while(low_30.size() < 30){
        temp = rand() % 50;//先生成0-49的随机数
        //注意左端点不能取25和50，这样的话区间长度退化成一个点
        if(temp >= 25 && temp < 30){
            continue;
        }
        low_30.push_back(temp);
        section temp_section;
        temp_section.low = temp;
        temp_section.high = 0;
        temp_section.max = 0;
        section_data_vec.push_back(temp_section);
        if(containsDuplicate(low_30)){
            low_30.pop_back();
            section_data_vec.pop_back();
        }
    }

    for(auto &i : section_data_vec){
        generate_section(i);
    }
    outfile_random.open(base_path + "input\\input.txt");
    for(auto i : section_data_vec){
        //cout << "low " << i.low << " high " << i.high << endl;
        outfile_random << i.low << " " << i.high << endl;
    }
    outfile_random.close();

}

vector<section> generate_3_section(){
    srand(unsigned(time(0)));
    vector<section> ret_vec;
    section temp;
    temp.low = (rand() % 50);
    temp.high = (rand() % (50 - temp.low)) + temp.low + 1;
    ret_vec.push_back(temp);
    temp.low = (rand() % 50);
    temp.high = (rand() % (50 - temp.low)) + temp.low + 1;
    ret_vec.push_back(temp);
    //对于（25,30）中的闭区间，只有6种可能
    //0-[26,17]  1-[26,28] 2-[26,29] 3-[27,28] 4-[27,29] 5-[28,29]
    temp.low = (rand() % 3) + 26;
    temp.high = (rand() % (29 - temp.low)) + temp.low + 1;
    ret_vec.push_back(temp);
    return ret_vec;
}