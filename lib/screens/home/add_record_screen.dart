import 'package:flutter/material.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../main_screen.dart';

class AddRecordScreen extends StatelessWidget {
  final bool showBackButton;

  const AddRecordScreen({
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
        padding: const EdgeInsets.all(16),
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
              padding: const EdgeInsets.all(24),
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
                  const CustomTextField(
                    label: 'Select category',
                    prefixIcon: Icons.directions_car_outlined,
                    bgColor: Color(0xFFFFFFFF),
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
                  const CustomTextField(
                    label: '10/24/2026',
                    prefixIcon: Icons.calendar_today_outlined,
                    bgColor: Color(0xFFFFFFFF),
                  ),

                  const SizedBox(height: 16),

                  _buildFieldLabel('Receipt / Repair Bill'),
                  const SizedBox(height: 4),
                  const CustomTextField(
                    label: '10/24/2026',
                    prefixIcon: Icons.calendar_today_outlined,
                    bgColor: Color(0xFFFFFFFF),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

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

  // Універсальне текстове поле у сірій підкладці
  /*Widget _buildInputField({
    required String hintText,
    IconData? prefixIcon,
    TextInputType? keyboardType,
    TextEditingController? controller,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F6), // М'який сірий фон інпуту
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF0F2439),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          isDense: true,
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  size: 20,
                  color: const Color(0xFF64748B),
                )
              : null,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }*/
}