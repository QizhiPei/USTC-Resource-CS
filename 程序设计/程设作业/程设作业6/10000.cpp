#include<stdio.h>
#include<malloc.h>
#define NULL 0
#define LEN sizeof(struct student)
struct student
{
	long num;
	float score;
	struct student *next;
};
int n,sum=0;
struct student lista,listb;

struct student*creat(void)
{
	struct student*head,*tail,*pnew;
	int score;
	long num;
	head=(struct student*)malloc(LEN);
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
		pnew=(struct student*)malloc(LEN);
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
	return(head);
}
int print(struct student *head)
{
	struct student *p;
	printf("\nNow ,These %d records are:\n",n);
	p=head;
	if(head!=NULL)
	do{
		printf("%ld,%5.1f\n",p->num,p->score);
		p=p->next;
	}while(p!=NULL);
}
 
struct student *insert(struct student *ah,struct student *bh)
{
	struct student *pa1,*pa2,*pb1,*pb2;
	pa2=pa1=ah;
	pb2=pb1=bh;
	
	do
	{while((pb1->num)>(pa1->num)&&(pa1->next!=NULL))
	        {
	         pa2=pa1;
		     pa1=pa1->next;	
	          }
	if((pb1->num)<=(pa1->num))
	   {
		if(ah==pa1)ah=pb1;
		else
		pa2->next=pb1;
		pb1=pb1->next;
		pb2->next=pa1;
		pa2=pb2;
		pb2=pb1;
	    
	   }
	}while((pa1->next!=NULL)||(pa1==NULL&&pb1!=NULL));
	if((pb1!=NULL)&&(pb1->num>pa1->num)&&(pa1->next==NULL))
	pa1->next=pb1;
	return ah;
}
int main()
{
	struct student *ahead ,*bhead,*abh;
	long del_num;
	printf("input list a:\n");
	ahead=creat();
	sum=sum+n;
	printf("input list b:\n");
	bhead=creat();
	sum=sum+n;
	abh=insert(ahead,bhead);
	print(abh);
	return 0;	
}

