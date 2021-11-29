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
		printf("\n输入学生的分数%d：\n",i+1);
		printf("学号:");
		scanf("%s",stu[i].num);
		printf("姓名：");
		scanf("%s",stu[i].name);
		sum=0;
		for(j=0;j<3;j++)
		{
			printf("分数%d:",j+1);
			scanf("%d",&stu[i].score[j]);
			sum+=stu[i].score[j];
		 }
		 stu[i].ave=sum/3.0; 
	}
	fp=fopen("stud","a");
	for(i=0;i<5;i++)
	 if(fwrite(&stu[i],sizeof(struct student),1,fp)!=1)
	  printf("文件写入错误\n");
	fclose(fp);
	fp=fopen("stud","r");
	for(i=0;i<5;i++)
	{
		fread(&stu[i],sizeof(struct student),1,fp);
		printf("\n学号：%s 姓名：%s 各科成绩：%d,%d,%d 平均成绩：%6.2f\n",stu[i].num,stu[i].name,stu[i].score[0],stu[i].score[1],stu[i].score[2],stu[i].ave);
	}
	return 0;
}
