#include<stdio.h>
#include<malloc.h>
#define LEN sizeof(struct student)
struct student
{
	long num;
	int score;
	struct student*next;
};
struct student lista,listb;
int n,sum=0;
struct student*creat(void)
{
	struct student*p1,*p2,*head;
	n=0;
	p1=p2=(struct student*)malloc(LEN);
	printf("请输入学生的学号和成绩：\n");
	printf("如果学号是0，则停止输入\n");
	scanf("%ld,%d",&p1->num,&p1->score);
	head=NULL;
	while(p1->num!=0)
	{
		n+=1;
		if(n==1)
		 head=p1;
		else
		 p2->next=p1;
		p2=p1;
		p1=(struct student*)malloc(LEN);
		scanf("%ld,%d",case 1:sum=date1.day;break;);
	}
	p2->next=NULL;
	return(head);
}
