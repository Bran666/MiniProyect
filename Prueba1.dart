import 'package:dart_console/dart_console.dart';
import 'dart:io';
import 'dart:math';

void main() {
  // Listas para almacenar temas, cantidades de estudiantes por tema, estudiantes y asignaciones.
  List<String> temas = [];
  List<int> cantidades = [];
  List<String> estudiantes = [];
  List<List<String>> asignaciones = [[], []];

  // Inicialización de un generador de números aleatorios.
  Random random = Random();

  List<ConsoleColor> colors = [
    ConsoleColor.blue,
    ConsoleColor.green,
    ConsoleColor.cyan,
    ConsoleColor.magenta,
    ConsoleColor.yellow,
    ConsoleColor.white,
  ];


  // Bucle principal del menú.
  while (true) {
    // Despliega el menú de opciones.
    final console = Console();
    console.setBackgroundColor(ConsoleColor.blue);
    console.writeLine('Menu', TextAlignment.center);
    console.resetColorAttributes();
    console.writeLine();

    int selectedIndex = 0;

    console.clearScreen();

    List<String> Menu = [
      '1. Crear Tema',
      '2. Editar Tema',
      '3. Mostrar Temas',
      '5. Crear Estudiante',
      '6. Editar Estudiante',
      '7. Mostrar Estudiantes',
      '8. Eliminar Estudiante',
      '9. Asignar Estudiantes a Temas Aleatoriamente',
      '10. Salir'
    ];

    void printMenu() {
      for (int i = 0; i < Menu.length; i++) {
        if (i == selectedIndex) {
          if (i == Menu.length - 1) {
            console.setBackgroundColor(ConsoleColor.red);
          } else {
            console.setBackgroundColor(colors[random.nextInt(colors.length)]);
          }
          console.writeLine('>> ${Menu[i]}');
          console.resetColorAttributes();
        } else {
          console.writeLine('   ${Menu[i]}');
        }
      }
      console.cursorDown();
    }

    printMenu();
    console.rawMode = true;
    // Bucle para manejar la entrada de teclado
    while (true) {
      var key = console.readKey();

      if (key.controlChar != Null) {
        switch (key.controlChar) {
          case ControlCharacter.arrowUp:
            selectedIndex = (selectedIndex - 1) % Menu.length;
            if (selectedIndex < 0) selectedIndex += Menu.length;
            console.clearScreen();
            printMenu();
            console.cursorUp();
            break;
          case ControlCharacter.arrowDown:
            selectedIndex = (selectedIndex + 1) % Menu.length;
            console.clearScreen();
            printMenu();
            console.cursorDown();
            console.newLine;
            console.rawMode = false;
            break;
          case ControlCharacter.enter:
            console.clearScreen();
            handleMenuSelection(selectedIndex, temas, cantidades, estudiantes, asignaciones, random);
            console.writeLine('Presione Enter para continuar.');
            stdin.readLineSync(); // Pausa para que el usuario pueda ver el resultado.
            break;
          case ControlCharacter.escape:
            console.clearScreen();
            console.writeLine('Saliendo del programa...');
            return;
          default:
            break;
        }
      }
    }
  }
}

