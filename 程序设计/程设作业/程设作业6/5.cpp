#include<stdio.h>
struct student
{
	char num[10];
	char name[15];
	int score[3];
	float ave;
}stu[5];
int main()
{
	int i,j,sum;
	FILE*fp;
	for(i=0;i<5;i++)
	{
		printf("\n����ѧ���ķ���%d��\n",i+1);
		printf("ѧ��:");
		scanf("%s",stu[i].num);
		printf("������");
		scanf("%s",stu[i].name);
		sum=0;
		for(j=0;j<3;j++)
		{
			printf("����%d:",j+1);
			scanf("%d",&stu[i].score[j]);
			sum+=stu[i].score[j];
		 }
		 stu[i].ave=sum/3.0; 
	}
	fp=fopen("stud","a");
	for(i=0;i<5;i++)
	 if(fwrite(&stu[i],sizeof(struct student),1,fp)!=1)
	  printf("�ļ�д�����\n");
	fclose(fp);
	fp=fopen("stud","r");
	for(i=0;i<5;i++)
	{
		fread(&stu[i],sizeof(struct student),1,fp);
		printf("\nѧ�ţ�%s ������%s ���Ƴɼ���%d,%d,%d ƽ���ɼ���%6.2f\n",stu[i].num,stu[i].name,stu[i].score[0],stu[i].score[1],stu[i].score[2],stu[i].ave);
	}
	return 0;
}
