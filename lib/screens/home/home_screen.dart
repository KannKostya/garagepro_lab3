import 'package:flutter/material.dart';
import 'package:garagepro/screens/home/add_record_screen.dart';
import 'package:garagepro/screens/home/service_screen.dart';
import '../../core/widgets/custom_button.dart';
import '../main_screen.dart';
import 'garage_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //static const String _userName = 'Костянтин';
  static const String _carModel = '2022 Volkswagen Tiguan';
  //static const String _carNumber = 'BC 1234 AH';
  //static const String _mileage = '145 200 км';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

				backgroundColor: Colors.transparent,
				
        title: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Image.asset(
                  'assets/images/Logo.png',
                  width: 32,
                  height: 32
                ),
                
                const SizedBox(width: 8),

                const Text('GaragePro',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  )
                ),

              ],
            ),

            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap:() => {
                  MainScreen.of(context)?.setIndex(3),
                },

                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF03192A),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 16,
                  ),
                )
              ),
            ),

          ],
        ),

				flexibleSpace: Container(
					decoration: BoxDecoration(
						color: Colors.white,
						boxShadow: [
							BoxShadow(
								color: Color.fromARGB(4, 0, 0, 0),
								offset: const Offset(0, 1),
								blurRadius: 8,
							),
						]
					)
				),
      ),

      backgroundColor: const Color.fromARGB(255, 247, 249, 252),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child:
               Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'ACTIVE VEHICLE',
                        style: TextStyle(
                          color: Color(0xFF43474C),
                          fontSize: 11,
                          fontWeight: FontWeight.normal,
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),

                        decoration: BoxDecoration(
                          color: Color(0xFFAFD2FD),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.verified_outlined,
                              color: Color(0xFF375A7F), 
                              size: 16,
                            ),
                            
                            const SizedBox(width: 4),
                            
                            const Text(
                              '7XYZ890',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF375A7F),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  
                  Align(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      _carModel,
                      style: TextStyle(
                        color: Color(0xFF03192A),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Image.asset(
                    'assets/images/active car.png',
                    width: 326,
                    height: 176,
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Log Service',
                          icon: Icons.verified_outlined,
                          bgColor: Color(0xFF03192A),
                          textColor: Color(0xFFFFFFFF),
                          isIconOnEnd: false,
                          onPressed: () {
                            MainScreen.of(context)?.navigateToServiceWithScreen(
                              AddRecordScreen(showBackButton: true),
                            );

                          },
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: CustomButton(
                          text: 'My Garage',
                          icon: Icons.car_repair_outlined,
                          bgColor: Color(0xFFE6E8EB),
                          textColor: Color(0xFF03192A),
                          isIconOnEnd: false,
                          onPressed: () {
                            
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const GarageScreen()),
                            );
                            
                          },
                        ),
                      ),
                    ],
                  ),

                ], 
              ), 
            ),

            const SizedBox(height: 24),
            
            Row(
              children: [
                // Ліва картка: Total Expenses
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    height: 144, 
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F4F7), // Світло-сірий фон картки
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Верхній рядок: іконка та дропдаун/фільтр
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD6E4F0), // Блакитна підкладка під іконку
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.payments_outlined, // Або Icons.account_balance_wallet_outlined
                                color: Color(0xFF1D3557),
                                size: 22,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  'This Month',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                                SizedBox(width: 2),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 12,
                                  color: Color(0xFF333333),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Підпис
                        const Text(
                          'Total Expenses',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF555555),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 2),
                        // Головне значення
                        const Text(
                          '\$420.50',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F1E2E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 16), // Відступ між картками

                // Права картка: Next Oil Change
                Expanded(
                  child: Container(
                    height: 144, 
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F4F7), // Світло-сірий фон картки
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Верхній рядок: іконка та статусний бейдж
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9EAE1), // Бежева/персикова підкладка
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.oil_barrel, // Або Icons.water_drop, Icons.local_gas_station
                                color: Color(0xFF6B4210), // Коричневий акцент бочки
                                size: 22,
                              ),
                            ),
                            const Text(
                              'Due Soon',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFC77728), // Теплий помаранчевий статус
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Підпис
                        const Text(
                          'Next Oil Change',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF555555),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 2),
                        // Головне значення
                        const Text(
                          'In 1,500 km',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F1E2E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                const Text(
                  'Recent Service Records',
                  style: TextStyle(
                    color: Color(0xFF03192A),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                TextButton(
                  onPressed: () {
                    MainScreen.of(context)?.navigateToServiceWithScreen(
                      ServiceScreen(showBackButton: true,),
                    );
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3E6186),
                    ),
                  ),
                ),

              ],
            ),
            
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F4F6), // М'який світло-сірий фон картки
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  // 1. Іконка на підкладці
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E7EC), // Трохи темніша сіро-блакитна підкладка
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.settings_outlined, // Або Icons.build_outlined, Icons.auto_fix_high
                      color: Color(0xFF0F2439),
                      size: 24,
                    ),
                  ),

                  const SizedBox(width: 14),

                  // 2. Центральний блок з назвою, датою та статусом
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Brake Pad Replacement',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F2439),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Text(
                              'Sept 10, 2023',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              '•',
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 6),
                            // Капсула статусу (Completed)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD6E6F8), // Ніжно-блакитний бейдж
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Completed',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1D4ED8), // Темно-синій текст статусу
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // 3. Правий блок (Ціна та назва автомайстерні)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        '\$280.00',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F2439),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'AutoShop Pro',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F4F6), // М'який світло-сірий фон картки
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  // 1. Іконка на підкладці
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E7EC), // Трохи темніша сіро-блакитна підкладка
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.rotate_right_sharp, // Або Icons.build_outlined, Icons.auto_fix_high
                      color: Color(0xFF0F2439),
                      size: 24,
                    ),
                  ),

                  const SizedBox(width: 14),

                  // 2. Центральний блок з назвою, датою та статусом
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tire Rotation & Balance',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F2439),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Text(
                              'Aug 22, 2023',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              '•',
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 6),
                            // Капсула статусу (Completed)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD6E6F8), // Ніжно-блакитний бейдж
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Completed',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1D4ED8), // Темно-синій текст статусу
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // 3. Правий блок (Ціна та назва автомайстерні)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        '\$85.00',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F2439),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'City Tires',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}