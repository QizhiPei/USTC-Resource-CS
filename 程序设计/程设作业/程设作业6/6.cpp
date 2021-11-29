#include<stdio.h>
#include<stdlib.h>
struct student
{
	char num[10];
	char name[15];
	int score[3];
	float ave;
}st[10],temp;
int main()
{
	FILE*fp;
	int i,j,n;
	if((fp=fopen("stud","r"))==NULL)
	{
		printf("无法打开\n");
		exit(0);
	}
	printf("文件 stud:");
	for(i=0;fread(&st[i],sizeof(struct student),1,fp)!=0;i++)
	{
		printf("\n%8s%8s",st[i].num,st[i].name);
		for(j=0;j<3;j++)
		 printf("%8d",st[i].score[j]);
		printf("%10.2f",st[i].ave);
	}
	printf("\n");
	fclose(fp);
	n=i;
	for(i=0;i<n;i++)
	 for(j=i+1;j<n;j++)
	  if(st[i].ave<st[j].ave)
	  {
	  	temp=st[i];
	  	st[i]=st[j];
	  	st[j]=temp;
	  }
	  printf("\n新的顺序:");
	  fp=fopen("stu_sort","a");
	  for(i=0;i<n;i++)
	   {
	   	fwrite(&st[i],sizeof(struct student),1,fp);
	   	printf("\n%8s%8s",st[i].num,st[i].name);
	   	for(j=0;j<3;j++)
		 printf("%8d",st[i].score[j]);
		printf("%10.2f",st[i].ave);
	   }
	   printf("\n");
	   fclose(fp);
	   return 0;
}
