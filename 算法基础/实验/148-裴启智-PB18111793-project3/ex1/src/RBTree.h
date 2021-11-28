using namespace std;

enum RB_Color{
    RED, BLACK
};


template<class T>
class RB_Node{
public:
    RB_Color color;
    T key;
    RB_Node<T>* parent;
    RB_Node<T>* left;
    RB_Node<T>* right;
    RB_Node(): key(T()), parent(NULL), left(NULL), right(NULL), color(RB_Color::BLACK){}
};

template<class T>
class RB_Tree{
public:
    RB_Tree();
    //~RB_Tree();

    RB_Node<T>* root;
    static RB_Node<T>* NIL;
    //RB_Node<T>* Get_Parent(RB_Node<T>* node);
    //RB_Node<T>* Get_Left(RB_Node<T>* node);
    //RB_Node<T>* Get_Right(RB_Node<T>* node);

    //中序遍历
    void In_Order_Walk(int num);
    //旋转
    void Left_Rotate(RB_Node<T>* x);
    void Right_Rotate(RB_Node<T> *x);
    //查找
    //RB_Node<T>* RB_Search_node(T& k);
    //插入
    void RB_Insert(const T& k);
    void RB_Insert_Fixup(RB_Node<T>* z);
    //删除
    void RB_Delete(const T& k);
    void RB_Delete_Fixup(RB_Node<T>* x);

    void RB_Transplant(RB_Node<T>* u, RB_Node<T>* v);
    RB_Node<T>* get_min(RB_Node<T>* root);

    RB_Node<T>* RB_Search_Node(const T& k);


};

template <class T>
RB_Node<T>* RB_Tree<T>::NIL = new RB_Node<T>;

template <class T>
RB_Tree<T>::RB_Tree(){
    root = NULL;
}


template <class T>
void RB_Tree<T>::Left_Rotate(RB_Node<T> *x){
    auto y = x->right;
    x->right = y->left; //将y的左子树连接到到x的右子树
    if(y->left != NIL){
        y->left->parent = x;
    }
    y->parent = x->parent;  //连接y和x的父结点
    if(x->parent == NIL){
        root = y;
    }else if(x == x->parent->left){
        x->parent->left = y;
    }else{
        x->parent->right = y;
    }
    y->left = x;    //将x作为y的左孩子
    x->parent = y;

}

template <class T>
void RB_Tree<T>::Right_Rotate(RB_Node<T> *x){
    auto y = x->left;
    x->left = y->right; //将y的左子树连接到到x的右子树
    if(y->right != NIL){
        y->right->parent = x;
    }
    y->parent = x->parent;  //连接y和x的父结点
    if(x->parent == NIL){
        root = y;
    }else if(x == x->parent->right){
        x->parent->right = y;
    }else{
        x->parent->left = y;
    }
    y->right = x;    //将x作为y的左孩子
    x->parent = y;
}

template<class T>
void RB_Tree<T>::RB_Insert(const T& k){
    auto* z = new RB_Node<T>;//用new开辟空间
    z->key = k;
    //扩张
    z->left = NIL;
    z->right = NIL;
    z->color = RB_Color::RED;
    z->parent = NIL;
    auto y = NIL;
    auto x = root;
    if(root == NULL){
        root = z;
        //只有一个根结点时，为黑色
        root->color = RB_Color::BLACK;
    }else{
        while (x != NIL)
        { //找到合适的插入位置
            y = x;
            if (z->key < x->key){
                x = x->left;
            }
            else{
                x = x->right;
            }
        }
        z->parent = y;
        if (z->key < y->key){
            y->left = z;
        }
        else{
            y->right = z;
        }


    }
    RB_Insert_Fixup(z); //保持红黑树的性质
}

template<class T>
void RB_Tree<T>::RB_Insert_Fixup(RB_Node<T>* z){
    //RB_Node<T>* x;
    RB_Node<T>* y;
    while(z->parent->color == RB_Color::RED){
        if(z->parent == z->parent->parent->left){
            y = z->parent->parent->right;
            if(y->color == RB_Color::RED){
                z->parent->color = RB_Color::BLACK;
                y->color = RB_Color::BLACK;
                z->parent->parent->color = RB_Color::BLACK;
                z = z->parent->parent;
            }else{
                if(z == z->parent->right){
                    z = z->parent;
                    Left_Rotate(z);
                }
                z->parent->color = RB_Color::BLACK;
                z->parent->parent->color = RB_Color::RED;
                Right_Rotate(z->parent->parent);
            }

        }else{
            y = z->parent->parent->left;
            if(y->color == RB_Color::RED){
                z->parent->color = RB_Color::BLACK;
                y->color = RB_Color::BLACK;
                z->parent->parent->color = RB_Color::BLACK;
                z = z->parent->parent;
            }else{
                if(z == z->parent->left){
                    z = z->parent;
                    Right_Rotate(z);
                }
                z->parent->color = RB_Color::BLACK;
                z->parent->parent->color = RB_Color::RED;
                Left_Rotate(z->parent->parent);
            }
        }
    }
    root->color = RB_Color::BLACK;
}

