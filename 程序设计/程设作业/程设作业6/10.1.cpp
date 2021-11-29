#include<stdio.h>
#include<malloc.h>
#define LEN sizeof(struct student)
struct student
{
	long num;
	int score;
	struct student*next;
};
typedef struct student node;
node lista,listb;
int n,sum=0;

node*creat(void)
{
	node*head,*tail,*pnew;
	int score;
	long num;
	head=(node*)malloc(LEN);
	if(head==NULL)
	{
		printf("创建失败\n");
		return(NULL);
	}
	head->next=NULL;
	tail=head;
	printf("输入学生的学号和分数：\n");
	while(num!=0)
	{
		scanf("%ld,%d",&num,&score);
		if(score<0)
		break;
		pnew=(node*)malloc(LEN);
		if(pnew=NULL)
	     {
		   printf("创建失败\n");
		   return(NULL);
	     } 
	     pnew->score=score;
	     pnew->num=num;
	     pnew->next=NULL;
	     tail->next=pnew;
	     tail=pnew;
	}
	return(head)
}
node*insert(node*ah,node*bh)
{
	node*pa1,*pa2,*pb1,*pb2;
	pa2=pa1=ah;
	pb2=pb1=bh;
	do
	 {
	 	while
	 }
}

