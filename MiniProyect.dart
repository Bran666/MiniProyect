import 'dart:io';
import 'dart:math';

void main() {
  // Listas para almacenar temas, cantidades de estudiantes por tema, estudiantes y asignaciones.
  List<String> temas = [];
  List<int> cantidades = [];
  List<String> estudiantes = [];
  List<List<String>> asignaciones = [
    [],
    []  
  ];

  // Inicialización de un generador de números aleatorios.
  Random random = Random();

  // Bucle principal del menú.
  while (true) {
    // Despliega el menú de opciones.
    print('Menu:');
    print('1. Crear Tema');
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
    int opcion = int.parse(stdin.readLineSync()!);

    // Manejo de las opciones del menú.
    switch (opcion) {
      case 1:
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

      case 2:
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

      case 3:
        // Mostrar todos los temas y sus cantidades.
        for (int i = 0; i < temas.length; i++) {
          print('$i. ${temas[i]} - ${cantidades[i]} estudiantes');
        }
        break;

      case 4:
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

      case 5:
        // Crear un nuevo estudiante.
        print('Ingrese el nombre del estudiante:');
        String nombre = stdin.readLineSync()!;

        estudiantes.add(nombre);
        print('Estudiante creado exitosamente.');
        break;

      case 6:
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

      case 7:
        // Mostrar todos los estudiantes.
        for (int i = 0; i < estudiantes.length; i++) {
          print('$i. ${estudiantes[i]}');
        }
        break;

      case 8:
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

      case 9:
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

      case 10:
        return;

      default:
        print('Opción inválida.');
        break;
    }
  }
}