import 'package:dart_console/dart_console.dart';
import 'dart:io';
import 'dart:math';

void main() {
  List<String> temas = [];
  List<int> cantidades = [];
  List<String> estudiantes = [];
  List<String> estudiantesPre = ["Mateo Arredondo","Brandon Restrepo","Geraldine Vasquez","Carlos Duque","Mario","Miguel Angel",];
  List<List<String>> asignaciones = [];
  Random random = Random();

  List<ConsoleColor> colors = [
    ConsoleColor.blue,
    ConsoleColor.green,
    ConsoleColor.cyan,
    ConsoleColor.magenta,
    ConsoleColor.yellow,
    ConsoleColor.white,
  ];

  while (true) {
    final console = Console();
    console.clearScreen();
    console.setBackgroundColor(ConsoleColor.blue);
    console.writeLine('Menu', TextAlignment.center);
    console.resetColorAttributes();
    console.writeLine();

    int selectedIndex = 0;

    List<String> menu = [
      '1. Crear Tema',
      '2. Editar Tema',
      '3. Mostrar Temas',
      '4. Eliminar Tema',
      '5. Crear Estudiante',
      '6. Editar Estudiante',
      '7. Mostrar Estudiantes',
      '8. Eliminar Estudiante',
      '9. Asignar Estudiantes a Temas Aleatoriamente',
      '10. Asignar Estudiantes a Temas Aleatoriamente Ya Definidos',
      '11. Salir'
    ];

    void printMenu() {
      for (int i = 0; i < menu.length; i++) {
        if (i == selectedIndex) {
          console.setBackgroundColor(i == menu.length - 1 ? ConsoleColor.red: colors[random.nextInt(colors.length)]);
          console.writeLine('-> ${menu[i]}');
          console.resetColorAttributes();
        } else {
          console.writeLine('   ${menu[i]}');
        }
      }
    }

    printMenu();
    console.rawMode = true;

    // Bucle para manejar la entrada de teclado.
    bool inMenu = true;
    while (inMenu) {
      var key = console.readKey();

      if (key.controlChar != -1) {
        switch (key.controlChar) {
          case ControlCharacter.arrowUp:
            selectedIndex = (selectedIndex - 1) % menu.length;
            if (selectedIndex < 0) selectedIndex += menu.length;
            break;

          case ControlCharacter.arrowDown:
            selectedIndex = (selectedIndex + 1) % menu.length;
            break;

          case ControlCharacter.enter:
            console.rawMode = false;
            handleMenuSelection(selectedIndex, temas, cantidades, estudiantes, estudiantesPre, asignaciones, random);
            console.writeLine('Presione Enter para continuar.');
            stdin.readLineSync();
            inMenu = false;
            break;

          case ControlCharacter.escape:
            console.clearScreen();
            console.writeLine('Saliendo del programa...');
            return;

          default:
            break;
        }
        console.clearScreen();
        console.setBackgroundColor(ConsoleColor.blue);
        console.writeLine('Menu', TextAlignment.center);
        console.resetColorAttributes();
        console.writeLine();
        printMenu();
      }
    }
  }
}

void handleMenuSelection(int index, List<String> temas, List<int> cantidades, List<String> estudiantes,List<String>estudiantesPre, List<List<String>> asignaciones, Random random) {
  final console = Console();
  switch (index) {
    case 0:
      crearTema(console, temas, cantidades, asignaciones);
      break;
    case 1:
      editarTema(console, temas, cantidades, asignaciones);
      break;
    case 2:
      mostrarTemas(console, temas, cantidades);
      break;
    case 3:
      eliminarTema(console, temas, cantidades, asignaciones);
      break;
    case 4:
      crearEstudiante(console, estudiantes);
      break;
    case 5:
      editarEstudiante(console, estudiantes);
      break;
    case 6:
      mostrarEstudiantes(console, estudiantes);
      break;
    case 7:
      eliminarEstudiante(console, estudiantes);
      break;
    case 8:
      asignarEstudiantes(console, temas, cantidades, estudiantes, asignaciones, random);
      break;
    case 9:
      asignarEstudiantesPre(console, temas, cantidades, estudiantesPre, asignaciones, random);
      break;
    case 10:
      console.clearScreen();
      console.setForegroundExtendedColor(88);
      console.writeLine('Saliendo del programa');
      console.resetColorAttributes();
      exit(0);
    default:
      console.clearScreen();
      console.setForegroundExtendedColor(88);
      console.writeLine('Opción inválida');
      console.resetColorAttributes();
      break;
  }
}

