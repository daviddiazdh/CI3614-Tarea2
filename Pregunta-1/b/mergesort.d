import std.stdio;
import std.conv;

// =============================================================================================
// Función: merge
// =============================================================================================
// Función que implementa la típica función merge, que toma dos arreglos ordenados y los junta
// en un solo arreglo de forma ordenada. Básicamente, compara cada elemento del principio de los
// arreglos, sacando el menor de ellos a el arreglo de mezcla.  
// Ejemplo de uso: 
// merge([1,2,5], [3, 4, 6]) = [1, 2, 3, 4, 5, 6]
// Si quiere más detalles de la implementación, recuerde que adjunta a la entrega hay un PDF técnico
// =============================================================================================
float[] merge(float[] left, float[] right) {
    float[] result;
    result.length = left.length + right.length;

    // Uso de índices de control de avance los arreglos
    size_t i = 0, j = 0, k = 0;

    // Mientras ninguno sea vacío,
    // comparar que próximo valor es mejor y colocarlo en result
    while (i < left.length && j < right.length) {
        if (left[i] < right[j])
            result[k++] = left[i++];
        else
            result[k++] = right[j++];
    }

    // Copiar los sobrantes
    while (i < left.length)
        result[k++] = left[i++];

    while (j < right.length)
        result[k++] = right[j++];

    return result;
}

// =============================================================================================
// Función: merge_sort
// =============================================================================================
// Función que implementa la típica función merge_sort, que divide el arreglo en sub arreglos 
// que se evalúan recursivos y que se consideran ordenados cuando su longitud es uno, para luego
// llamar a merge para que los ordene de a pares según cada llamada.
// Ejemplo de uso: 
// merge_sort([1,5,6,2,4,3) = [1, 2, 3, 4, 5, 6]
// Si quiere más detalles de la implementación, recuerde que adjunta a la entrega hay un PDF técnico
// =============================================================================================
float[] merge_sort(float[] array){
    // Caso base
    if(array.length == 1){
        return array;
    }

    // Dividimos el arreglo en dos mitades
    int mid = array.length / 2;
    float[] left_array = array[0..mid]; 
    float[] right_array = array[mid..$];

    // Ordenamos esas mitades
    left_array = merge_sort(left_array);
    right_array = merge_sort(right_array);

    // Mezclamos dichos arreglos
    return merge(left_array, right_array);

}

void main(){
    writeln(merge_sort([1,2,6,7,2,2,1,0,6]));
}