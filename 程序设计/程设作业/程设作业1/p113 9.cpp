#include<stdio.h>
#include<math.h> 
int main()
{
	 int num,a,b,c,d,e,place;
	 printf("请输入一个整数（0-99999）：");
	 scanf("%d",&num);
	 if (num>9999)
	 place=5;
	 else if(num>999)
	 place=4;
	 else if(num>99)
	 place=3;
	 else if(num>9)
	 place=2;
	 else place=1;
	 printf("位数：%d\n",place);
	 printf("每位数字为：");
	 a=num/10000;
	 b=(int)(num-a*10000)/1000;
	 c=(int)(num-a*10000-b*1000)/100;
	 d= (int)(num-a*10000-b*1000-c*100)/10;
	 e=(int)(num-a*10000-b*1000-c*100-d*10);
	 switch(place)
	 {
	 	case 5:printf("%d,%d,%d,%d,%d",a,b,c,d,e);
	 	printf("\n反序数字为：");
	 	printf("%d,%d,%d,%d,%d",e,d,c,b,a);
	 	break;
	 	case 4:printf("%d,%d,%d,%d",b,c,d,e);
	 	printf("\n反序数字为：");
	 	printf("%d,%d,%d,%d",e,d,c,b);
	 	break;
	 	case 3:printf("%d,%d,%d",c,d,e);
	 	printf("\n反序数字为：");
	 	printf("%d,%d,%d",e,d,c);
	 	break;
	 	case 2:printf("%d,%d",d,e);
	 	printf("\n反序数字为：");
	 	printf("%d,%d",e,d);
	 	break;
	 	case 1:printf("%d",e);
	 	printf("\n反序数字为：");
	 	printf("%d",e);
	 	break;
		  
	 }
	 return 0;
}
