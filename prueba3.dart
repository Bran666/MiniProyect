import 'package:dart_console/dart_console.dart';

void main() {
  var console = Console();

  var nombres = <String>[];
  var apellidos = <String>[];

  while (true) {
    console.clearScreen();
    console.setForegroundColor(ConsoleColor.cyan);
    console.writeLine('--- Menú de Nombres y Apellidos ---\n');
    console.setForegroundColor(ConsoleColor.white);
    console.writeLine('1. Agregar Nombre');
    console.writeLine('2. Agregar Apellido');
    console.writeLine('3. Mostrar Nombres y Apellidos');
    console.writeLine('4. Salir\n');

    console.writeLine('Seleccione una opción: ');
    var opcion = console.readLine();

    switch (opcion) {
      case '1':
        console.writeLine('Ingrese un nombre: ');
        String nombre = console.readLine()!;
        nombres.add(nombre);
        break;
      case '2':
        console.writeLine('Ingrese un apellido: ');
        String apellido = console.readLine()!;
        apellidos.add(apellido);
        break;
      case '3':
        console.clearScreen();
        console.setForegroundColor(ConsoleColor.green);
        console.writeLine('--- Nombres y Apellidos ---\n');
        console.setForegroundColor(ConsoleColor.white);
        if (nombres.isEmpty) {
          console.writeLine('No hay nombres ingresados.');
        } else {
          for (var i = 0; i < nombres.length; i++) {
            var apellido = i < apellidos.length ? apellidos[i] : '';
            console.writeLine('${nombres[i]} ${apellido}');
          }
        }
        console.writeLine('\nPresiona Enter para regresar al menú.');
        console.readLine();
        break;
      case '4':
        return;
      default:
        console.setForegroundColor(ConsoleColor.red);
        console.writeLine('Opción inválida. Por favor, selecciona una opción válida.');
        console.writeLine('\nPresiona Enter para continuar.');
        console.readLine();
    }
  }
}
