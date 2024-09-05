import 'package:flutter/material.dart';
import 'custom_drawer.dart';

class PromedioPage extends StatefulWidget {
  const PromedioPage({super.key});

  @override
  State<PromedioPage> createState() => _PromedioPageState();
}

class _PromedioPageState extends State<PromedioPage> {
  final List<TextEditingController> _controllers = List.generate(11, (index) => TextEditingController());
  final TextEditingController _averageController = TextEditingController();
  final TextEditingController _averagePlusController = TextEditingController();
  final TextEditingController _averageMinusController = TextEditingController();
  final List<String> _previousValues = List.generate(11, (index) => ''); // Para guardar los valores anteriores

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(_updateAverage);
    }
  }

  // Actualiza el promedio cuando cambia algún valor
  void _updateAverage() {
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

  // Almacena el valor anterior del TextField en el índice dado
  void _storePreviousValue(int index) {
    _previousValues[index] = _controllers[index].text;
  }

  // Restaura el valor guardado anteriormente en el índice dado
  void _restorePreviousValue(int index) {
    setState(() {
      _controllers[index].text = _previousValues[index];
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.removeListener(_updateAverage);
      controller.dispose();
    }
    _averageController.dispose();
    _averagePlusController.dispose();
    _averageMinusController.dispose();
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campos de entrada para los 11 valores
              Column(
                children: List.generate(11, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        // TextField para ingresar los valores
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
                        // Botón para guardar el valor
                        ElevatedButton(
                          onPressed: () {
                            _storePreviousValue(index);
                          },
                          child: const Text('Guardar'),
                        ),
                        const SizedBox(width: 10),
                        // Botón para restaurar el valor guardado
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
              // Mostrar el promedio calculado
              Row(
                children: [
                  Expanded(
                    flex: 2,
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
              const SizedBox(height: 16),
              // Mostrar el promedio +0.5
              Row(
                children: [
                  Expanded(
                    flex: 2,
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
              const SizedBox(height: 16),
              // Mostrar el promedio -0.5
              Row(
                children: [
                  Expanded(
                    flex: 2,
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
            ],
          ),
        ),
      ),
    );
  }
}
