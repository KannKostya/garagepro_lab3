import 'package:flutter/material.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
//import '../home/home_screen.dart';
import 'forgot_password_screen.dart';
import 'registration_screen.dart';
import '../main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Контролери для зчитування введеного тексту
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isChecked = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

				backgroundColor: Colors.transparent,
				
        title: Row(
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

      body: SafeArea(

        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 130),

              Image.asset(
                'assets/images/Background+Shadow.png',
                width: 68,
                height: 68
              ),

              const SizedBox(height: 12),

              const Text(
                'Welcome Back',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              const Text(
                'Sign in to manage your vehicle & service history',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF43474C),
                ),
              ),
              
              const SizedBox(height: 32),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                
                decoration: BoxDecoration(
                  color: Color(0xFFF2F4F7),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(5, 0, 0, 0),
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF43474C),
                      ),
                    ),

                    const SizedBox(height: 2),

                    const CustomTextField(
                      label: 'example@driver.com',
                      prefixIcon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF43474C),
                      ),
                    ),

                    const SizedBox(height: 2),

                    const CustomTextField(
                      label: '••••••••••••',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value ?? false;
                                });
                              },
                              activeColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.5), // Закруглення кутиків квадрата
                              ),
                              side: BorderSide(
                                color: Color(0xFF767676), // Колір рамки в неактивному стані
                                width: 1,
                              ),
                            ),
                            const Text(
                              'Remember me',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF43474C),
                              ),
                            ),
                          ]
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                            );
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF3E6186),
                            ),
                          ),
                        ),
                      ]
                    ),

                    const SizedBox(height: 16),

                    CustomButton(
                      text: 'Sign In',
                      icon: Icons.arrow_forward,
                      bgColor: Color(0xFF03192A),
                      textColor: Color(0xFFFFFFFF),
                      onPressed: () {
                        // Без бекенду: перехід одразу на головний екран
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const MainScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don`t have an account?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF43474C),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegistrationScreen()),
                      );
                    },
                    child: const Text(
                      'Create new account',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3E6186),
                      ),
                    ),
                  ),
                  
                ],
              )

              
            ],
          ),
        ),
      ),
    );
  }
}