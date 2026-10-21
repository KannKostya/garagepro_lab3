import 'package:flutter/material.dart';

import 'home/home_screen.dart';
//import 'home/garage_screen.dart'; 
import 'home/add_car_screen.dart';
import 'home/service_screen.dart';
import 'profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex; // Новий параметр зі значенням за замовчуванням

  const MainScreen({
    super.key,
    this.initialIndex = 0, // За замовчуванням відкривається перша вкладка (Garage)
  });

  // Дозволяє дочірнім віджетам викликати MainScreen.of(context)
  static _MainScreenState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MainScreenState>();
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  // Окремий ключ навігації суто для вкладки Garage
  final GlobalKey<NavigatorState>
  _garageNavigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  bool _isOpenedFromButton = false;
  
  void setIndex(int index) {
    setState(() {
      _currentIndex = index;
      _isOpenedFromButton = true; // З нижньої панелі стрілку скидаємо
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Navigator(
            key: _garageNavigatorKey,
            onGenerateRoute: (RouteSettings settings) {
              return MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              );
            },
          ),
          ServiceScreen(showBackButton: _isOpenedFromButton),
          AddCarScreen(showBackButton: _isOpenedFromButton),
          ProfileScreen(showBackButton: _isOpenedFromButton),
        ],
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(4, 0, 0, 0),
              offset: const Offset(0, -1),
              blurRadius: 8,
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                icon: Icons.directions_car_outlined,
                label: 'Garage',
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.build_outlined,
                label: 'Service',
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.add_circle_outline,
                label: 'Add Car',
              ),
              _buildNavItem(
                index: 3,
                icon: Icons.person_outline,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
          _isOpenedFromButton = false;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8EEF3) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? const Color(0xFF0F2439) : const Color(0xFF64748B),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? const Color(0xFF0F2439) : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}