#include<stdio.h>
int main()
{
    char s1[40],s2[40],s3[80];
    int i=0,j=0;
	printf("ÊäÈë×Ö·û´®1:");
	scanf("%s",s1);
	printf("ÊäÈë×Ö·û´®2:");
	scanf("%s",s2);
	for(i=0;s1[i]!='\0';i++)
	s3[i]=s1[i];
	for(i=0;s1[j]!='\0';j++)
	s3[i+j]=s2[j];
	s3[i+j]='\0';
	return 0;	
}
