 #include<stdio.h>
 #define N 3
 int a[N][N];
  int convert(int a[][3])
 {
 	int i,j,t;
 	for(i=0;i<N;i++)
 	 for(j=i+1;j<N;j++)
 	  {t=a[j][i];
 	  a[j][i]=a[i][j];
 	  a[i][j]=t;}
 }
 int main()
 {
 	int i,j;
 	printf("请输入一个数组：\n");
 	for(i=0;i<N;i++)
 	 for(j=0;j<N;j++)
 	  scanf("%d",&a[i][j]);
 	convert(a);
	printf("转置后的数组为：\n");
	for(i=0;i<N;i++)
	{
			 printf("\n"); 
 	 for(j=0;j<N;j++)
 	  printf("%5d",a[i][j]);
 }
  
 	return 0;
	   
 }
 

