#include<stdio.h>
int main()
{
	float score;
	char grade;
	printf("请输入学生成绩：");
	scanf("%f",&score);
	while(score>100||score<0)
	{printf("\n输入有误，请重新输入");
	 scanf("%f",&score);
	 } 
	 switch((int)(score/10))
	 {
	 case 10:
	 case 9:grade='A';break;
	 case 8:grade='B';break;
	 case 7:grade='C';break;
	 case 6:grade='D';break;
	 case 5:
	 case 4:
	 case 3:
	 case 2:
	 case 1:
	 case 0:grade='E';
	 }
	 printf("成绩是%5.1f，相应的的等级是%c\n",score,grade);
	 return 0;
}
