#include<stdio.h>
#define N 10
#define M 5
float score[N][M];
float astu[N],acour[M];
int r,c;
void inputstu(void)
{
	int i,j;
	for(i=0;i<N;i++)
	 {
	 	printf("\n输入学生%2d的分数:\n",i+1);
	 	 for(j=0;j<M;j++)
	 	  scanf("%f",&score[i][j]);
	 }
}
void averstu(void)
{
	int i,j;
	float s;
	for(i=0;i<N;i++)
	 {
	 	for(j=0,s=0;j<M;j++)
	 	s+=score[i][j];
	 	astu[i]=s/5.0;
	 }
}
void avercour(void)
{
	int i,j;
	float s;
	for(j=0;j<M;j++)
	 {
	 	s=0;
	 	for(i=0;i<N;i++)
	 	s+=score[i][j];
	 	acour[j]=s/(float)N;
	 }
}
float highest()
{
	float high;
	int i,j;
	high=score[0][0];
	 for(i=0;i<N;i++)
	  for(j=0;j<M;j++)
	   if(score[i][j]>high)
	    {
		 high=score[i][j];
	     r=i+1;
	     c=j+1;
	    }
	    return(high);
}

float svar(void)
{
	int i;
	float sumx,sumxn;
	sumx=0.0;
	sumxn=0.0;
	for(i=0;i<N;i++)
	 {
	 	sumx+=astu[i]*astu[i];
	 	sumxn+=astu[i];
	 }
	 return(sumx/N-(sumxn/N)*(sumxn/N));
}

int main()
{
	int i,j;
	float h;
	inputstu();
	averstu();
	avercour();
	printf("\n  NO.   课程1   课程2    课程3   课程4   课程5   aver\n");
	for(i=0;i<N;i++)
	 {
	 	printf("\n NO %2d",i+1);
	 	for(j=0;j<M;j++)
	 	 printf("%8.2f",score[i][j]);
	 	printf("%8.2f\n",astu[i]);
	 }
	 printf("\n平均成绩:");
	 for(j=0;j<M;j++)
	  printf("%8.2f",acour[j]);
	printf("\n");
	h=highest();
	printf("最高分:%7.2f   NO.%2d   课程%2d\n",h,r,c);
	printf("方差%8.2f\n",svar());
	return 0;	
}
