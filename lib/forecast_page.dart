import 'package:flutter/material.dart';
import 'custom_drawer.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  final List<TextEditingController> _controllers = List.generate(11, (index) => TextEditingController());
  final TextEditingController _desiredAverageController = TextEditingController();
  final TextEditingController _averageController = TextEditingController(); // Para el promedio
  final TextEditingController _averagePlusController = TextEditingController(); // Para promedio +0.5
  final TextEditingController _averageMinusController = TextEditingController(); // Para promedio -0.5
  final List<String> _previousValues = List.generate(11, (index) => ''); // Para guardar los valores anteriores
  bool _isManualInput = false;

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(_calculateAverages);
    }
  }

  // Método para calcular el promedio y los ajustes de +0.5 y -0.5
  void _calculateAverages() {
    double sum = 0;
    int count = 0;

    for (var controller in _controllers) {
      if (controller.text.isNotEmpty) {
        sum += double.tryParse(controller.text) ?? 0;
        count++;
      }
    }

    double average = count > 0 ? sum / count : 0;
    _averageController.text = average.toStringAsFixed(2);
    _averagePlusController.text = (average + 0.5).toStringAsFixed(2);
    _averageMinusController.text = (average - 0.5).toStringAsFixed(2);
  }

  // Método para calcular los valores restantes en base al promedio deseado
  void _calculateValues() {
    double? desiredAverage = double.tryParse(_desiredAverageController.text);

    if (desiredAverage != null) {
      double sumManual = 0;
      int countManual = 0;

      // Suma de los valores ingresados manualmente
      for (var controller in _controllers) {
        if (controller.text.isNotEmpty) {
          sumManual += double.tryParse(controller.text) ?? 0;
          countManual++;
        }
      }

      int countRemaining = 11 - countManual;
      if (countRemaining > 0) {
        // Calcular la suma restante y distribuirla entre los campos vacíos
        double sumNeeded = (desiredAverage * 11) - sumManual;
        double valuePerField = sumNeeded / countRemaining;

        for (var controller in _controllers) {
          if (controller.text.isEmpty) {
            controller.text = valuePerField.toStringAsFixed(2);
          }
        }
      }

      // Calcular los promedios después de llenar los valores
      _calculateAverages();
    }
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
    _averageController.dispose();
    _averagePlusController.dispose();
    _averageMinusController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forecast Page - Ajustar Promedio'),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo para el promedio deseado
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
              // Campos para los valores individuales
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
                              labelText: 'Valor ${index + 1}',
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
              // Campos para mostrar los promedios calculados
              Column(
                children: [
                  // Promedio general
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextField(
                            controller: _averageController,
                            enabled: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Promedio',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('Promedio'),
                      ],
                    ),
                  ),
                  // Promedio +0.5
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextField(
                            controller: _averagePlusController,
                            enabled: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Promedio +0.5',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('Promedio +0.5'),
                      ],
                    ),
                  ),
                  // Promedio -0.5
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextField(
                            controller: _averageMinusController,
                            enabled: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Promedio -0.5',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('Promedio -0.5'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Botón para calcular los valores
              ElevatedButton(
                onPressed: _calculateValues,
                child: const Text('Calcular Valores'),
              ),
              const SizedBox(height: 16),
              // Botón para resetear los campos
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
      _averageController.clear();
      _averagePlusController.clear();
      _averageMinusController.clear();
      _isManualInput = false;
      for (var controller in _controllers) {
        controller.clear();
      }
    });
  }
}

