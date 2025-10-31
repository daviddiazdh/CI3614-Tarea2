import std.stdio;
import std.conv;
import std.algorithm;
import utils.utils;
import std.string;

string[] valid_operators = ["+", "-", "*", "/"];

int[string] precedence = [
    "+": 1,
    "-": 1,
    "*": 2,
    "/": 2
];

int parse_to_int(string str_num){
    int num;
    try{
        num = to!int(str_num);
        return num;
    } catch(Exception e){
        throw new Exception("Los argumentos deben ser número u operadores");
    }
}

float prefix_eval(string[] expr_array){
    if(expr_array == []){
        throw new Exception("Debe enviar una expresión válida.");
    }

    if(expr_array.length == 1){
        int num = parse_to_int(expr_array[0]);
        return num;
    }

    // Si expr_array no es vacío y no es de longitud 1
    int operand = parse_to_int(expr_array[$-1]);
    string operator = expr_array[0];

    float left_expr = prefix_eval(expr_array[1..$-1]);

    switch (operator) {
        case "+": return left_expr + operand;
        case "-": return left_expr - operand;
        case "*": return left_expr * operand;
        case "/": return left_expr / operand;
        default: throw new Exception("Operador inválido");
    }
}

string prefix_to_infix(string[] expr_array, string last_operator = ""){
    if(expr_array == []){
        throw new Exception("Debe enviar una expresión válida.");
    }

    if(expr_array.length == 1){
        int num = parse_to_int(expr_array[0]);
        return expr_array[0];
    }

    // Si expr_array no es vacío y no es de longitud 1
    int operand = parse_to_int(expr_array[$-1]);

    string operator = expr_array[0];
    if(!valid_operators.canFind(operator)){
        throw new Exception("Operador inválido");
    }

    string left_expr = prefix_to_infix(expr_array[1..$-1], operator);

    if(last_operator == "" || precedence[last_operator] <= precedence[operator]){
        return left_expr ~ " " ~ operator ~ " " ~ expr_array[$-1];
    } else {
        return "(" ~ left_expr ~ " " ~ operator ~ " " ~ expr_array[$-1] ~ ")";
    }
        

}

float postfix_eval(string[] expr_array){
    if(expr_array == []){
        throw new Exception("Debe enviar una expresión válida.");
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


string postfix_to_infix(string[] expr_array){
    if(expr_array == []){
        throw new Exception("Debe enviar una expresión válida.");
    }

    string[] expr_stack = [];

    // Si expr_array no es vacío
    while(expr_array != []){
        
        string element = expr_array[0];
        expr_array = expr_array[1..$];

        if(valid_operators.canFind(element)){
            string first_operand = pop_str(expr_stack);
            string second_operand = pop_str(expr_stack);
            
            string next_operator = next_operator(expr_array);

            if(next_operator == "" || precedence[next_operator] <= precedence[element]){
                push_str(expr_stack, second_operand ~ " " ~ element ~ " " ~ first_operand);
            } else{
                push_str(expr_stack, "(" ~ second_operand ~ " " ~ element ~ " " ~ first_operand ~ ")");
            }

            continue;

        }
        int num = parse_to_int(element);
        push_str(expr_stack, element);
    }

    if(expr_stack.length != 1){
        throw new Exception("Expresión postfija inválida.");
    }

    return expr_stack[0];

}






void main(){

    string[] prefix_expr = ["*", "+", "/", "/", "2", "1", "2", "3", "2"];
    string[] postfix_expr = ["2", "3", "*", "3", "+"];
    
    while(true){
        write("> ");
        string entry = readln();
        entry = entry[0..$-1];
        string[] entries_arr = entry.split(" ");

        if(entries_arr.length == 0){
            writeln("Error: Debe ingresar un comando.");
            continue;
        }

        float result;
        string result_str;
        bool exit = false;


        try{
            switch(toLower(entries_arr[0])){
                case "eval":
                    switch(toLower(entries_arr[1])){
                        case "pre":
                            result = prefix_eval(entries_arr[2..$]);
                            writeln(result);
                            break;
                        case "post":
                            result = postfix_eval(entries_arr[2..$]);
                            writeln(result);
                            break;
                        default:
                            writeln("Error: Comando desconocido.");
                            break;
                    }
                    break;
                case "mostrar":
                    switch(toLower(entries_arr[1])){
                        case "pre":
                            result_str = prefix_to_infix(entries_arr[2..$]);
                            writeln(result_str);
                            break;
                        case "post":
                            result_str = postfix_to_infix(entries_arr[2..$]);
                            writeln(result_str);
                            break;
                        default:
                            writeln("Error: Comando desconocido.");
                            break;
                    }
                    break;
                case "salir":
                    exit = true;
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