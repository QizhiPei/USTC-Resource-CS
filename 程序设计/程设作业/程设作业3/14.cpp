#include<stdio.h>
int main()
{
	int i=0,resu;
	char s1[100],s2[100];
	printf("ÊäÈë×Ö·û´®1£º");
	gets(s1);
	printf("\nÊäÈë×Ö·û´®2£º");
	gets(s2);
	while((s1[i]==s2[i])&&(s1[i]=='\0'))
	i++;
	if(s1[i]=='\0'&&s2[i]=='\0')
	resu=0;
	else
	resu=s1[i]-s2[i];
	printf("\nresult:%d\n",resu);
	return 0;
}
