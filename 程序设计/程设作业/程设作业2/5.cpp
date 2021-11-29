#include<stdio.h>
int main()
{
	int a,n,i=1,sn=0,tn=0;
	printf("a,n=:");
	scanf("%d,%d",&a,&n);
	while(i<=n)
	{
		tn=tn+a;
		sn=sn+tn;
		a=a*10;
		++i;
	}
	printf("a+aa+aaa+...=%d\n",sn);
	return 0;
}
