import 'package:flutter/material.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../auth/login_screen.dart';
import '../main_screen.dart';

class ProfileScreen extends StatelessWidget {
  final bool showBackButton;

  const ProfileScreen({
    super.key,
    this.showBackButton = false,
  });

  static const String _name = 'Kostiantyn Kann';
  static const String _email = 'example@driver.com';

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

                const Text(
                  'Profile',
                  style: TextStyle(
                    color: Color(0xFF03192A),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),


            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            const Text(_name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text(_email, style: TextStyle(color: Colors.grey)),
            const Divider(height: 40),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Change Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              label: 'Old Password',
              prefixIcon: Icons.lock_clock_outlined,
              isPassword: true,
            ),
            const SizedBox(height: 12),
            const CustomTextField(
              label: 'New password',
              prefixIcon: Icons.lock_reset,
              isPassword: true,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Change Password',
              bgColor: Color(0xFF03192A),
              textColor: Color(0xFFFFFFFF),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password succesfully changed!')),
                );
              },
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Log out',
              isOutlined: false,
              bgColor: Color(0xFFFFDAD6),
              textColor: Color(0xFF93000A),

              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}