#include<stdio.h>
int main()
{
	int t,a,b,c,d;
	printf("请输入四个数：");
	scanf("%d,%d,%d,%d",&a,&b,&c,&d);
	printf("a=%d,b=%d,c=%d,d=%d\n",a,b,c,d);
	if(a>b)
	{t=a,a=b,b=t;
	}
	if(a>c)
	{t=a,a=c,c=t;
	}
	if(a>d)
	{t=a,a=d,d=t;
	}
	if(b>c)
	{t=b,b=c,c=t;
	}
	if(b>d)
	{t=b,b=d,d=t;
	}
	if(c>d)
	{t=c,c=d,d=t;
	}
	printf("排序结果如下:\n");
	printf("%d %d %d %d \n"   ,a,b,c,d);
	return 0;
}