void handleMenuSelection(int index, List<String> temas, List<int> cantidades, List<String> estudiantes, List<List<String>> asignaciones, Random random) {
  switch (index) {
    case 0:
      // Crear un nuevo tema.
      print('Ingrese el nombre del tema:');
      String nombre = stdin.readLineSync()!;

      print('Ingrese la cantidad de estudiantes para este tema:');
      int cantidad = int.parse(stdin.readLineSync()!);

      // Agregar tema y cantidad a las listas correspondientes.
      temas.add(nombre);
      cantidades.add(cantidad);
      asignaciones.add([]);

      print('Tema creado exitosamente.');
      break;

    case 1:
      // Editar un tema existente.
      for (int i = 0; i < temas.length; i++) {
        print('$i. ${temas[i]} - ${cantidades[i]} estudiantes');
      }
      print('Ingrese el índice del tema a editar:');
      int indice = int.parse(stdin.readLineSync()!);

      if (indice >= 0 && indice < temas.length) {
        print('Ingrese el nuevo nombre del tema:');
        String nuevoNombre = stdin.readLineSync()!;

        print('Ingrese la nueva cantidad de estudiantes para este tema:');
        int nuevaCantidad = int.parse(stdin.readLineSync()!);

        // Actualizar el tema y la cantidad.
        temas[indice] = nuevoNombre;
        cantidades[indice] = nuevaCantidad;
        asignaciones[indice] = [];
        print('Tema editado exitosamente.');
      } else {
        print('Índice inválido.');
      }
      break;

    case 2:
      // Mostrar todos los temas y sus cantidades.
      for (int i = 0; i < temas.length; i++) {
        print('$i. ${temas[i]} - ${cantidades[i]} estudiantes');
      }
      break;

    case 3:
      // Eliminar un tema existente.
      for (int i = 0; i < temas.length; i++) {
        print('$i. ${temas[i]} - ${cantidades[i]} estudiantes');
      }
      print('Ingrese el índice del tema a eliminar:');
      int indice = int.parse(stdin.readLineSync()!);

      if (indice >= 0 && indice < temas.length) {
        temas.removeAt(indice);
        cantidades.removeAt(indice);
        asignaciones.removeAt(indice);

        print('Tema eliminado exitosamente.');
      } else {
        print('Índice inválido.');
      }
      break;

    case 4:
      // Crear un nuevo estudiante.
      print('Ingrese el nombre del estudiante:');
      String nombre = stdin.readLineSync()!;

      estudiantes.add(nombre);
      print('Estudiante creado exitosamente.');
      break;

    case 5:
      // Editar un estudiante existente.
      for (int i = 0; i < estudiantes.length; i++) {
        print('$i. ${estudiantes[i]}');
      }
      print('Ingrese el índice del estudiante a editar:');
      int indice = int.parse(stdin.readLineSync()!);

      if (indice >= 0 && indice < estudiantes.length) {
        print('Ingrese el nuevo nombre del estudiante:');
        String nuevoNombre = stdin.readLineSync()!;

        estudiantes[indice] = nuevoNombre;
        print('Estudiante editado exitosamente.');
      } else {
        print('Índice inválido.');
      }
      break;

    case 6:
      // Mostrar todos los estudiantes.
      for (int i = 0; i < estudiantes.length; i++) {
        print('$i. ${estudiantes[i]}');
      }
      break;

    case 7:
      // Eliminar un estudiante existente.
      for (int i = 0; i < estudiantes.length; i++) {
        print('$i. ${estudiantes[i]}');
      }
      print('Ingrese el índice del estudiante a eliminar:');
      int indice = int.parse(stdin.readLineSync()!);

      if (indice >= 0 && indice < estudiantes.length) {
        estudiantes.removeAt(indice);
        print('Estudiante eliminado exitosamente.');
      } else {
        print('Índice inválido.');
      }
      break;

    case 8:
      // Asignar estudiantes a temas aleatoriamente.
      asignaciones = [[], []];
      List<String> estudiantesDisponibles = List.from(estudiantes);

      for (int i = 0; i < temas.length; i++) {
        for (int j = 0; j < cantidades[i]; j++) {
          if (estudiantesDisponibles.isNotEmpty) {
            int indiceAleatorio = (random.nextDouble() * estudiantesDisponibles.length).toInt();
            asignaciones[i].add(estudiantesDisponibles[indiceAleatorio]);
            estudiantesDisponibles.removeAt(indiceAleatorio);
          } else {
            print('No hay suficientes estudiantes para asignar a todos los temas.');
            break;
          }
        }
      }
      print('Asignaciones realizadas exitosamente.');
      for (int i = 0; i < asignaciones.length; i++) {
        print('Tema: ${temas[i]}');
        for (int j = 0; j < asignaciones[i].length; j++) {
          print('- ${asignaciones[i][j]}');
        }
      }
      break;

    case 9:
      print('Saliendo del programa...');
      exit(0);

    default:
      print('Opción inválida.');
      break;
  }
}

