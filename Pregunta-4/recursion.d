import std.stdio;
import std.datetime.stopwatch;
import std.conv;

int f43(int n){
    if(n >= 0 && n < 12){
        return n;
    }
    return f43(n - 3) + f43(n - 6) + f43(n - 9) + f43(n - 12);
}

int f43_tail_recursive(int n, int[] progress_array = [0,1,2,3,4,5,6,7,8,9,10,11], int i = 12){

    if(n >= 0 && n < 12){
        return progress_array[n];
    }

    int new_value = progress_array[0] + progress_array[3] + progress_array[6] + progress_array[9];

    if(n == i){
        return new_value;
    }

    progress_array ~= new_value;
    return f43_tail_recursive(n, progress_array[1..$], i + 1);

}

int f43_iterative(int n, int[] progress_array = [0,1,2,3,4,5,6,7,8,9,10,11], int i = 12){

    bool keep_going = true;
    int result;

    if(n >= 0 && n < 12){
        result = progress_array[n];
        keep_going = false;
    }

    while( keep_going ){

        int new_value = progress_array[0] + progress_array[3] + progress_array[6] + progress_array[9];

        if(n == i){
            result = new_value;
            break;
        }

        progress_array ~= new_value;
        progress_array = progress_array[1..$];
        i += 1;

    }

    return result;

}




void main() {
    writeln("n;Recursiva;TailRec;Iterativa");// Encabezado

    foreach (n; 0 .. 101) {
        auto sw1 = StopWatch(AutoStart.yes);
        f43(n);
        auto t1 = sw1.peek.total!"usecs";

        auto sw2 = StopWatch(AutoStart.yes);
        f43_tail_recursive(n);
        auto t2 = sw2.peek.total!"usecs";

        auto sw3 = StopWatch(AutoStart.yes);
        f43_iterative(n);
        auto t3 = sw3.peek.total!"usecs";

        // Imprimir en formato tabulado (pegable en Excel)
        
        writeln(n, ";", t1, ";", t2, ";", t3);
    }
}