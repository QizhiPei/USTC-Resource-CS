#include<stdio.h>
#include<stdlib.h> 
#define n 4
#define m 5
int main()
{
	int i,j,k,a[n][m],max,maxj,flag;
	printf("请输入数组：\n");
	for(i=0;i<n;i++)
	 for(j=0;j<m;j++)
	  scanf("%d",&a[i][j]);
	for(i=0;i<n;i++)
	 {max=a[i][0];
	  maxj=0;
	  for(j=0;j<m;j++)
	  if(a[i][j]>max)
	   {max=a[i][j];
	    maxj=j;
	   }
	   flag=1;
	   for(k=0;k<n;k++)
	    if(max>a[k][maxj])
	     {flag=0;
	      continue; 
		 }
		if(flag)
		 {printf("a[%d][%d]=%d\n",i+1,maxj+1,max);
		  break;
		  }
		   
	   }  
	   if(!flag)
	   printf("鞍点不存在\n");
	   return 0;
}
