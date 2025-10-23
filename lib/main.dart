// Flutter main UI file for Gfgril app
import 'package:flutter/material.dart';
import 'dart:ui';

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
        scaffoldBackgroundColor: Colors.transparent,
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
    return Stack(
      children: [
        // ✅ Размытый фон / градиент в стиле Apple Home
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF8EBD5),
                Color(0xFFEAE2C6),
                Color(0xFFD2D9C7),
              ],
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(color: Colors.white.withOpacity(0.05)),
          ),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
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
                children: [
                  DeviceCard(
                    name: 'Комбайн',
                    status: 'Подключено',
                    imageUrl: 'https://app-v3.bnbhost.ru/r.jpg',
                  ),
                  DeviceCard(
                    name: 'Блендер',
                    status: 'Неактивно',
                    imageUrl: 'https://app-v3.bnbhost.ru/m.jpg',
                  ),
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
                imageUrl:
                    'https://cdn.mos.cms.futurecdn.net/ZJTC8FrEMdNCsLmJrNdzCA.jpg',
                onTap: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RecipeDetailScreen(
                        title: 'Крем-суп из тыквы',
                        steps: [
                          'Нарежьте тыкву и обжарьте в мультиварке',
                          'Добавьте воду, соль и специи',
                          'Измельчите блендером до однородности',
                        ],
                      ),
                    ),
                  );
                },
              ),
              RecipeCard(
                title: 'Овсянка с ягодами',
                description: '10 мин · 2 шага',
                imageUrl:
                    'https://wallpapers.com/images/hd/nutritious-overnight-oatmeal-with-mixed-berries-p0ubg77ox7m6h6iv.jpg',
                onTap: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RecipeDetailScreen(
                        title: 'Овсянка с ягодами',
                        steps: [
                          'Залейте овсянку молоком и разогрейте',
                          'Добавьте ягоды и мёд по вкусу',
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DeviceCard extends StatelessWidget {
  final String name;
  final String status;
  final String imageUrl;

  const DeviceCard(
      {super.key,
      required this.name,
      required this.status,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.kitchen,
                size: 80,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
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
  final String imageUrl;
  final Function(BuildContext) onTap;

  const RecipeCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
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
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_not_supported,
                  size: 60,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
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
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class RecipeDetailScreen extends StatelessWidget {
  final String title;
  final List<String> steps;

  const RecipeDetailScreen({super.key, required this.title, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: steps.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              'Шаг ${index + 1}: ${steps[index]}',
              style: const TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}