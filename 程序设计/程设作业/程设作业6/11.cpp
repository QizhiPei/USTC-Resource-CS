#include<stdio.h>
#include<string.h>
struct student
{
	int num;
	char name[15];
	struct student*next; 
 } a[4],b[5];
 
int main()
{
	struct student a[4]={{151,"Pei"},{152,"Li"},{105,"Zhang"},{106,"Guo"}};
	struct student b[5]={{162,"Guan"},{152,"Liu"},{125,"Wang"},{106,"lv"},{148,"Zhu"}};
	int i;
	struct student *p,*p1,*p2,*head1,*head2;
	
	head1=a;
	head2=b;
	printf("列表A为：\n");
	for(p1=head1,i=1;i<=4;i++)
	{
		if(i<4)
		p1->next=a+i;
		else
		p1->next=NULL;
		printf("%4d%8s\n",p1->num,p1->name);
		if(i<4)
		p1=p1->next;
	}
	printf("\n列表B为：\n");
	for(p2=head2,i=1;i<=5;i++)
	{
		if(i<5)
		p2->next=b+i;
		else
		p2->next=NULL;
		printf("%4d%8s\n",p2->num,p2->name);
		if(i<5)
		p2=p2->next;
	}
	p1=head1;
	while(p1!=NULL)
	{
		p2=head2;
		while((p1->num!=p2->num)&&(p2->next!=NULL))
		p2=p2->next;
		if(p1->num==p2->num)
		{
			if(p1==head1)
			head1=p1->next;
			else
			{
				p->next=p1->next;
				p1=p1->next;
			}
		}
		else
		{
			p=p1;
			p1=p1->next;
		}
	}
	printf("\n结果为：\n");
	p1=head1;
	while(p1!=NULL)
	{
		printf("%4d%7s\n",p1->num,p1->name);
		p1=p1->next;
		
	}
	return 0;
}
