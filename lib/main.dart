// Flutter main UI file for Gfgril app
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      title: 'GFGRIL',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF2E7D32), // Основной зеленый
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF2E7D32), // Основной
          secondary: Color(0xFFF57C00), // Акцентный оранжевый
          tertiary: Color(0xFF5D4037), // Дополнительный коричневый
          surface: Colors.white,
          background: Color(0xFFF5F5F5),
        ),
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white.withOpacity(0.1), // Полупрозрачный AppBar
          foregroundColor: const Color(0xFF2E7D32),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            color: Color(0xFF2E7D32),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white.withOpacity(0.1),
          selectedItemColor: const Color(0xFF2E7D32),
          unselectedItemColor: Colors.grey,
          elevation: 0,
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const RecipesScreen(),
    const SupportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ✅ Градиентный фон с эффектом глубины
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.background,
                Theme.of(context).colorScheme.background.withOpacity(0.9),
                Theme.of(context).colorScheme.surface.withOpacity(0.8),
              ],
            ),
          ),
        ),

        // ✅ Стеклянный эффект с размытием
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            color: Colors.white.withOpacity(0.1),
          ),
        ),

        Scaffold(
          backgroundColor: Colors.transparent,
          body: _screens[_currentIndex],
          bottomNavigationBar: GlassMorphism(
            blur: 20,
            opacity: 0.1,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/home-svgrepo-com.svg',
                      width: 24,
                      height: 24,
                      color: _currentIndex == 0 
                          ? const Color(0xFF2E7D32)
                          : Colors.grey,
                    ),
                    label: 'Главная',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/fork_knife.svg',
                      width: 24,
                      height: 24,
                      color: _currentIndex == 1 
                          ? const Color(0xFF2E7D32)
                          : Colors.grey,
                    ),
                    label: 'Рецепты',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/person.svg',
                      width: 24,
                      height: 24,
                      color: _currentIndex == 2 
                          ? const Color(0xFF2E7D32)
                          : Colors.grey,
                    ),
                    label: 'Поддержка',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Главная'),
        backgroundColor: Colors.transparent,
        flexibleSpace: GlassMorphism(
          blur: 20,
          opacity: 0.1,
          child: Container(),
        ),
        actions: [
          GlassIconButton(
            icon: Icons.settings_outlined,
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Заголовок "Устройства"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              'Устройства',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: colorScheme.tertiary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Карточки устройств
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlassDeviceCard(
                name: 'Комбайн мультиварка GF-KP95',
                status: 'Подключено',
                imagePath: 'assets/images/r.jpg',
                isActive: true,
              ),
              GlassDeviceCard(
                name: 'Аэрогриль GFA-9000',
                status: 'Неактивно',
                imagePath: 'assets/images/7634886526.jpg',
                isActive: false,
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Быстрый доступ к рецептам
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Популярные рецепты',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.tertiary,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Навигация к экрану рецептов
                  },
                  child: Text(
                    'Все рецепты',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Два популярных рецепта на главной
          GlassRecipeCard(
            title: 'Крем-суп из тыквы',
            description: '15 мин · 3 шага',
            imagePath: 'assets/images/ZJTC8FrEMdNCsLmJrNdzCA.jpg',
            color: colorScheme.secondary.withOpacity(0.1),
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
        ],
      ),
    );
  }
}

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Рецепты'),
        backgroundColor: Colors.transparent,
        flexibleSpace: GlassMorphism(
          blur: 20,
          opacity: 0.1,
          child: Container(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Поиск и фильтры
          GlassMorphism(
            blur: 10,
            opacity: 0.2,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Поиск рецептов...',
                prefixIcon: const Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Список рецептов
          GlassRecipeCard(
            title: 'Крем-суп из тыквы',
            description: '15 мин · 3 шага',
            imagePath: 'assets/images/ZJTC8FrEMdNCsLmJrNdzCA.jpg',
            color: colorScheme.secondary.withOpacity(0.1),
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
          GlassRecipeCard(
            title: 'Овсянка с ягодами',
            description: '10 мин · 2 шага',
            imagePath: 'assets/images/nutritious-overnight-oatmeal-with-mixed-berries-p0ubg77ox7m6h6iv.jpg',
            color: colorScheme.primary.withOpacity(0.1),
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
          GlassRecipeCard(
            title: 'Смузи из банана',
            description: '5 мин · 1 шаг',
            imagePath: 'assets/images/smoothie.jpg',
            color: colorScheme.secondary.withOpacity(0.1),
            onTap: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RecipeDetailScreen(
                    title: 'Смузи из банана',
                    steps: [
                      'Смешайте все ингредиенты в блендере',
                      'Взбивайте до однородной консистенции',
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Поддержка'),
        backgroundColor: Colors.transparent,
        flexibleSpace: GlassMorphism(
          blur: 20,
          opacity: 0.1,
          child: Container(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Контактная информация
          GlassMorphism(
            blur: 15,
            opacity: 0.2,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(
                    Icons.support_agent,
                    size: 64,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Служба поддержки',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Мы всегда готовы помочь вам',
                    style: TextStyle(
                      color: colorScheme.tertiary.withOpacity(0.6),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Способы связи
          GlassMorphism(
            blur: 15,
            opacity: 0.2,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Свяжитесь с нами',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildContactItem(
                    context,
                    Icons.phone,
                    'Телефон',
                    '+7 (999) 123-45-67',
                    colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  _buildContactItem(
                    context,
                    Icons.email,
                    'Email',
                    'support@gfgril.com',
                    colorScheme.secondary,
                  ),
                  const SizedBox(height: 12),
                  _buildContactItem(
                    context,
                    Icons.chat,
                    'Онлайн-чат',
                    'Круглосуточно',
                    colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(BuildContext context, IconData icon, String title, String subtitle, Color color) {
    return ListTile(
      leading: GlassMorphism(
        blur: 8,
        opacity: 0.3,
        child: Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle),
      onTap: () {
        // Действие при нажатии
      },
    );
  }
}

// ✅ Компонент для стеклянного эффекта
class GlassMorphism extends StatelessWidget {
  final double blur;
  final double opacity;
  final Widget child;

  const GlassMorphism({
    super.key,
    required this.blur,
    required this.opacity,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ✅ Стеклянная карточка устройства
class GlassDeviceCard extends StatelessWidget {
  final String name;
  final String status;
  final String imagePath;
  final bool isActive;

  const GlassDeviceCard({
    super.key,
    required this.name,
    required this.status,
    required this.imagePath,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GlassMorphism(
      blur: 15,
      opacity: 0.2,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.42,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Изображение устройства
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: isActive 
                    ? colorScheme.primary.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imagePath,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.kitchen,
                      size: 50,
                      color: isActive ? colorScheme.primary : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Информация об устройстве
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 6),
            GlassMorphism(
              blur: 10,
              opacity: 0.3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isActive ? colorScheme.primary : Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Стеклянная карточка рецепта
class GlassRecipeCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final Color color;
  final Function(BuildContext) onTap;

  const GlassRecipeCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => onTap(context),
      child: GlassMorphism(
        blur: 15,
        opacity: 0.2,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Изображение рецепта
              GlassMorphism(
                blur: 10,
                opacity: 0.3,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      imagePath,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.restaurant_menu,
                        size: 30,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Информация о рецепте
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: TextStyle(
                        color: colorScheme.tertiary.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Стрелка
              GlassMorphism(
                blur: 8,
                opacity: 0.3,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: colorScheme.tertiary.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ✅ Стеклянная кнопка с иконкой
class GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const GlassIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GlassMorphism(
        blur: 10,
        opacity: 0.2,
        child: IconButton(
          icon: Icon(icon),
          color: colorScheme.tertiary,
          onPressed: onPressed,
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        flexibleSpace: GlassMorphism(
          blur: 20,
          opacity: 0.1,
          child: Container(),
        ),
        foregroundColor: colorScheme.primary,
      ),
      body: Stack(
        children: [
          // Фон с размытием
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.background,
                  colorScheme.background.withOpacity(0.9),
                  colorScheme.surface.withOpacity(0.8),
                ],
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(color: Colors.white.withOpacity(0.1)),
            ),
          ),

          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: steps.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: GlassMorphism(
                  blur: 15,
                  opacity: 0.2,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Номер шага
                        GlassMorphism(
                          blur: 8,
                          opacity: 0.3,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: colorScheme.primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            steps[index],
                            style: TextStyle(
                              fontSize: 16,
                              color: colorScheme.tertiary,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}