import 'package:flutter/material.dart';
import '../main_screen.dart';
import 'dart:ui';
import '../../core/widgets/service_record_card.dart';
import '../../models/service_record.dart';

class ServiceScreen extends StatefulWidget {
  final bool showBackButton;
  final Function(String selectedCategory)? onCategorySelected;

  const ServiceScreen({
    super.key,
    this.showBackButton = false,
    this.onCategorySelected,
  });

    @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen>{
  bool _showFilters = true;

  final List<String> _categories = [
    'All',
    'Maintenance',
    'Engine',
    'Suspension',
    'Brakes'
  ];

  String _selectedCategory = 'All';

  final List<ServiceRecord> initialRecords = [
    const ServiceRecord(
      id: '1',
      title: 'Brake Pad Replacement',
      date: 'Sept 10, 2023',
      mileage: 142500,
      category: 'Suspension',
      parts: 'Ceramic pads, rotors',
      shop: 'AutoShop Pro',
      cost: 280.00,
      icon: Icons.album_outlined,
    ),
    const ServiceRecord(
      id: '2',
      title: 'Tire Rotation & Balance',
      date: 'Aug 22, 2023',
      mileage: 139000,
      category: 'Maintenance',
      parts: 'Wheel weights',
      shop: 'City Tires',
      cost: 85.00,
      icon: Icons.replay,
    ),
    const ServiceRecord(
      id: '3',
      title: 'Synthetic Oil Change',
      date: 'Jun 15, 2023',
      mileage: 135000,
      category: 'Engine',
      parts: '5W-30 Oil, Filter',
      shop: 'QuickLube',
      cost: 65.00,
      icon: Icons.oil_barrel_outlined,
    ),
    const ServiceRecord(
      id: '4',
      title: 'Spark Plug Replavement',
      date: 'Apr 04, 2023',
      mileage: 128000,
      category: 'Engine',
      parts: 'Bosch Iridium (4)',
      shop: 'Apex Motors',
      cost: 120.00,
      icon: Icons.electric_bolt_sharp,
    ),
  ];

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
      
      body: CustomScrollView(
        slivers: [
          // 1. Верхня частина екрана (шапка, пошук, фільтри)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Шапка екрана
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (widget.showBackButton) ...[
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              MainScreen.of(context)?.setIndex(0);
                            },
                            customBorder: const CircleBorder(),
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                color: Color(0xFFECEEF1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Color(0xFF0F2439),
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Service History',
                            style: TextStyle(
                              color: Color(0xFF03192A),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Track all repairs and routine maintenance',
                            style: TextStyle(
                              color: Color(0xFF43474C),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Рядок пошуку
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFECEEF1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        // Сюди додасте фільтрацію списку за текстом пошуку
                      },
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
                            setState(() {
                              _showFilters = !_showFilters;
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  // Горизонтальний список фільтрів категорій
                  if (_showFilters) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 34, // Фіксована висота для горизонтального ListView
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                            PointerDeviceKind.trackpad,
                          },
                        ),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _categories.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final category = _categories[index];
                            final bool isSelected = _selectedCategory == category;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = category;
                                });
                                widget.onCategorySelected?.call(category);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF03192A)
                                      : const Color(0xFFE6E8EB),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: isSelected
                                          ? Colors.white
                                          : const Color(0xFF43474C),
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),

                  ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            sliver: SliverList.separated(
              itemCount: initialRecords.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final record = initialRecords[index];
                return ServiceRecordCard(
                  record: record,
                  onTap: () {
                    // Перехід на екран перегляду або редагування запису (п. 1.2)
                  },
                  onDownloadReceipt: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Receipt for ${record.title} downloaded')),
                    );
                  },
                );
              },
            ),
          ),
          
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            sliver: SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'All records verified and synced with GaragePro Cloud.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF74777D),
                    )
                  )
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}