template<class T>
void RB_Tree<T>::RB_Transplant(RB_Node<T>* u, RB_Node<T>* v){
    if(u->parent == NIL) {
        root = v;
    }else if(u == u->parent->left){
        u->parent->left = v;
    }else{
        u->parent->right = v;
    }
    v->parent = u->parent;
}

template<class T>
void RB_Tree<T>::RB_Delete(const T& k){
    RB_Node<T>* x;
    auto z = RB_Search_Node(k);
    auto y = z;
    auto y_original_color = y->color;
    if(z->left == NIL){
        x = z->right;
        RB_Transplant(z, z->right);
    }else if(z->right == NIL){
        x = z->left;
        RB_Transplant(z, z->left);
    }else{
        y = get_min(z->right);
        y_original_color = y->color;
        x = y->right;
        if(y->parent == z){
            x->parent = y;
        }else{
            RB_Transplant(y, y->right);
            y->right = z->right;
            y->right->parent = y;
        }
        RB_Transplant(z, y);
        y->left = z->left;
        y->left->parent = y;
        y->color = z->color;
    }
    if(y_original_color == RB_Color::BLACK){
        RB_Delete_Fixup(x);
    }
}

template<class T>
void RB_Tree<T>::RB_Delete_Fixup(RB_Node<T>* x){
    while(x != root && x->color == RB_Color::BLACK){
        if(x == x->parent->left){
            auto w = x->parent->right;
            if(w->color == RB_Color::RED){
                w->color = RB_Color::BLACK;
                x->parent->color = RB_Color::RED;
                Left_Rotate(x->parent);
                w = x->parent->right;
            }
            if(w->left->color == RB_Color::BLACK && w->right->color == RB_Color::BLACK){
                w->color = RB_Color::RED;
                x = x->parent;
            }
            else {
                if(w->right->color == RB_Color::BLACK){
                    w->left->color == RB_Color::BLACK;
                    w->color = RB_Color::RED;
                    Right_Rotate(w);
                    w = x->parent->right;
                }
                w->color = x->parent->color;
                x->parent->color = RB_Color::BLACK;
                w->right->color = RB_Color::BLACK;
                Left_Rotate(x->parent);
                x = root;
            }
        }
        else{
            auto w = x->parent->left;
            if(w->color == RB_Color::RED){
                w->color = RB_Color::BLACK;
                x->parent->color = RB_Color::RED;
                Right_Rotate(x->parent);
                w = x->parent->left;
            }
            if(w->left->color == RB_Color::BLACK && w->right->color == RB_Color::BLACK){
                w->color = RB_Color::RED;
                x = x->parent;
            }else {
                if(w->left->color == RB_Color::BLACK){
                    w->right->color == RB_Color::BLACK;
                    w->color = RB_Color::RED;
                    Left_Rotate(w);
                    w = x->parent->left;
                }
                w->color = x->parent->color;
                x->parent->color = RB_Color::BLACK;
                w->left->color = RB_Color::BLACK;
                Right_Rotate(x->parent);
                x = root;
            }
        }
    }
    x->color = RB_Color::BLACK;
}


template<class T>
RB_Node<T>* RB_Tree<T>::get_min(RB_Node<T>* root) {
    auto x = root;
    while(x->left != NIL){
        x = x->left;
    }
    return x;
}


//非递归中序遍历
template <class T>
void RB_Tree<T>::In_Order_Walk(int num){

    if(root != NULL){
        stack<RB_Node<T>*> temp_stack;
        auto temp_node = root;
        while(temp_node != NIL || !temp_stack.empty()){
            if(temp_node != NIL){
                temp_stack.push(temp_node);
                temp_node = temp_node->left;
            }
            else{
                temp_node = temp_stack.top();
                temp_stack.pop();
                cout << temp_node->key << " ";
                if(num == 1){
                    outfile_inorder << temp_node->key << " ";
                }else if(num == 2){
                    outfile_delete_data << temp_node->key << " ";
                }
                temp_node = temp_node->right;
            }
        }
    }
    cout << endl;
    cout << endl;
    if(num == 1){
        outfile_inorder << endl;
    }else if(num == 2){
        outfile_delete_data << endl;
    }
}

template <class T>
RB_Node<T>* RB_Tree<T>::RB_Search_Node(const T &k){
    auto x = root;
    while(x != NIL)
    {
        if(x->key == k)
            break;
        else if(x->key > k)
            x = x->left;
        else
            x = x->right;
    }
    return x;
}