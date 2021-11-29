#include<stdio.h>
int main()
{
int a[11]={1,5,7,11,16,28,45,66,80,100};
int temp1,temp2,num,end,i,j;
printf("序列为：\n");
for(i=0;i<10;i++)
printf("%5d",a[i]);
printf("\n");
printf("请输入一个数；");
scanf("%d",&num);
end=a[9];
if(num>end)
a[10]=num;
else
{
	for(i=0;i<10;i++)
	{if(a[i]>num)
	 {temp1=a[i];
	a[i]=num;
	for(j=i+1;j<11;j++)
	      {temp2=a[j];
	a[j]=temp1;
	temp1=temp2;
	      }
	break;
	 }
	} 

}
printf("新序列是：\n");
for(i=0;i<11;i++)
printf("%5d",a[i]);
return 0;
 } 
