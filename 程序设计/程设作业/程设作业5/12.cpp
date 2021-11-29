#include<stdio.h>
#include<string.h>
void sort(char *s[])
{
	int i,j;
	char *temp;
	for(i=0;i<9;i++)
	 for(j=0;j<9-i;j++)
	  if(strcmp(*(s+j),*(s+j+1))>0)
	   {
	   	temp=*(s+j);
	   	*(s+j)=*(s+j+1);
	   	*(s+j+1)=temp;
	   }
}

int main()
{
	int i;
	char *p[10],str[10][20];
	for(i=0;i<10;i++)
	 p[i]=str[i];
	printf("请输入10个字符串：\n");
	for(i=0;i<10;i++)
	 scanf("%s",p[i]);
	sort(p);
	printf("新的顺序为：\n");
	for(i=0;i<10;i++)
	 printf("%s\n",p[i]);
	return 0;
}
