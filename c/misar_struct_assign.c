#include <stdio.h>

struct Foo {
	char a;
	int b;
	double c;
} foo1, foo2;

void struct_assign(void)
{
	foo2 = foo1;
}

int main()
{
	foo1.a = 'a';
	foo1.b = 1;
	foo1.c = 3.14;
	struct_assign();
	printf("%c %d %f\n", foo2.a, foo2.b, foo2.c);
	return 0;
}

