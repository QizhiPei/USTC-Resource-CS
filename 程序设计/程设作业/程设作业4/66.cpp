#include<stdio.h>
#include<string.h>
int main()
{
	void connect(char s1[],char s2[],char s3[]);
	char s1[100],s2[100],s3[200];
	printf("请输入字符串1：");
	gets(s1);
	printf("请输入字符串2：");
	gets(s2); 
	connect(s1,s2,s3);
	printf("连接后的字符串为：%s",s3);
	return 0;
}

void connect(char s1[],char s2[],char s3[])
{
	int i,j;
	for(i=0;s1[i]!='\0';i++)
	 s3[i]=s1[i];
	for(j=0;s2[j]!='\0';j++)
	 s3[i+j]=s2[j];
	s3[i+j]='\0';
}
