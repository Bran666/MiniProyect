import 'dart:io';
import 'dart:math';
import 'package:dart_console/dart_console.dart';



void main() {

  // Listas para almacenar temas, cantidades de estudiantes por tema, estudiantes y asignaciones.
  List<String> temas = [];
  List<int> cantidades = [];
  List<String> estudiantes = [];
  List<List<String>> asignaciones = [
    [],
    []  
  ];
  List<String> menuPrincipal = [
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

  // Inicialización de un generador de números aleatorios.
  Random random = Random();


  final controlMenuPrincipal = Console();
  int selecMenuPrincipal = 0;
  

  // Bucle principal del menú.
  while (true) {
    // Despliega el menú de opciones.
    
    
    /*print('1. Crear Tema');
    print('2. Editar Tema');
    print('3. Mostrar Temas');
    print('4. Eliminar Tema');
    print('5. Crear Estudiante');
    print('6. Editar Estudiante');
    print('7. Mostrar Estudiantes');
    print('8. Eliminar Estudiante');
    print('9. Asignar Estudiantes a Temas Aleatoriamente');
    print('10. Salir');
    print('Seleccione una opción:');
    int opcion = int.parse(stdin.readLineSync()!);*/

    renderMenuInicial(controlMenuPrincipal, menuPrincipal, selecMenuPrincipal);//renderiza el menu principal
    final leerMenuPrincipal = controlMenuPrincipal.readKey(); // Lee la tecla presionada
    
    // Maneja la navegación con las flechas del teclado
    if (leerMenuPrincipal.controlChar == ControlCharacter.arrowUp) {
      selecMenuPrincipal = (selecMenuPrincipal - 1) % menuPrincipal.length; // Navega hacia arriba
      if (selecMenuPrincipal < 0) selecMenuPrincipal = menuPrincipal.length - 1; // Corrección del índice negativo
    } else if (leerMenuPrincipal.controlChar == ControlCharacter.arrowDown) {
      selecMenuPrincipal = (selecMenuPrincipal + 1) % menuPrincipal.length; // Navega hacia abajo
    } else if (leerMenuPrincipal.controlChar == ControlCharacter.enter) {
      // Maneja la selección de la opción
      controlMenuPrincipal.clearScreen(); // Limpia la pantalla
      controlMenuPrincipal.writeLine('Seleccionaste: ${menuPrincipal[selecMenuPrincipal]}'); // Muestra la opción seleccionada
      controlMenuPrincipal.writeLine('Presiona cualquier tecla para continuar...');
      controlMenuPrincipal.readKey(); // Espera a que el usuario presione una tecla para continuar
      if (selecMenuPrincipal == menuPrincipal.length - 1) {
        break; // Salir del menú si se selecciona "Salir"
      }
    

    
      // Manejo de las opciones del menú.
      switch (selecMenuPrincipal) {
        case 0:
          // Crear un nuevo tema.
          controlMenuPrincipal.writeLine('Ingrese el nombre del tema:');
          String nombre = controlMenuPrincipal.readLine()!;

          controlMenuPrincipal.writeLine('Ingrese la cantidad de estudiantes para este tema:');
          int cantidad = int.parse(controlMenuPrincipal.readLine()!);

          // Agregar tema y cantidad a las listas correspondientes.
          temas.add(nombre);
          cantidades.add(cantidad);
          asignaciones.add([]);

          controlMenuPrincipal.writeLine('Tema creado exitosamente.');
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
            String nombre = stdin.readLineSync()!;

            estudiantes[indice] = nombre;
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
          asignaciones = [
            [],
            []
          ];
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
          return;

        default:
          print('Opción inválida.');
          break;
      }
    } else if (leerMenuPrincipal.controlChar == ControlCharacter.ctrlC) {
      break; // Salir del bucle si se presiona Ctrl+C
    }
  }
}



void renderMenuInicial(Console controlMenuInicial, List<String> menuInicial, int selecMenuInicial) {
  //controlMenuInicial.clearScreen(); // Limpia la pantalla de la consola
  controlMenuInicial.writeLine('');
  controlMenuInicial.writeLine('');
  controlMenuInicial.setForegroundColor(ConsoleColor.blue); // Establece el color del texto
  controlMenuInicial.writeLine('Usa las flechas del teclado para navegar y Enter para seleccionar.\n');
  controlMenuInicial.resetColorAttributes(); // Resetea los atributos de color
  controlMenuInicial.writeLine('menu:');

  // Itera sobre las opciones y las muestra en la consola
  for (int i = 0; i < menuInicial.length; i++) {
    if (i == selecMenuInicial) {
      controlMenuInicial.setForegroundColor(ConsoleColor.white); // Color del texto seleccionado
      controlMenuInicial.setBackgroundColor(ConsoleColor.blue); // Color de fondo de la opción seleccionada
      controlMenuInicial.write('➜  ');
      controlMenuInicial.writeLine(menuInicial[i]); // Escribe la opción seleccionada
      controlMenuInicial.resetColorAttributes(); // Resetea los atributos de color
    } else {
      controlMenuInicial.writeLine(menuInicial[i]); // Escribe las opciones no seleccionadas
    }
  }

}

