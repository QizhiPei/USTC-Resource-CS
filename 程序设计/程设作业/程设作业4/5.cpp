#include<stdio.h>
#include<string.h>
int main()
{
	void reverse(char s[]);
	char s[100];
	printf("������һ���ַ�����\n");
	gets(s);
	reverse(s);
	printf("�����ַ���Ϊ��%s",s) ;
	return 0;
 } 
 
 void reverse(char s[])
 {
 	int i,j;
 	char c;
 	j=strlen(s)-1;
 	for(i=0;i<j;i++)
 	{
	 c=s[i];
 	 s[i]=s[j];
 	 s[j]=c;
 	 j--;
	  }
 }
