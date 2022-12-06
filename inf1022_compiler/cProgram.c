#include <stdio.h>
int main(void) {
int X;
printf("Entrada [X]: ");
scanf("%d",&X);
int Y;
printf("Entrada [Y]: ");
scanf("%d",&Y);
while (Y > 0) {
Y = Y - 1;
X = X * 2;
}
printf("Saida: [X] = %d \n", X);
return 0;
}