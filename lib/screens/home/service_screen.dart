import 'package:flutter/material.dart';
import '../main_screen.dart';

class ServiceScreen extends StatelessWidget {
  final bool showBackButton;

  const ServiceScreen({
    super.key,
    this.showBackButton = false,
  });

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
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                if(showBackButton) ...[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      MainScreen.of(context)?.setIndex(0);
                    },
                    customBorder: const CircleBorder(), // Робить хвилю натискання круглою
                    child: Container(
                      width: 44, // Розмір кнопки
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFFECEEF1), // Світло-сірий фон кола
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF0F2439), // Темно-синій/чорний колір стрілки
                        size: 20,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),
                
                ],

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Service History',
                      style: TextStyle(
                        color: Color(0xFF03192A),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Text(
                      'Track all repairs and routine maintenance',
                      style: TextStyle(
                        color: Color(0xFF43474C),
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
              ],
            ),

            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFECEEF1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                style: const TextStyle(
                  color: Color(0xFF0F2439),
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  
                  filled: true,
                  fillColor: const Color(0xFFECEEF1),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF74777D),
                    size: 22,
                  ),
                  
                  hintText: 'Search service records...',
                  hintStyle: const TextStyle(
                    color: Color(0xFF74777D),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.tune,
                      color: Color(0xFF74777D),
                      size: 20,
                    ),
                    onPressed: () {
                      // Дія при натисканні на фільтр (наприклад, відкриття модального вікна)
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                  decoration: BoxDecoration(
                    color: Color(0xFF03192A),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    'All',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFFFFFFFF),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                  decoration: BoxDecoration(
                    color: Color(0xFFE6E8EB),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    'Maintenance',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF43474C),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                  decoration: BoxDecoration(
                    color: Color(0xFFE6E8EB),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    'Engine',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF43474C),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                  decoration: BoxDecoration(
                    color: Color(0xFFE6E8EB),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    'Suspension',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF43474C),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4F7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Верхній рядок: Іконка, Назва, Дата/Пробіг та Статус
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Блакитна підкладка з іконкою гальмівного диска / деталі
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFFAFD2FD), // Блакитна підкладка
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.album_outlined, // Або Icons.adjust, Icons.disc_full_outlined
                          color: Color(0xFF375A7F),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 8),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Brake Pad Replacement',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF191C1E),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Sept 10, 2023 • 142,500 km',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF43474C),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Темна капсула статусу Completed
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A2E40),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Completed',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8296AB),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // 2. Внутрішній блок подробиць (Parts, Shop)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECEEF1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Parts:',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF758391),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Ceramic pads, rotors',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F2439),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Shop:',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF758391),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'AutoShop Pro',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F2439),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 3. Нижній рядок: Ціна та дія View Receipt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '\$280.00',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F2439),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Відкрити чек / деталі квитанції
                        },
                        borderRadius: BorderRadius.circular(6),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Download Receipt',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF3F6D9B), // Акцентний синій колір посилання
                              ),
                            ),
                            SizedBox(width: 2),
                            Icon(
                              Icons.chevron_right,
                              size: 18,
                              color: Color(0xFF3F6D9B),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4F7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFFAFD2FD),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.replay,
                          color: Color(0xFF375A7F),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 8),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Tire Rotation & Balance',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF191C1E),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Aug 22, 2023 • 139,000 km',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF43474C),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Темна капсула статусу Completed
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A2E40),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Completed',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8296AB),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // 2. Внутрішній блок подробиць (Parts, Shop)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECEEF1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Parts:',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF758391),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Wheel weights',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F2439),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Shop:',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF758391),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'City Tires',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F2439),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 3. Нижній рядок: Ціна та дія View Receipt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '\$85.00',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F2439),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Відкрити чек / деталі квитанції
                        },
                        borderRadius: BorderRadius.circular(6),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Download Receipt',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF3F6D9B),
                              ),
                            ),
                            SizedBox(width: 2),
                            Icon(
                              Icons.chevron_right,
                              size: 18,
                              color: Color(0xFF3F6D9B),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4F7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFFAFD2FD),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.oil_barrel_outlined,
                          color: Color(0xFF375A7F),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 8),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Synthetic Oil Change',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF191C1E),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Jun 15, 2023 • 135,000 km',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF43474C),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Темна капсула статусу Completed
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A2E40),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Completed',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8296AB),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // 2. Внутрішній блок подробиць (Parts, Shop)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECEEF1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Parts:',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF758391),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '5W-30 Oil, Filter',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F2439),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Shop:',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF758391),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'QuickLube',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F2439),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 3. Нижній рядок: Ціна та дія View Receipt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '\$65.00',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F2439),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Відкрити чек / деталі квитанції
                        },
                        borderRadius: BorderRadius.circular(6),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Download Receipt',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF3F6D9B),
                              ),
                            ),
                            SizedBox(width: 2),
                            Icon(
                              Icons.chevron_right,
                              size: 18,
                              color: Color(0xFF3F6D9B),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4F7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFFAFD2FD),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.electric_bolt_sharp,
                          color: Color(0xFF375A7F),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 8),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Spark Plug Replacement',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF191C1E),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Apr 04, 2023 • 128,000 km',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF43474C),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Темна капсула статусу Completed
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A2E40),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Completed',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8296AB),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // 2. Внутрішній блок подробиць (Parts, Shop)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECEEF1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Parts:',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF758391),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Bosch Iridium (4)',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F2439),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Shop:',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF758391),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Apex Motors',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F2439),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 3. Нижній рядок: Ціна та дія View Receipt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '\$120.00',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F2439),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Відкрити чек / деталі квитанції
                        },
                        borderRadius: BorderRadius.circular(6),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Download Receipt',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF3F6D9B),
                              ),
                            ),
                            SizedBox(width: 2),
                            Icon(
                              Icons.chevron_right,
                              size: 18,
                              color: Color(0xFF3F6D9B),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'All records verified and synced with GaragePro Cloud.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color(0xFF74777D),
              )
            )
          ],
        ),
      ),
    );
  }
}