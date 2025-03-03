import std.stdio;
import std.concurrency;

__gshared int* SHARED_VAR = null;

__gshared int HELLO = 0;

void main() {
    // Первый поток
    spawn(() {
        foreach (a; 1 .. 11) {
            while (SHARED_VAR != null) {}
            
            writeln("Передано ", a);
            HELLO = a;
            SHARED_VAR = &HELLO;
        }
        writeln("Первый поток завершён");
    });

    // Второй поток 
    spawn(() {
        int a = 0;
        while(true) {
            while (SHARED_VAR == null) {}
            writeln("Получено ", *SHARED_VAR);
            a++;
            if((*SHARED_VAR) == 10) break;
            SHARED_VAR = null;
        }
        writeln("Второй поток завершён");
    });
}

