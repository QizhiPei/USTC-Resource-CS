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
	int i,t,j,k;
	j=strlen(s1);
	k=strlen(s2);
	for(i=0;i<j;i++)
	 {
	 s3[i]=s1[i];
	 }
	for(t=j;t<j+k;t++)
	 {
	  s3[t]=s2[t-j];
	  }
	s3[t]='\0';
}
