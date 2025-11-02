import std.stdio;
import std.conv;
import std.algorithm;
import std.string;
import core.exception : RangeError;

// Tipo de dato que se usará en la evaluación de una expresión prefija,
// más adelante se explica
struct PrefixRecursionState
{
    string[] not_parsed_array;
    int value = 0;
    string expression = "";
}

// Arreglo que contiene todos los operadores válidos
string[] valid_operators = ["+", "-", "*", "/"];

// Arreglo que indica la precedencia de operadores 
// (no hace falta uno para asociatividad porque asocian a izquierda todos)
int[string] precedence = [
    "+": 1,
    "-": 1,
    "*": 2,
    "/": 2
];

// =============================================================================================
// Funciones de utilidad
// =============================================================================================

// Función que intenta parsear a entero, pero al fallar lanza una excepción
int parse_to_int(string str_num){
    int num;
    try{
        num = to!int(str_num);
        return num;
    } catch(Exception e){
        throw new Exception("Los argumentos deben ser número u operadores");
    }
}

// Función que en un arreglo de strings intenta buscar cuál es el primer operador,
// se le llama next_operator porque se usa en un contexto donde se quiere averiguar
// el próximo operador para verificar la necesidad de paréntesis. 
string next_operator(string[] expr_array){
    int i = 0;
    int n = expr_array.length;
    while(i < n){
        string element = expr_array[i];
        switch (element){
            case "+": 
            case "-": 
            case "*":
            case "/":
                return element;
            default:
                break;
        }
        i = i + 1;
    }
    return "";
}

// Función con tipo genérico que concatena el elemento element al final del arreglo stack
void push(T)(ref T[] stack, T element) {
    stack ~= element;
}

// Función con tipo genérico para quitar el último elemento en el stack
T pop(T)(ref T[] stack) {
    try {
        T element = stack[$ - 1];
        stack = stack[0 .. $ - 1];
        return element;
    } catch (RangeError e) {
        throw new Exception("Expresión inválida");
    } catch (Exception e) {
        throw new Exception("Expresión inválida");
    }
}

// =============================================================================================


// =============================================================================================
// Función: prefix_eval
// =============================================================================================
// La función prefix_eval reciba la expresión en un arreglo que contiene
// los operadores y operandos de la expresión en string.
// Esta función se encarga evaluar una expresión prefija de forma recursiva, 
// si recibe un número, entonces actualiza el arreglo de expresión quitando dicho número y 
// devuelve tanto el arreglo actualizado como el número.
// Sin embargo, si recibe un operador, entonces se llama recursivamente 
// para obtener la expresión izquierda, una vez que recibe la respuesta, 
// entonces vuelve a llamarse recursivamente, pero con el nuevo arreglo que no pudo terminar 
// de analizar la expresión izquierda, si todo sale bien, entonces 
// opera los resultados númericos tanto de la izquierda como de la derecha y devuelve el arreglo 
// parseado (hasta donde pudo la expresión derecha) y el valor de la expresión resultante.
// Ejemplo de uso: 
// prefix_eval(["+", "*", "2", "2", "3"]) debería devolver una estructura como esta
// {
//   not_parsed_array = "[]",
//   value = 7,
//   expression = ""
// }     
// Si quiere más detalles de la implementación, recuerde que adjunta a la entrega hay un PDF técnico
// =============================================================================================
PrefixRecursionState prefix_eval(string[] expr_array){
    if(expr_array == []){
        throw new Exception("Expresión prefija inválida.");
    }

    string element = expr_array[0];

    if(!valid_operators.canFind(element)){
        int num = parse_to_int(expr_array[0]);
        return PrefixRecursionState(expr_array[1..$], num);
    }

    string operator = element;
    PrefixRecursionState left_expr = prefix_eval(expr_array[1..$]);

    if(left_expr.not_parsed_array == []){
        throw new Exception("Expresión prefija inválida.");
    }

    PrefixRecursionState right_expr = prefix_eval(left_expr.not_parsed_array);

    switch (operator) {
        case "+": return PrefixRecursionState(right_expr.not_parsed_array, left_expr.value + right_expr.value);
        case "-": return PrefixRecursionState(right_expr.not_parsed_array, left_expr.value - right_expr.value);
        case "*": return PrefixRecursionState(right_expr.not_parsed_array, left_expr.value * right_expr.value);
        case "/": return PrefixRecursionState(right_expr.not_parsed_array, left_expr.value / right_expr.value);
        default: throw new Exception("Operador inválido");
    }
}


