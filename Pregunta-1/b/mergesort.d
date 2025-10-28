import std.stdio;
import std.conv;
import std.math;

float[] merge(float[] left_array, float[] right_array){
    float[] mix_array = [];

    while(left_array.length != 0 && right_array.length != 0){
        if(left_array[0] < right_array[0]){
            mix_array ~= left_array[0];
            left_array = left_array[1..$];
        } else if(left_array[0] >= right_array[0]){
            mix_array ~= right_array[0];
            right_array = right_array[1..$];
        }
    }

    mix_array ~= left_array ~ right_array;
    return mix_array;

}

float[] merge_sort(float[] array){
    if(array.length == 1){
        return array;
    }

    int mid = array.length / 2;
    float[] left_array = array[0..mid]; 
    float[] right_array = array[mid..$];

    //Ordenados
    left_array = merge_sort(left_array);
    right_array = merge_sort(right_array);

    return merge(left_array, right_array);

}

void main(){
    writeln(merge_sort([2]));
}