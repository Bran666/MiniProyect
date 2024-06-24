// ignore_for_file: unused_local_variable
import 'dart:io';

void main(List<String> args) {
  List<String> proyectosDisponibles = [];
  List<double> valorProyecto = [];
  List<double> horasTrabajados = [];
  List<double> porcentajeAvanzado = [];
  int i = 1, res;

  while (true) {
    print("""
Ingrese el numero de lo que desea hacer
1.Ingresar proyecto
2.Ver cantidad de proyectos
3.Modifcar horas trabajas
4.Modificar porcentaje de avance
5.Promedio horas trabajadas de todos los proyectos
6.Mostrar proyectos
7.Salir""");
    res = int.parse(stdin.readLineSync()!);

    switch (res) {
      case 1:
        print("Ingrese el nombre del proyecto ${i}");
        proyectosDisponibles.add(stdin.readLineSync()!);

        print("Ingrese el valor total del proyecto ${i}");
        valorProyecto.add(double.parse(stdin.readLineSync()!));

        print("Ingrese las horas que se lleva trabajadas en el proyecto ${i}");
        horasTrabajados.add(double.parse(stdin.readLineSync()!));

        print("Ingrese el porcentaje que avanzo del proyecto ${i}");
        porcentajeAvanzado.add(double.parse(stdin.readLineSync()!));

        print(
            "Ingrese cero si desea salir o un numero diferente para continuar");
        res = int.parse(stdin.readLineSync()!);
        break;

      case 2:
        cantProyectos(proyectosDisponibles);
        break;

      case 3:
        modificarHoras(proyectosDisponibles, horasTrabajados);
        break;

      case 4:
        modificarPorcentaje(proyectosDisponibles, horasTrabajados);
        break;

      case 5:
        promedioHorasProyectos(horasTrabajados);
        break;

      case 6:
        mostrarProyectos(proyectosDisponibles, valorProyecto, horasTrabajados, porcentajeAvanzado);
        break;
    }
  }
}

cantProyectos(List<String> Proyectos) {
  int cantProyectos = Proyectos.length;
  print("La cantidad de proyectos disponibles es: $cantProyectos");

  return cantProyectos;
}

modificarHoras(List<String> Proyectos, List<double> getHoras) {
  for (int i = 0; i < Proyectos.length; i++) {
    print("$i - ${Proyectos[i]}");
  }

  print("Ingrese el indice del proyecto que desea modificar las horas");
  int indice = int.parse(stdin.readLineSync()!);

  print("Ingrese la nueva cantidad de horas");
  double nuevasHoras = double.parse(stdin.readLineSync()!);

  for (int i = 0; i < getHoras.length; i++) {
    if (i == indice) {
      getHoras[i] = nuevasHoras;
      print("Cambio exitoso");
    } else if (i < 0 && i > getHoras.length) {
      print("El dato ingresado no es valido");
    }
  }

  return nuevasHoras;
}

modificarPorcentaje(List<String> Proyectos, List<double> getPorcentaje) {
  for (int i = 0; i < Proyectos.length; i++) {
    print("$i - ${Proyectos[i]}");
  }

  print("Ingrese el indice del proyecto que desea actualizar el porcentaje");
  int indice = int.parse(stdin.readLineSync()!);

  print("Ingrese el porcentaje adicional ha avanzado en el proyecto");
  double sumaPorcentaje = double.parse(stdin.readLineSync()!);

  for (int i = 0; i < getPorcentaje.length; i++) {
    if (i == indice) {
      getPorcentaje[i] += sumaPorcentaje;
      print("Cambio exitoso");
    } else if (i < 0 && i > getPorcentaje.length) {
      print("El dato ingresado no es valido");
    }
  }

  return sumaPorcentaje;
}

void promedioHorasProyectos(List<double> horasProyectos) {
  double sum = 0, promedio;
  for (var i = 0; i < horasProyectos.length; i++) {
    sum += horasProyectos[i];
  }
  promedio = sum / horasProyectos.length;

  print("El promedio de horas de todos los proyectos es: ${promedio}");
}

void mostrarProyectos(List<String> Proyectos, List<double> ValorProyecto,
    List<double> HorasTrabajadas, List<double> PorcentajeAvanzado) {
  for (var i = 0; i < Proyectos.length; i++) {
    print("""
${i + 1}. Nombre: ${Proyectos[i]} 
Valor: ${ValorProyecto[i]}
Horas Invertidas: ${HorasTrabajadas[i]}
Porcentaje avanzado: ${PorcentajeAvanzado[i]}
*********************************************
""");
  }
}