// =============================================================================================
// Función: prefix_to_infix
// =============================================================================================
// La función prefix_to_infix hace exactamente lo mismo que la función pre_eval, pero
// en vez de devolver la expresión evaluada, devuelve la expresión parseada a string en infijo.
// Nuevamente, el caso base es cuando se encuentra con un número, y el caso recursivo cuando
// se encuentra con un operador, en este caso, manda a parsear la expresión recursivamente
// hasta donde pueda para obtener la expresión izquierda, luego tomará el arreglo de expresión
// que quedó por parsear y lo volverá a evaluar recursivamente para la expresión derecha,
// finalmente tomará los strings generados por la izquierda y derecha y los concatenará con el
// respectivo operador. Esta debe saber cuando usar paréntesis y lo hace guardando el último
// operador parseado, si la precedencia del último operador parseado es mayor que la del actual
// operador, entonces también concatena paréntesis al inicio y final
// Ejemplo de uso: 
// prefix_to_infix(["+", "*", "2", "2", "3"]) debería devolver una estructura como esta
// {
//   not_parsed_array = "[]",
//   value = 0,
//   expression = "2 * 2 + 3"
// }     
// Si quiere más detalles de la implementación, recuerde que adjunta a la entrega hay un PDF técnico
// =============================================================================================
PrefixRecursionState prefix_to_infix(string[] expr_array, string last_operator = ""){
    if(expr_array == []){
        throw new Exception("Expresión prefija inválida.");
    }

    string element = expr_array[0];

    if(!valid_operators.canFind(element)){
        int num = parse_to_int(expr_array[0]);
        return PrefixRecursionState(not_parsed_array: expr_array[1..$], expression: expr_array[0]);
    }

    string operator = element;
    PrefixRecursionState left_expr = prefix_to_infix(expr_array[1..$], operator);

    if(left_expr.not_parsed_array == []){
        throw new Exception("Expresión prefija inválida.");
    }

    PrefixRecursionState right_expr = prefix_to_infix(left_expr.not_parsed_array, operator);

    if(last_operator == "" || precedence[last_operator] <= precedence[operator]){
        return PrefixRecursionState(
            not_parsed_array: right_expr.not_parsed_array,
            expression: left_expr.expression ~ " " ~ operator ~ " " ~ right_expr.expression
        );
    } else {
        return PrefixRecursionState(
            not_parsed_array: right_expr.not_parsed_array,
            expression: "(" ~ left_expr.expression ~ " " ~ operator ~ " " ~ right_expr.expression ~ ")"
        );
    }
}

// =============================================================================================
// Función: postfix_eval
// =============================================================================================
// La función postfix_eval se fundamenta en una pila para la evaluación de la expresión, al igual
// que antes, esta trabaja sobre un arreglo de strings que contiene operadores y operandos, 
// esta no funciona recursivamente, sino iterativamente, tratará de evaluar la expresión hasta que
// el arreglo esté vacío. 
// Comienza tomando un elemento del arreglo, entonces se tienen tres casos
//    Si el elemento es un número, entonces lo empila a expr_stack
//    Si el elemento es un operador (todos binarios), entonces desempila dos elementos de expr_stack
//    y los opera con dicho operador y empila el resultado en expr_stack
//    Si el elemento no es un operador ni un número, entonces lanza una excepción. 
// Esto se repite hasta que expr_array esté vacío, en dicho momento, al principio de la pila estará
// el resultado si todo salió bien. Si en la pila hay más de un elemento al finalizar, entonces
// la expresión dada era inválida y lanza una excepción.
// Ejemplo de uso: 
// podtfix_eval(["2", "2", "*", "3", "+"]) debería devolver 7
// Si quiere más detalles de la implementación, recuerde que adjunta a la entrega hay un PDF técnico
// =============================================================================================
float postfix_eval(string[] expr_array){
    if(expr_array == []){
        throw new Exception("Expresión postfija inválida.");
    }

    int[] expr_stack = []; 

    // Si expr_array no es vacío
    while(expr_array != []){
        
        string element = expr_array[0];
        expr_array = expr_array[1..$];

        if(valid_operators.canFind(element)){
            int first_operand = pop(expr_stack);
            int second_operand = pop(expr_stack);

            switch (element){
                case "+": 
                    push(expr_stack, second_operand + first_operand);
                    break;
                case "-": 
                    push(expr_stack, second_operand - first_operand);
                    break;
                case "*": 
                    push(expr_stack, second_operand * first_operand);
                    break;
                case "/": 
                    push(expr_stack, second_operand / first_operand);
                    break;
                default:
                    break;
            }
            continue;
        }
        int num = parse_to_int(element);
        push(expr_stack, num);
    }

    if(expr_stack.length != 1){
        throw new Exception("Expresión postfija inválida.");
    }

    return expr_stack[0];
}


