import std.stdio;
import std.conv;

int count(int n, int acc = 0){
    if(n == 1){
        return acc;
    }
    // Si n es par, entonces hacemos recursión con n / 2
    if(n % 2 == 0){
        acc++;
        return count(n / 2, acc);
    // Si no, entonces hacemos recursión con 3n + 1
    } else {
        acc++;
        return count(3 * n + 1, acc);
    }
}

void main(){
    writeln(count(10));
}