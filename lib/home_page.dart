import 'package:flutter/material.dart';
import 'custom_drawer.dart';
import 'promedio_page.dart';
import 'forecast_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título de bienvenida
              const Text(
                '¡Bienvenido a AppFC!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Introducción sobre la app
              const Text(
                'Nos alegra tenerte por aquí. En AppFC te ayudamos a manejar promedios de forma fácil y rápida. '
                'Nuestra app cuenta con dos funcionalidades principales que harán que trabajar con promedios sea '
                'más sencillo que nunca. A continuación te explicamos cómo puedes aprovechar cada una.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              // Explicación de la página de Promedios
              const Text(
                '1. Cálculo de Promedios:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'En la sección de "Promedios", puedes ingresar hasta 11 números y nosotros haremos todo el cálculo por ti. '
                'Te mostraremos el promedio de los valores que ingresaste, ¡y además te daremos el promedio con un ajuste '
                'de +0.5 y -0.5 para que tengas toda la información que necesitas!',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              // Explicación de la página de Ajuste de Valores
              const Text(
                '2. Ajuste de Valores según el Promedio:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'En la sección "Forecast", puedes definir un promedio que quieras alcanzar, y te ayudamos a calcular los 11 valores '
                'necesarios para lograrlo. Si cambias algunos valores, no te preocupes, nosotros ajustamos los demás por ti. '
                'Además, puedes guardar los valores originales antes de hacer cualquier cambio y restaurarlos cuando quieras. ¡Así de fácil!',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              // Enlaces directos a las páginas
              const Text(
                'Enlaces directos:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Botón para ir a PromedioPage
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PromedioPage()),
                  );
                },
                child: const Text('Ir a la página de Promedios'),
              ),
              const SizedBox(height: 16),
              // Botón para ir a ForecastPage
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ForecastPage()),
                  );
                },
                child: const Text('Ir a la página de Ajuste de Valores'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 
