#include<stdio.h>
int n,i,m;
int main()
{
	 void move(int a[],int b[],int j);
	int a[100],b[100];
	printf("你将输入多少个整数？\n");
	scanf("%d",&n);
	printf("请输入你要输入的n个整数：\n");
	for(i=0;i<n;i++)
	 scanf("%d",&a[i]);
	printf("请输入要移动的位置数m\n");
	scanf("%d",&m);
	move(a,b,m);
	printf("移动后的数列为：\n");
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
