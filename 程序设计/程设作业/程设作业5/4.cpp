#include<stdio.h>
int n,i,m;
int main()
{
	 void move(int a[],int b[],int j);
	int a[100],b[100];
	printf("�㽫������ٸ�������\n");
	scanf("%d",&n);
	printf("��������Ҫ�����n��������\n");
	for(i=0;i<n;i++)
	 scanf("%d",&a[i]);
	printf("������Ҫ�ƶ���λ����m\n");
	scanf("%d",&m);
	move(a,b,m);
	printf("�ƶ��������Ϊ��\n");
	for(i=0;i<n;i++)
	 printf("%d ",b[i]);
	 return 0; 	 
 } 
 
 void move(int a[],int b[],int j)
 {
 	for(j=0;j<n-m;j++)
 	 b[m+j]=a[j];
 	for(j=0;j<m;j++)
 	 b[j]=a[n-m+j];
 }
