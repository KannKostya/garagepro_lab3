import 'package:flutter/material.dart';
import 'home/garage_screen.dart';
import 'home/add_car_screen.dart';
import 'home/service_screen.dart';
import 'profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({
    super.key,
    this.initialIndex = 0,
  });

  static _MainScreenState? of(BuildContext context) {
    return context.findAncestorStateOfType<_MainScreenState>();
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  final GlobalKey<NavigatorState>
  _garageNavigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState>
  _serviceNavigatorKey = GlobalKey<NavigatorState>();

  bool _isOpenedFromButton = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void navigateToServiceWithScreen(Widget screen) {
    setState(() {
      _currentIndex = 1;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _serviceNavigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => screen),
      );
    });
  }
  
  void navigateToGarageWithScreen(Widget screen) {
    setState(() {
      _currentIndex = 0;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _garageNavigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => screen),
      );
    });
  }
  
  void setIndex(int index) {
    setState(() {
      _currentIndex = index;
      _isOpenedFromButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, resutl) async{
        if (_currentIndex == 0 &&
            _garageNavigatorKey.currentState != null &&
            _garageNavigatorKey.currentState!.canPop()) {
          _garageNavigatorKey.currentState!.pop();
        } else if (_currentIndex == 1 &&
            _serviceNavigatorKey.currentState != null &&
            _serviceNavigatorKey.currentState!.canPop()) {
          _serviceNavigatorKey.currentState!.pop();
          setState(() {
            _currentIndex = 0;
          });
        }
      },

      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            Navigator(
              key: _garageNavigatorKey,
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  builder: (context) => const GarageScreen(),
                );
              },
            ),
            Navigator(
              key: _serviceNavigatorKey,
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  builder:(context) => 
                  ServiceScreen(showBackButton: _isOpenedFromButton),
                );
              },
            ),
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
      )
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
        if (index == 1) {
          _serviceNavigatorKey.currentState?.popUntil((route) => route.isFirst);
        }

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