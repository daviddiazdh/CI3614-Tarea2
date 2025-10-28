import std.stdio;
import std.conv;

int dist(int n, int acc = 0){
    if(n == 1){
        return acc;
    }
    if(n % 2 == 0){
        acc++;
        return dist(n / 2, acc);
    } else {
        acc++;
        return dist(3 * n + 1, acc);
    }
}

void main(){

}