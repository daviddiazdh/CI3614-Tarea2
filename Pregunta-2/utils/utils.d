module utils.utils;

void push(ref int[] stack, int element){
    stack ~= element;
}

int pop(ref int[] stack){
    try{
        int element = stack[$-1];
        stack = stack[0..$-1];
        return element;
    } catch (Exception e){
        throw new Exception("Expresión inválida");
    }
}

void push_str(ref string[] stack, string element){
    stack ~= element;
}

string pop_str(ref string[] stack){
    try{
        string element = stack[$-1];
        stack = stack[0..$-1];
        return element;
    } catch (Exception e){
        throw new Exception("Expresión inválida");
    }
}