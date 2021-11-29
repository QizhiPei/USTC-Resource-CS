#include<stdio.h>
int main()
{
	int day,x1,x2;
	day=9;
	x2=1;
	while(day>0)
	{x1=(x2+1)*2;
	x2=x1;
	day--;
	}
	printf("第一天共摘了%d个桃子\n",x1);
	return 0;
}
