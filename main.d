import std.stdio;
import std.concurrency;

__gshared int SHARED_VAR = 0;

void main() {
    // Первый поток
    spawn(() {
        foreach (a; 1 .. 11) {
            while (SHARED_VAR != 0) {}
            writeln("Передано ", a);
            SHARED_VAR = a;
        }
        writeln("Первый поток завершён");
    });

    // Второй поток
    spawn(() {
        while(true) {
            while (SHARED_VAR == 0) {}
            writeln("Получено ", SHARED_VAR);
            if(SHARED_VAR == 10) break;
            SHARED_VAR = 0;
        }
        writeln("Второй поток завершён");
    });
}
