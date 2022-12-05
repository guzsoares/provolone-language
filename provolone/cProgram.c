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
if (X != 0) {
X = 0;
}
for (int i = 0; i < Y; i++) {
X = X * 2;
}
X = X * X;
printf("Saida: [X] = %d \n", X);
return 0;
}