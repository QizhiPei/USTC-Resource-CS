#include<stdio.h>
int main()
{
	float score;
	char grade;
	printf("������ѧ���ɼ���");
	scanf("%f",&score);
	while(score>100||score<0)
	{printf("\n������������������");
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
	 printf("�ɼ���%5.1f����Ӧ�ĵĵȼ���%c\n",score,grade);
	 return 0;
}
