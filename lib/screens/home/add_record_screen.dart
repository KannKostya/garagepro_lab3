import 'package:flutter/material.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../main_screen.dart';


class _DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dash;
  final double gap;
  final double radius;

  _DashedRectPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.dash = 5.0,
    this.gap = 3.0,
    this.radius = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        strokeWidth / 2,
        strokeWidth / 2,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);
    final Path dashedPath = Path();

    for (final metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double len = (distance + dash < metric.length) ? dash : metric.length - distance;
        dashedPath.addPath(
          metric.extractPath(distance, distance + len),
          Offset.zero,
        );
        distance += dash + gap;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant _DashedRectPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.dash != dash ||
      oldDelegate.gap != gap ||
      oldDelegate.radius != radius;
}

class AddRecordScreen extends StatefulWidget {
  final bool showBackButton;

  const AddRecordScreen({
    super.key,
    this.showBackButton = false,
  });

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen>{
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                if(widget.showBackButton) ...[
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
                      'Add Service Record',
                      style: TextStyle(
                        color: Color(0xFF03192A),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Text(
                      'Log your recent maintenance or repair',
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

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                color: Color(0xFFF2F4F7),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(5, 0, 0, 0),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1 Поле: Vehicle Make *
                  _buildFieldLabel('Repair Title'),
                  const SizedBox(height: 4),
                  const CustomTextField(
                    label: 'e.g. Brake Pad Replacement',
                    prefixIcon: Icons.precision_manufacturing_outlined,
                    bgColor: Color(0xFFFFFFFF),
                  ),

                  const SizedBox(height: 16),

                  // 2 Поле: Model *
                  _buildFieldLabel('Work Caregory'),
                  const SizedBox(height: 4),

                  DropdownMenu<String>(
                    width: double.infinity,
                    initialSelection: null,
                    hintText: 'Select category',
                    leadingIcon: const Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Icon(
                        Icons.category_outlined,
                        color: Color(0xFF64748B),
                        size: 22,
                      ),
                    ),
                    trailingIcon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF64748B),
                      size: 24,
                    ),
                    selectedTrailingIcon: const Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: Color(0xFF64748B),
                      size: 24,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF191C1E),
                      fontWeight: FontWeight.normal,
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: const Color(0xFFFFFFFF),
                      hintStyle: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF191C1E),
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
                    menuStyle: MenuStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      elevation: WidgetStateProperty.all(8),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    // Список пунктів
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: 'Maintenance', label: 'Maintenance'),
                      DropdownMenuEntry(value: 'Engine', label: 'Engine'),
                      DropdownMenuEntry(value: 'Suspension', label: 'Suspension'),
                      DropdownMenuEntry(value: 'Brakes', label: 'Brakes'),
                    ],
                    onSelected: (String? value) {
                      // Обробка вибору
                    },
                  ),

                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Поле Year (фіксована ширина або менша частка)
                      SizedBox(
                        width: 147,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Current Mileage'),
                            const SizedBox(height: 4),
                            const CustomTextField(
                                label: '145.000',
                                bgColor: Color(0xFFFFFFFF),
                                prefixIcon: Icons.speed,
                                keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Поле Trim / Package (займає весь залишковий простір)
                      SizedBox(
                        width: 147,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Total Cost'),
                            const SizedBox(height: 4),
                            const CustomTextField(
                                label: '0.00',
                                prefixIcon: Icons.money,
                                bgColor: Color(0xFFFFFFFF),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _buildFieldLabel('Service Date'),
                  const SizedBox(height: 4),
                  const CustomTextField(
                    label: '10/24/2026',
                    prefixIcon: Icons.calendar_today_outlined,
                    bgColor: Color(0xFFFFFFFF),
                  ),

                  const SizedBox(height: 16),

                  _buildFieldLabel('Notes / Description (Optional)'),
                  const SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF), // М'який сірий фон капсули
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      maxLines: 5, // Кількість видимих рядків за замовчуванням
                      minLines: 2, // Мінімальна висота поля в рядках
                      keyboardType: TextInputType.multiline, // Увімкнення перенесення рядків на клавіатурі
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0F2439),
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        filled: false,
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        
                        // Іконка списку/абзацу (Icons.notes або Icons.subject)
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 4, right: 8, top: 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.notes, // Або Icons.menu, Icons.subject_rounded
                                color: Color(0xFF64748B),
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 46,
                          minHeight: 46,
                        ),

                        hintText: 'Add details about parts used,\nmechanics, or warranty info...',
                        hintStyle: const TextStyle(
                          color: Color(0xFF9CA3AF), // Світло-сірий плейсхолдер
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          height: 1.4, // Міжрядковий інтервал для зручного читання
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildFieldLabel('Receipt / Repair Bill'),
                  const SizedBox(height: 4),
                  CustomPaint(
                    foregroundPainter: _DashedRectPainter(
                      color: const Color(0xFFC3C7CD), // Світло-сірий колір пунктирної рамки
                      strokeWidth: 1.5,
                      radius: 16.0, // Радіус заокруглення кутів
                      gap: 5.0,     // Відстань між штрихами
                      dash: 6.0,    // Довжина одного штриха
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF), // Дуже світлий фоновий колір
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Кругла плашка з іконкою камери
                          Container(
                            width: 52,
                            height: 52,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE2E8F0), // Сірий кружечок
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt, // Або Icons.photo_camera_rounded
                              color: Color(0xFF0F2439), // Темний колір камери
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Основний напис
                          const Text(
                            'Attach receipt or repair bill photo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F2439),
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Підпис форматів і ліміту
                          const Text(
                            'Supports PNG, JPG, or PDF up to 10MB',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            CustomButton(
              text: 'Save record',
              icon: Icons.garage_outlined,
              isIconOnEnd: false,
              onPressed: () {
                MainScreen.of(context)?.setIndex(0);
              },
              bgColor: Color(0xFF03192A),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
  // Підпис над полем
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF43474C),
      ),
    );
  }
}