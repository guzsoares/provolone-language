#include <stdio.h>
int main(void) {
int X;
printf("Entrada [X]: ");
scanf("%d",&X);
int Y;
printf("Entrada [Y]: ");
scanf("%d",&Y);
for (int i = 0; i < Y; i++) {
X = X + 1;
}
printf("Saida: [X] = %d \n", X);
return 0;
}