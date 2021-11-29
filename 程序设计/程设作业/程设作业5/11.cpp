#include<stdio.h>
#include<string.h>
void sort(char s[10][20])
{
	int i,j;
	char *p,temp[20];
	p=temp;
	for(i=0;i<9;i++)
	 for(j=0;j<9-i;j++)
	  if(strcmp(s[j],s[j+1])>0)
	  {
	  	strcpy(p,s[j]);
	  	strcpy(s[j],s[j+1]);
	  	strcpy(s[j+1],p);
	  }
}
int main()
{
	int i;
	char str[10][20];
	printf("请输入10个字符串\n");
	for(i=0;i<10;i++)
	  scanf("%s",&str[i]);
	sort(str);
	printf("新的顺序为：\n");
	for(i=0;i<10;i++)
	 printf("%s\n",str[i]);
	return 0;
}