void crearTema(Console console, List<String> temas, List<int> cantidades, List<List<String>> asignaciones) {
  console.clearScreen();
  console.setBackgroundExtendedColor(195);
  console.setForegroundExtendedColor(63);
  console.writeLine('Ingrese el nombre del tema:');
  console.resetColorAttributes();
  String nombre = console.readLine()!;

  console.setForegroundExtendedColor(162);
  console.writeLine('Ingrese la cantidad de estudiantes para este tema:');
  console.resetColorAttributes();
  int cantidad = int.parse(console.readLine()!);

  temas.add(nombre);
  cantidades.add(cantidad);
  asignaciones.add([]);

  console.setForegroundExtendedColor(78);
  console.writeLine('Tema creado exitosamente.');
  console.resetColorAttributes();

}

void editarTema(Console console, List<String> temas, List<int> cantidades, List<List<String>> asignaciones) {
  console.clearScreen();
  for (int i = 0; i < temas.length; i++) {
    console.writeLine('$i. ${temas[i]} - ${cantidades[i]} estudiantes');
  }
  console.setForegroundExtendedColor(81);
  console.writeLine('Ingrese el índice del tema a editar:');
  console.resetColorAttributes();
  int indice = int.parse(console.readLine()!);

  if (indice >= 0 && indice < temas.length) {
    console.setForegroundExtendedColor(117);
    console.writeLine('Ingrese el nuevo nombre del tema:');
    console.resetColorAttributes();
    String nuevoNombre = console.readLine()!;

    console.setForegroundExtendedColor(116);
    console.writeLine('Ingrese la nueva cantidad de estudiantes para este tema:');
    console.resetColorAttributes();
    int nuevaCantidad = int.parse(console.readLine()!);

    temas[indice] = nuevoNombre;
    cantidades[indice] = nuevaCantidad;
    asignaciones[indice] = [];
    console.setForegroundExtendedColor(78);
    console.writeLine('Tema editado exitosamente.');
    console.resetColorAttributes();
  } else {
    console.setForegroundExtendedColor(88);
    console.writeLine('Índice inválido.');
    console.resetColorAttributes();
  }
}

void mostrarTemas(Console console, List<String> temas, List<int> cantidades) {
  console.clearScreen();
  for (int i = 0; i < temas.length; i++) {
    console.writeLine('$i. ${temas[i]} - ${cantidades[i]} estudiantes');
  }
}

void eliminarTema(Console console, List<String> temas, List<int> cantidades, List<List<String>> asignaciones) {
  console.clearScreen();

  for (int i = 0; i < temas.length; i++) {
    console.writeLine('$i. ${temas[i]} - ${cantidades[i]} estudiantes');
  }

  console.setForegroundExtendedColor(52);
  console.writeLine('Ingrese el índice del tema a eliminar:');
  console.resetColorAttributes();
  int indice = int.parse(console.readLine()!);

  if (indice >= 0 && indice < temas.length) {
    temas.removeAt(indice);
    cantidades.removeAt(indice);
    asignaciones.removeAt(indice);

    console.setForegroundExtendedColor(88);
    console.writeLine('Tema eliminado exitosamente.');
    console.resetColorAttributes();
  } else {
    console.setForegroundExtendedColor(88);
    console.writeLine('Índice inválido.');
    console.resetColorAttributes();
  }
}

void crearEstudiante(Console console, List<String> estudiantes) {
  console.clearScreen();
  console.setForegroundExtendedColor(33);
  console.writeLine('Ingrese el nombre del estudiante:');
  console.resetColorAttributes();
  String nombre = console.readLine()!;

  estudiantes.add(nombre);
  console.setForegroundExtendedColor(78);
  console.writeLine('Estudiante creado exitosamente.');
  console.resetColorAttributes();
}

