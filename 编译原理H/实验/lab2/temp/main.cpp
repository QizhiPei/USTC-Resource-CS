#include <iostream>
#include <vector>
#include <string>
#include <cstdlib>
#include <cstring>

using namespace std;

struct pairs{
    char name[6];
    char content[4];
};

pairs EQ = {"relop", "="};
pairs NE = {"relop", "!="};
pairs LE = {"relop", "<="};
pairs LT = {"relop", "<"};
pairs GE = {"relop", ">="};
pairs GT = {"relop", ">"};

int main() {

    int i, length;
    int flag = 0;
    vector<pairs> tuples;
    char s1[1000];
    memset(s1, '\0', 1000);
    //memset(s2, '\0', 1000);

    for(i = 0; i < 1000; ++i){
        s1[i] = getchar();
        if(s1[i] == '\n' || s1[i] == '\r') break;
    }

    s1[i] = '\0';


    length = strlen(s1);

    for (int j = 0; j < length; ++j) {
        if(s1[j] == '='){
            pairs temp;
            strcpy(temp.name, "other");
            sprintf(temp.content, "%d" , j - flag);
            //itoa(j - flag, temp.content, 10);
            if((j - flag) > 0)
                tuples.push_back(temp);
            tuples.push_back(EQ);
            flag = j + 1;
        }
        else if (s1[j] == '<' && s1[j+1] == '='){
            pairs temp;
            strcpy(temp.name, "other");
            sprintf(temp.content, "%d" , j - flag);
            //itoa(j - flag, temp.content, 10);
            if((j - flag) > 0)
                tuples.push_back(temp);
            tuples.push_back(LE);
            flag = j + 2;
            j++;
        }
        else if (s1[j] == '>' && s1[j+1] == '='){
            pairs temp;
            strcpy(temp.name, "other");
            sprintf(temp.content, "%d" , j - flag);
            //itoa(j - flag, temp.content, 10);
            if((j - flag) > 0)
                tuples.push_back(temp);
            tuples.push_back(GE);
            flag = j + 2;
            j++;
        }
        else if (s1[j] == '<' && s1[j+1] == '>'){
            pairs temp;
            strcpy(temp.name, "other");
            sprintf(temp.content, "%d" , j - flag);
            //itoa(j - flag, temp.content, 10);
            if((j - flag) > 0)
                tuples.push_back(temp);
            tuples.push_back(NE);
            flag = j + 2;
            j++;
        }
        else if(s1[j] == '>'){
            pairs temp;
            strcpy(temp.name, "other");
            sprintf(temp.content, "%d" , j - flag);
            //itoa(j - flag, temp.content, 10);
            if((j - flag) > 0)
                tuples.push_back(temp);
            tuples.push_back(GT);
            flag = j + 1;
        }

        else if(s1[j] == '<'){
            pairs temp;
            strcpy(temp.name, "other");
            sprintf(temp.content, "%d" , j - flag);
            //itoa(j - flag, temp.content, 10);
            if((j - flag) > 0)
                tuples.push_back(temp);
            tuples.push_back(LT);
            flag = j + 1;
        }

    }
    
    pairs temp;
    strcpy(temp.name, "other");
    sprintf(temp.content, "%d" , length - flag);
    //itoa(length - flag, temp.content, 10);
    if((length - flag) > 0)
        tuples.push_back(temp);

    for(i = 0; i < tuples.size(); ++i){
        cout<<'('<<tuples[i].name<<','<<tuples[i].content<<')';
    }

    return 0;
}
