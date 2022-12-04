#include <stdio.h>
int main(void) {
int X;
printf("Entrada [X]: ");
scanf("%d",&X);
int Y;
printf("Entrada [Y]: ");
scanf("%d",&Y);
X = X + 1;
X = Y;
printf("Saida: [X] = %d \n", X);
return 0;
}