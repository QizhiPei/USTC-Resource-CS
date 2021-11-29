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
struct student *creat(void)
{
	struct student *head;
	struct student *p1,*p2;
	n=0;
	p1=p2=(struct student*)malloc(LEN);
	printf("请输入学生的学号和分数:\n");
	printf("当学号为0时停止输入.\n");
		scanf("%ld,%f",&p1->num,&p1->score);
		head=NULL;
		while(p1->num!=0)
		{
			n++;
			if(n==1)head=p1;
			else p2->next=p1;
			p2=p1;
			p1=(struct student*)malloc(LEN);
			scanf("%ld,%f",&p1->num,&p1->score);
		}
		p2->next=NULL;
		return head;	
} 
 
int print(struct student *head)
{
	struct student *p;
	printf("\n新的排列为 :\n",n);
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
	printf("输入列表a:\n");
	ahead=creat();
	sum=sum+n;
	printf("输入列表b:\n");
	bhead=creat();
	sum=sum+n;
	abh=insert(ahead,bhead);
	print(abh);
	return 0;	
}


