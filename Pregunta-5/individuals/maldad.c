#include<stdio.h>
#include<math.h>
double tribonacci(double n,double i,double f1,double f2,double f3){if(n>=0&&n<3){return n;}if(i==n){return f3;}else{return tribonacci(n,i+1,f2,f3,f1+f2+f3);}}
double factorial(double n){if(n<=1){return 1;}return n*factorial(n-1);}
double comb(double n,double k){return factorial(n)/(factorial(k)*factorial(n-k));}
double logaritmo2(double x){return log(x)/log(2.0);}
double narayana(double n,double k){return(1.0/n)*comb(n,k)*comb(n,k-1);}
double maldad(double n){int index=(int)floor(logaritmo2(narayana(n,(int)logaritmo2(n))))+1;return tribonacci(index,2,0,1,2);}
int main(){int n;printf("Ingresa un numero: ");scanf("%d",&n);printf("%f",maldad(n));return 0;}