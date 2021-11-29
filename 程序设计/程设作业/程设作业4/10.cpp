#include<stdio.h>
#include<string.h>
void longword(char s[],char t[]);
int main()
{
	char str[60],lg[20];
	printf("请输入一行字符：");
	gets(str);
	longword(str,lg);
	printf("最长的单词是："); 
	puts(lg);
	return 0;
 } 
 
 void longword(char s[],char t[])
{
	int i,j,n,k,m,word;
	char p[40];
	n=strlen(s);
	m=0;
	word=0;
	for(i=0,j=0,k=0;i<n;i++)
	{
		if((s[i]>='a'&&s[i]<='z')||(s[i]>='A'&&s[i]<='Z'))
		{
			word=1;
			p[j++]=s[i];
		}
		else if(word==1)
		{
			if(j>k)
			{
				for(m=0;m<j;m++)
				 t[m]=p[m];
				 t[m]='\0';
				 k=j;
			}
			word=0;
			j=0;
		}
	}
}
