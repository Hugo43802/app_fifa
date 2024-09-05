import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

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


class PromedioPage extends StatefulWidget {
  const PromedioPage({super.key});

  @override
  State<PromedioPage> createState() => _PromedioPageState();
}

class _PromedioPageState extends State<PromedioPage> {
  final List<TextEditingController> _controllers = List.generate(10, (index) => TextEditingController());
  final TextEditingController _desiredAverageController = TextEditingController();
  final TextEditingController _lastValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(_updateValues);
    }
    _desiredAverageController.addListener(_updateValues);
  }

  void _updateValues() {
    double sum = 0;
    int count = 0;

    for (var controller in _controllers) {
      if (controller.text.isNotEmpty) {
        sum += double.tryParse(controller.text) ?? 0;
        count++;
      }
    }

    double desiredAverage = double.tryParse(_desiredAverageController.text) ?? 0;
    double lastValue = (desiredAverage * 11) - sum;

    if (count < 10) {
      _lastValueController.text = lastValue.toStringAsFixed(2);
    } else {
      _lastValueController.text = 'N/A';
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.removeListener(_updateValues);
      controller.dispose();
    }
    _desiredAverageController.dispose();
    _lastValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promedio Page'),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _desiredAverageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Promedio Deseado',
                  ),
                ),
              ),
              ...List.generate(10, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _controllers[index],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Jugador ${index + 1}',
                    ),
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _lastValueController,
                        enabled: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Último Valor Necesario',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text('Último Valor Necesario'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  final List<TextEditingController> _controllers = List.generate(11, (index) => TextEditingController());
  final TextEditingController _desiredAverageController = TextEditingController();
  final List<String> _previousValues = List.generate(11, (index) => ''); // Almacenar los valores previos
  bool _isManualInput = false;

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(_onManualInput);
    }
  }

  void _calculateValues() {
    double? desiredAverage = double.tryParse(_desiredAverageController.text);

    if (desiredAverage != null) {
      double sumManual = 0;
      int countManual = 0;

      for (var controller in _controllers) {
        if (controller.text.isNotEmpty) {
          sumManual += double.tryParse(controller.text) ?? 0;
          countManual++;
        }
      }

      int countRemaining = 11 - countManual;

      if (countRemaining > 0) {
        double sumNeeded = (desiredAverage * 11) - sumManual;
        double valuePerField = sumNeeded / countRemaining;

        for (var controller in _controllers) {
          if (controller.text.isEmpty) {
            controller.text = valuePerField.toStringAsFixed(2);
          }
        }
      }
    }
  }

  void _onManualInput() {
    setState(() {
      _isManualInput = true;
    });
  }

  // Método para almacenar el valor anterior de los TextFields
  void _storePreviousValue(int index) {
    _previousValues[index] = _controllers[index].text;
  }

  // Método para restaurar el valor anterior en el TextField
  void _restorePreviousValue(int index) {
    setState(() {
      _controllers[index].text = _previousValues[index];
    });
  }

  @override
  void dispose() {
    _desiredAverageController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forecast - Ajustar Promedio'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _desiredAverageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Promedio Deseado',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: List.generate(11, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        // TextField
                        Expanded(
                          flex: 4,
                          child: TextField(
                            controller: _controllers[index],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Jugador ${index + 1}',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Botón para almacenar el valor actual
                        ElevatedButton(
                          onPressed: () {
                            _storePreviousValue(index);
                          },
                          child: const Text('Guardar'),
                        ),
                        const SizedBox(width: 10),
                        // Botón para restaurar el valor anterior
                        ElevatedButton(
                          onPressed: () {
                            _restorePreviousValue(index);
                          },
                          child: const Text('Restaurar'),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _calculateValues();
                  setState(() {}); // Actualizar la UI después de calcular los valores
                },
                child: const Text('Calcular Valores'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _resetFields,
                child: const Text('Resetear Campos'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resetFields() {
    setState(() {
      _desiredAverageController.clear();
      _isManualInput = false;
      for (var controller in _controllers) {
        controller.clear();
      }
    });
  }
}



class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              'Menú de Navegación',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.calculate),
            title: const Text('Promedio'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PromedioPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.pages),
            title: const Text('Forecast'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForecastPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
