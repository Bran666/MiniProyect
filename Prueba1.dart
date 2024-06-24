import 'package:dart_console/dart_console.dart';
import 'dart:io';
import 'dart:math';

void main() {
  // Listas para almacenar temas, cantidades de estudiantes por tema, estudiantes y asignaciones.
  List<String> temas = [];
  List<int> cantidades = [];
  List<String> estudiantes = [];
  List<List<String>> asignaciones = [];

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
    console.clearScreen();
    console.setBackgroundColor(ConsoleColor.blue);
    console.writeLine('Menu', TextAlignment.center);
    console.resetColorAttributes();
    console.writeLine();

    int selectedIndex = 0;

    List<String> Menu = [
      '1. Crear Tema',
      '2. Editar Tema',
      '3. Mostrar Temas',
      '4. Eliminar Tema',
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
          console.writeLine('➜ ${Menu[i]}');
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

      if (key.controlChar != -1) {
        switch (key.controlChar) {
          case ControlCharacter.arrowUp:
            selectedIndex = (selectedIndex - 1) % Menu.length;
            if (selectedIndex < 0) selectedIndex += Menu.length;
            console.clearScreen();
            console.setBackgroundColor(ConsoleColor.blue);
            console.writeLine('Menu', TextAlignment.center);
            console.resetColorAttributes();
            console.writeLine();
            printMenu();
            break;
          case ControlCharacter.arrowDown:
            selectedIndex = (selectedIndex + 1) % Menu.length;
            console.clearScreen();
            console.setBackgroundColor(ConsoleColor.blue);
            console.writeLine('Menu', TextAlignment.center);
            console.resetColorAttributes();
            console.writeLine();
            printMenu();
            break;
          case ControlCharacter.enter:
            console.rawMode = false;
            console.clearScreen();
            handleMenuSelection(selectedIndex, temas, cantidades, estudiantes,
                asignaciones, random);
            console.writeLine('Presione Enter para continuar.');
            stdin
                .readLineSync(); // Pausa para que el usuario pueda ver el resultado.
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

void handleMenuSelection(int index, List<String> temas, List<int> cantidades,
    List<String> estudiantes, List<List<String>> asignaciones, Random random) {
  final console = Console();
  switch (index) {
    case 0:
      // Crear un nuevo tema.
      console.setBackgroundExtendedColor(195);
      console.setForegroundExtendedColor(63);
      print('Ingrese el nombre del tema:');
      console.resetColorAttributes();
      String nombre = console.readLine()!;

      console.setForegroundExtendedColor(162);
      print('Ingrese la cantidad de estudiantes para este tema:');
      console.resetColorAttributes();
      int cantidad = int.parse(console.readLine()!);

      // Agregar tema y cantidad a las listas correspondientes.
      temas.add(nombre);
      cantidades.add(cantidad);
      asignaciones.add([]);

      console.setForegroundExtendedColor(78);
      print('Tema creado exitosamente.');
      console.resetColorAttributes();
      break;

    case 1:
      // Editar un tema existente.
      for (int i = 0; i < temas.length; i++) {
        print('$i. ${temas[i]} - ${cantidades[i]} estudiantes');
      }
      console.setForegroundExtendedColor(81);
      print('Ingrese el índice del tema a editar:');
      console.resetColorAttributes();
      int indice = int.parse(console.readLine()!);

      if (indice >= 0 && indice < temas.length) {
        console.setForegroundExtendedColor(117);
        print('Ingrese el nuevo nombre del tema:');
        console.resetColorAttributes();
        String nuevoNombre = console.readLine()!;

        console.setForegroundExtendedColor(116);
        print('Ingrese la nueva cantidad de estudiantes para este tema:');
        console.resetColorAttributes();
        int nuevaCantidad = int.parse(console.readLine()!);

        // Actualizar el tema y la cantidad.
        temas[indice] = nuevoNombre;
        cantidades[indice] = nuevaCantidad;
        asignaciones[indice] = [];
        console.setForegroundExtendedColor(78);
        print('Tema editado exitosamente.');
        console.resetColorAttributes();
      } else {
        console.setForegroundExtendedColor(88);
        print('Índice inválido.');
        console.resetColorAttributes();
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
      console.setForegroundExtendedColor(52);
      print('Ingrese el índice del tema a eliminar:');
      console.resetColorAttributes();
      int indice = int.parse(console.readLine()!);

      if (indice >= 0 && indice < temas.length) {
        temas.removeAt(indice);
        cantidades.removeAt(indice);
        asignaciones.removeAt(indice);

        console.setForegroundExtendedColor(88);
        print('Tema eliminado exitosamente.');
        console.resetColorAttributes();
      } else {
        print('Índice inválido.');
      }
      break;

    case 4:
      // Crear un nuevo estudiante.
      console.setForegroundExtendedColor(33);
      print('Ingrese el nombre del estudiante:');
      console.resetColorAttributes();
      String nombre = console.readLine()!;

      estudiantes.add(nombre);
      console.setForegroundExtendedColor(78);
      print('Estudiante creado exitosamente.');
      console.resetColorAttributes();
      break;

    case 5:
      // Editar un estudiante existente.
      for (int i = 0; i < estudiantes.length; i++) {
        print('$i. ${estudiantes[i]}');
      }
      console.setForegroundExtendedColor(122);
      print('Ingrese el índice del estudiante a editar:');
      console.resetColorAttributes();
      int indice = int.parse(console.readLine()!);

      if (indice >= 0 && indice < estudiantes.length) {
        console.setForegroundExtendedColor(87);
        print('Ingrese el nuevo nombre del estudiante:');
        console.resetColorAttributes();
        String nuevoNombre = console.readLine()!;

        estudiantes[indice] = nuevoNombre;
        console.setForegroundExtendedColor(78);
        print('Estudiante editado exitosamente.');
        console.resetColorAttributes();
      } else {
        console.setForegroundExtendedColor(88);
        print('Índice inválido.');
        console.resetColorAttributes();
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
      console.setForegroundExtendedColor(93);
      print('Ingrese el índice del estudiante a eliminar:');
      console.resetColorAttributes();
      int indice = int.parse(console.readLine()!);

      if (indice >= 0 && indice < estudiantes.length) {
        estudiantes.removeAt(indice);
        console.setForegroundExtendedColor(78);
        print('Estudiante eliminado exitosamente.');
        console.resetColorAttributes();
      } else {
        console.setForegroundExtendedColor(88);
        print('Índice inválido.');
        console.resetColorAttributes();
      }
      break;

    case 8:
      // Asignar estudiantes a temas aleatoriamente.
      for (int i = 0; i < asignaciones.length; i++) {
        asignaciones[i].clear();
      }
      List<String> estudiantesDisponibles = List.from(estudiantes);

      for (int i = 0; i < temas.length; i++) {
        for (int j = 0; j < cantidades[i]; j++) {
          if (estudiantesDisponibles.isNotEmpty) {
            int indiceAleatorio =
                (random.nextDouble() * estudiantesDisponibles.length).toInt();
            asignaciones[i].add(estudiantesDisponibles[indiceAleatorio]);
            estudiantesDisponibles.removeAt(indiceAleatorio);
          } else {
            console.setForegroundExtendedColor(88);
            print(
                'No hay suficientes estudiantes para asignar a todos los temas.');
            console.resetColorAttributes();
            break;
          }
        }
      }

      console.setForegroundExtendedColor(76);
      print('Asignaciones realizadas exitosamente.');
      console.resetColorAttributes();

      for (int i = 0; i < asignaciones.length; i++) {
        print('Tema: ${temas[i]}');
        for (int j = 0; j < asignaciones[i].length; j++) {
          print('- ${asignaciones[i][j]}');
        }
      }
      break;

    case 9:
      console.setForegroundExtendedColor(88);
      print('Saliendo del programa...');
      console.resetColorAttributes();
      exit(0);

    default:
      console.setForegroundExtendedColor(88);
      print('Opción inválida.');
      console.resetColorAttributes();
      break;
  }
}
