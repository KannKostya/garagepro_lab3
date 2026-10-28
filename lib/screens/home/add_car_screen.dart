import 'package:flutter/material.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
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
        padding: const EdgeInsets.all(16.0),
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

            Container(
              padding: const EdgeInsets.all(16),
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
                children: [

                  const SizedBox(height: 8),

                  Center(
                    child: Image.asset(
                      'assets/images/AddCarTopImage.png',
                      height: 80,
                      width: 80,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Upload Vehicle Photo',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF03192A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Text(
                    'PNG, JPG, or HEIC up to 10MB',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF43474C),
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          //MainScreen.of(context)?.setIndex(2);
                        },
                        icon: const Icon(
                          Icons.photo_camera_outlined,
                          size: 14,
                          color: Color(0xFF3E6186),
                        ),
                        label: const Text(
                          'Gallerey',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF03192A),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE0E3E6),
                          elevation: 4,
                          shadowColor: Color.fromARGB(5, 0, 0, 0),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          shape: const StadiumBorder(),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),

                      const SizedBox(width: 8),

                      ElevatedButton.icon(
                        onPressed: () {
                          //MainScreen.of(context)?.setIndex(2);
                        },
                        icon: const Icon(
                          Icons.photo_camera_outlined,
                          size: 14,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Take Shot',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1A2E40),
                          elevation: 4,
                          shadowColor: Color.fromARGB(5, 0, 0, 0),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          shape: const StadiumBorder(),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  Row(
                    children: const [
                      Icon(
                        Icons.badge_outlined,
                        color: Color(0xFF3E6186),
                        size: 22,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Identity Details',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF03192A),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _buildFieldLabel('Vehicle Make *'),
                  const SizedBox(height: 4),
                  const CustomTextField(
                    label: 'e.g. Toyota, BMW, Tesla',
                    prefixIcon: Icons.precision_manufacturing_outlined,
                    bgColor: Color(0xFFF2F4F7),
                  ),

                  const SizedBox(height: 8),

                  // 3. Поле: Model *
                  _buildFieldLabel('Model *'),
                  const SizedBox(height: 4),
                  const CustomTextField(
                    label: 'e.g. RAV4, Model 3, 330i',
                    prefixIcon: Icons.directions_car_outlined,
                    bgColor: Color(0xFFF2F4F7),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 110,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Year *'),
                            const SizedBox(height: 4),
                            const CustomTextField(
                                label: '2023',
                                bgColor: Color(0xFFF2F4F7),
                                keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Trim / Package'),
                            const SizedBox(height: 4),
                            const CustomTextField(
                                label: 'e.g. XLE Premium AWD',
                                bgColor: Color(0xFFF2F4F7),
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

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  Row(
                    children: const [
                      Icon(
                        Icons.badge_outlined,
                        color: Color(0xFF3E6186),
                        size: 22,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Specs & Identifiers',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF03192A),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _buildFieldLabel('License Plate / Tag'),
                  const SizedBox(height: 4),
                  const CustomTextField(
                    label: 'E.G. 7XYZ908',
                    prefixIcon: Icons.grid_3x3,
                    bgColor: Color(0xFFF2F4F7),
                  ),

                  const SizedBox(height: 8),

                  _buildFieldLabel('VIN (Vehicle Identification Number)'),
                  const SizedBox(height: 4),
                  const CustomTextField(
                    label: '1HGCR2F83HA. . .',
                    prefixIcon: Icons.directions_car_outlined,
                    bgColor: Color(0xFFF2F4F7),
                  ),

                  const SizedBox(height: 8),

                  _buildFieldLabel('Current Odometer *'),
                  const SizedBox(height: 4),
                  const CustomTextField(
                    label: '42,500',
                    prefixIcon: Icons.speed,
                    bgColor: Color(0xFFF2F4F7),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            CustomButton(
              text: 'Save Car to Garage',
              icon: Icons.garage_outlined,
              isIconOnEnd: false,
              onPressed: () {
                MainScreen.of(context)?.setIndex(0);
              },
              bgColor: Color(0xFF03192A),
              textColor: Colors.white,
            ),

            const SizedBox(height: 10),

            const Text(
              'Service schedules and alert profiles will be auto-configured.',
              style: TextStyle(
                color: Color(0xFF74777D),
                fontSize: 12,
              ),
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