void editarEstudiante(Console console, List<String> estudiantes) {
  console.clearScreen();
  for (int i = 0; i < estudiantes.length; i++) {
    console.writeLine('$i. ${estudiantes[i]}');
  }
  console.setForegroundExtendedColor(122);
  console.writeLine('Ingrese el índice del estudiante a editar:');
  console.resetColorAttributes();
  int indice = int.parse(console.readLine()!);

  if (indice >= 0 && indice < estudiantes.length) {
    console.setForegroundExtendedColor(87);
    console.writeLine('Ingrese el nuevo nombre del estudiante:');
    console.resetColorAttributes();
    String nuevoNombre = console.readLine()!;

    estudiantes[indice] = nuevoNombre;
    console.setForegroundExtendedColor(78);
    console.writeLine('Estudiante editado exitosamente.');
    console.resetColorAttributes();
  } else {
    console.setForegroundExtendedColor(88);
    console.writeLine('Índice inválido.');
    console.resetColorAttributes();
  }
}

void mostrarEstudiantes(Console console, List<String> estudiantes) {
  console.clearScreen();
  for (int i = 0; i < estudiantes.length; i++) {
    console.writeLine('$i. ${estudiantes[i]}');
  }
}

void eliminarEstudiante(Console console, List<String> estudiantes) {
  console.clearScreen();
  for (int i = 0; i < estudiantes.length; i++) {
    console.writeLine('$i. ${estudiantes[i]}');
  }
  console.setForegroundExtendedColor(93);
  console.writeLine('Ingrese el índice del estudiante a eliminar:');
  console.resetColorAttributes();
  int indice = int.parse(console.readLine()!);

  if (indice >= 0 && indice < estudiantes.length) {
    estudiantes.removeAt(indice);
    console.setForegroundExtendedColor(78);
    console.writeLine('Estudiante eliminado exitosamente.');
    console.resetColorAttributes();
  } else {
    console.setForegroundExtendedColor(88);
    console.writeLine('Índice inválido.');
    console.resetColorAttributes();
  }
}

void asignarEstudiantes(Console console, List<String> temas, List<int> cantidades, List<String> estudiantes, List<List<String>> asignaciones, Random random) {
  console.clearScreen();
  for (int i = 0; i < asignaciones.length; i++) {
    asignaciones[i].clear();
  }
  List<String> estudiantesDisponibles = List.from(estudiantes);

  for (int i = 0; i < temas.length; i++) {
    for (int j = 0; j < cantidades[i]; j++) {
      if (estudiantesDisponibles.isNotEmpty) {
        int indiceAleatorio = (random.nextDouble() * estudiantesDisponibles.length).toInt();
        asignaciones[i].add(estudiantesDisponibles[indiceAleatorio]);
        estudiantesDisponibles.removeAt(indiceAleatorio);
      } else {
        console.setForegroundExtendedColor(88);
        console.writeLine('No hay suficientes estudiantes para asignar a todos los temas.');
        console.resetColorAttributes();
        break;
      }
    }
  }

  console.setForegroundExtendedColor(76);
  console.writeLine('Asignaciones realizadas exitosamente.');
  console.resetColorAttributes();

  for (int i = 0; i < asignaciones.length; i++) {
    console.writeLine('Tema: ${temas[i]}');
    for (int j = 0; j < asignaciones[i].length; j++) {
      console.writeLine('- ${asignaciones[i][j]}');
    }
  }
}

void asignarEstudiantesPre(Console console, List<String> temas, List<int> cantidades, List<String> estudiantes, List<List<String>> asignaciones, Random random) {
  console.clearScreen();
  for (int i = 0; i < asignaciones.length; i++) {
    asignaciones[i].clear();
  }
  List<String> estudiantesDisponibles = List.from(estudiantes);

  for (int i = 0; i < temas.length; i++) {
    for (int j = 0; j < cantidades[i]; j++) {
      if (estudiantesDisponibles.isNotEmpty) {
        int indiceAleatorio = (random.nextDouble() * estudiantesDisponibles.length).toInt();
        asignaciones[i].add(estudiantesDisponibles[indiceAleatorio]);
        estudiantesDisponibles.removeAt(indiceAleatorio);
      } else {
        console.setForegroundExtendedColor(88);
        console.writeLine('No hay suficientes estudiantes para asignar a todos los temas.');
        console.resetColorAttributes();
        break;
      }
    }
  }

  console.setForegroundExtendedColor(76);
  console.writeLine('Asignaciones realizadas exitosamente.');
  console.resetColorAttributes();

  for (int i = 0; i < asignaciones.length; i++) {
    console.writeLine('Tema: ${temas[i]}');
    for (int j = 0; j < asignaciones[i].length; j++) {
      console.writeLine('- ${asignaciones[i][j]}');
    }
  }
}