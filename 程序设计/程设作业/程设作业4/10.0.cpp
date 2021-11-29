#include<stdio.h>
#include<string.h>
void longword(char s[]);
int main()
{
	char str[50];
	printf("请输入一行字符：");
	gets(str);
	longword(str);
	return 0;
}

void longword(char s[])
{
	int max=0,len=0;
	char m[10],ma[10];
	int n=strlen(s),i,j;
	for(i=0,j=0;i<n;i++)
	{
		if((s[i]>='a'&&s[i]<='z')||(s[i]>='A'&&s[i]<='Z'))
		 m[len++]=s[i];
		else
		{
		 m[len]='\0';
		 len>max?max=len,strcpy(ma,m),len=0:len=0;
		 }
	}
	printf("最长的单词是：");
	puts(ma);
}
