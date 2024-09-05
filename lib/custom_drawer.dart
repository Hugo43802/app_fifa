import 'package:flutter/material.dart';
import 'home_page.dart';
import 'promedio_page.dart';
import 'forecast_page.dart';

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
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // Opción para ir al Home
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          // Opción para ir a Promedios
          ListTile(
            leading: const Icon(Icons.calculate),
            title: const Text('Promedios'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PromedioPage()),
              );
            },
          ),
          // Opción para ir a Forecast
          ListTile(
            leading: const Icon(Icons.pages),
            title: const Text('Forecast'),
            onTap: () {
              Navigator.pushReplacement(
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

