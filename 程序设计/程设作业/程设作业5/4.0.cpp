#include<stdio.h>
int n,i,m;
int main()
{
	 void move(int *p,int *q,int j);
	int a[100],b[100];
	int *p,*q;
	p=a;
	q=b;
	printf("�㽫������ٸ�������\n");
	scanf("%d",&n);
	printf("��������Ҫ�����n��������\n");
	for(i=0;i<n;i++)
	 scanf("%d",&p[i]);
	printf("������Ҫ�ƶ���λ����m\n");
	scanf("%d",&m);
	move(p,q,m);
	printf("�ƶ��������Ϊ��\n");
	for(i=0;i<n;i++)
	 printf("%d ",b[i]);
	 return 0; 	 
 } 
 
 void move(int *p,int *q,int j)
 {
 	for(j=0;j<n-m;j++)
 	 q[m+j]=p[j];
 	for(j=0;j<m;j++)
 	 q[j]=p[n-m+j];
 }
