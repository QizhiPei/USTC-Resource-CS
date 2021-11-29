#include <stdio.h>
int main()
{
	char c;
	int letters=0,space=0,digit=0,other=0;
	printf("请输入一行字符：\n");
	while((c=getchar())!='\n')
	{
	if(c>='a'&&c<='z'||c>='A'&&c<='Z')
		letters++;
	else if(c==' ')
		space++;
	else if(c>='0'&&c<='9')
		digit++;
	else
		other++;
	}
	printf("字母数：%d\n空格数：%d\n数字数：%d\n其他字符数：%d\n",letters,space,digit,other);
	return 0;
}