// =============================================================================================
// La función postfix_to_infix convierte una expresión postfija a infija, al igual que postfix_eval,
// esta usa la pila expr_stack, pero esta vez guarda las expresiones ya parseada allí, o sea,
// en vez de tener una pila como [1, 5, 10], tiene en cambio una como ["(10 + 1)", "2 * 3", "5"].
// Al igual que antes, se toma el primer elemento de expr_array y se dan tres casos
//    Si el elemento es un número, entonces se mantiene en string el número y se devuelve
//    Si el elemento es un operador válido, entonces se desempilan dos expresiones de la pila y
//    se concatenan con el operador en medio, pero se debe verificar la necesiadad de paréntesis,
//    para ello, se busca cuál es el siguiente operador en expr_array, si el próximo operador
//    tiene mayor precedencia que el actual, entonces se deben usar paréntesis.
//    Si no es número ni operador, entonces lanza excepción.
// Al igual que postfix_eval si el programa termina y la pila no tiene un solo elemento, entonces
// la expresión dada no fua válida y se lanza una excepción.
// Ejemplo de uso: 
// podtfix_eval(["2", "2", "*", "3", "+"]) debería devolver "2 * 2 + 3"
// Si quiere más detalles de la implementación, recuerde que adjunta a la entrega hay un PDF técnico
// =============================================================================================
string postfix_to_infix(string[] expr_array){
    if(expr_array == []){
        throw new Exception("Expresión postfija inválida.");
    }

    string[] expr_stack = [];

    // Si expr_array no es vacío
    while(expr_array != []){
        string element = expr_array[0];
        expr_array = expr_array[1..$];

        if(valid_operators.canFind(element)){
            string first_operand = pop(expr_stack);
            string second_operand = pop(expr_stack);
            
            string next_operator = next_operator(expr_array);

            if(next_operator == "" || precedence[next_operator] <= precedence[element]){
                push(expr_stack, second_operand ~ " " ~ element ~ " " ~ first_operand);
            } else{
                push(expr_stack, "(" ~ second_operand ~ " " ~ element ~ " " ~ first_operand ~ ")");
            }

            continue;

        }
        int num = parse_to_int(element);
        push(expr_stack, element);
    }

    if(expr_stack.length != 1){
        throw new Exception("Expresión postfija inválida.");
    }

    return expr_stack[0];

}


void main(){
    writeln("Bienvenido al analizador de expresions prefijas y postfijas.\nEscriba AYUDA si requiere asistencia.");

    while(true){
        write("> ");
        string entry = readln();
        entry = entry[0..$-1];
        // Se dividen los elementos enviados por medio de un espacio
        string[] entries_arr = entry.split(" ");

        if(entries_arr.length == 0){
            writeln("Error: Debe ingresar un comando.");
            continue;
        }

        float result;
        string result_str;
        bool exit = false;

        // Utilizamos try catch para enviar excepciones y sean reconocidas en el catch sin tener que
        // establecer métodos para salir de las funciones llamadas y demás.
        try{
            // Hacemos un toLower para permitir que el usuario escriba eval o eVal o EVAL 
            // o cualquier combinación entre mayúsculas y minúsculas
            switch(toLower(entries_arr[0])){
                case "eval":
                    switch(toLower(entries_arr[1])){
                        case "pre":
                            PrefixRecursionState prefix_result = prefix_eval(entries_arr[2..$]);
                            writeln(prefix_result.value);
                            break;
                        case "post":
                            result = postfix_eval(entries_arr[2..$]);
                            writeln(result);
                            break;
                        default:
                            writeln("Error: Comando con uso erróneo.\nUso: EVAL [PRE/POST] [expr]");
                            break;
                    }
                    break;
                case "mostrar":
                    switch(toLower(entries_arr[1])){
                        case "pre":
                            PrefixRecursionState prefix_result = prefix_to_infix(entries_arr[2..$]);
                            writeln(prefix_result.expression);
                            break;
                        case "post":
                            result_str = postfix_to_infix(entries_arr[2..$]);
                            writeln(result_str);
                            break;
                        default:
                            writeln("Error: Comando con uso erróneo.\nUso: MOSTRAR [PRE/POST] [expr]");
                            break;
                    }
                    break;
                case "salir":
                    writeln("Cerrando...");
                    exit = true;
                    break;
                case "ayuda":
                    writeln("EVAL PRE [expr]        -> Evalúa la expresión [expr] que debe está en forma prefija.");
                    writeln("EVAL POST [expr]       -> Evalúa la expresión [expr] que debe está en forma postfija.");
                    writeln("MOSTRAR PRE [expr]     -> Muestra la expresión [expr], que debe está en forma prefija, en su forma infija.");
                    writeln("MOSTRAR POST [expr]    -> Muestra la expresión [expr], que debe está en forma postfija, en su forma infija.");
                    writeln("SALIR                  -> Sale del programa.");
                    break;
                default:
                    writeln("Error: Comando desconocido.");
                    break;
            }
            if(exit) break;
        } catch (Exception e){
            writeln("Error: ", e.msg);
        }
    }

}