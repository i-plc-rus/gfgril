// Flutter main UI file for Gfgril app
import 'package:flutter/material.dart';

void main() {
  runApp(const GfgrilApp());
}

class GfgrilApp extends StatelessWidget {
  const GfgrilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gfgril Smart Kitchen',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFFF3E5AB),
        scaffoldBackgroundColor: const Color(0xFFFDFCFB),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Моя кухня'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Устройства',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              DeviceCard(name: 'Мультиварка', status: 'Подключено'),
              DeviceCard(name: 'Блендер', status: 'Неактивно'),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Рецепты',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          RecipeCard(
            title: 'Крем-суп из тыквы',
            description: '15 мин · 3 шага',
            onTap: () {},
          ),
          RecipeCard(
            title: 'Овсянка с ягодами',
            description: '10 мин · 2 шага',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  final String name;
  final String status;

  const DeviceCard({super.key, required this.name, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            status,
            style: TextStyle(
              color: status == 'Подключено' ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const RecipeCard({super.key, required this.title, required this.description, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
