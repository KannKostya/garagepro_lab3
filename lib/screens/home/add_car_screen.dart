import 'package:flutter/material.dart';
//import '../../core/widgets/custom_button.dart';
//import '../../core/widgets/custom_text_field.dart';
import '../main_screen.dart';

class AddCarScreen extends StatelessWidget {
  final bool showBackButton;

  const AddCarScreen({
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
                      'Add Car',
                      style: TextStyle(
                        color: Color(0xFF03192A),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Text(
                      'Register a vehicle to your garage',
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
            
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Icon(Icons.directions_car_outlined, size: 60, color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Upload Vehicle Photo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('PNG, JPG, or HEIC up to 10MB', style: TextStyle(color: Colors.grey)),
            const Divider(height: 40),
            
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Заголовок секції з іконкою ID-картки
                  Row(
                    children: const [
                      Icon(
                        Icons.badge_outlined,
                        color: Color(0xFF1E3A5F),
                        size: 22,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Identity Details',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F2439),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 2. Поле: Vehicle Make *
                  _buildFieldLabel('Vehicle Make *'),
                  const SizedBox(height: 8),
                  _buildInputField(
                    hintText: 'e.g. Toyota, BMW, Tesla',
                    prefixIcon: Icons.precision_manufacturing_outlined, // Або Icons.directions_car_outlined
                  ),

                  const SizedBox(height: 16),

                  // 3. Поле: Model *
                  _buildFieldLabel('Model *'),
                  const SizedBox(height: 8),
                  _buildInputField(
                    hintText: 'e.g. RAV4, Model 3, 330i',
                    prefixIcon: Icons.directions_car_outlined,
                  ),

                  const SizedBox(height: 16),

                  // 4. Нижній рядок: Year * та Trim / Package
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Поле Year (фіксована ширина або менша частка)
                      SizedBox(
                        width: 110,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Year *'),
                            const SizedBox(height: 8),
                            _buildInputField(
                              hintText: '2023',
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Поле Trim / Package (займає весь залишковий простір)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Trim / Package'),
                            const SizedBox(height: 8),
                            _buildInputField(
                              hintText: 'e.g. XLE Premium AWD',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
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
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF334155),
      ),
    );
  }

  // Універсальне текстове поле у сірій підкладці
  Widget _buildInputField({
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
  }
}