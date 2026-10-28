import 'package:flutter/material.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../auth/login_screen.dart';
import '../main_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen>{
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
  Widget build(BuildContext context){
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
								spreadRadius: 0,
							),		
						]			
					)
				),
      ),
      
			backgroundColor: const Color.fromARGB(255, 247, 249, 252),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            children: [

              Image.asset(
                'assets/images/registration.png',
                width: 68,
                height: 68
              ),

              const SizedBox(height: 12),

              const Text(
                'Create Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const Text(
                'Join GaragePro to track maintenance, log service costs & manage your fleet',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF43474C),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 24),
              
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
                      'Full Name',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF43474C),
                      ),
                    ),

                    const SizedBox(height: 6),

                    const CustomTextField(
                      label: 'e.g. Kostiantyn Kann',
                      prefixIcon: Icons.person_outline,
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF43474C),
                      ),
                    ),

                    const SizedBox(height: 6),

                    const CustomTextField(
                      label: 'example@driver.com',
                      prefixIcon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF43474C),
                          ),
                        ),

                        const Text(
                          '8+ characters',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF74777D),
                          ),
                        ),
                      ],
                    ),
                    

                    const SizedBox(height: 6),

                    const CustomTextField(
                      label: '••••••••••••',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Confirm Password',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF43474C),
                      ),
                    ),

                    const SizedBox(height: 6),

                    const CustomTextField(
                      label: '••••••••••••',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 25,
                          height: 25,
                          child:

                            Checkbox(
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value ?? false;
                                });
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                              activeColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                              side: BorderSide(
                                color: Color(0xFF767676),
                                width: 1,
                              ),
                            ),
                        ),

                        const Text(
                          'I agree on the ',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF43474C),
                          ),
                        ),

                        const Text(
                          'Terms of Service',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF3E6186),
                          ),
                        ),

                        const Text(
                          ' and ',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF43474C),
                          ),
                        ),

                        const Text(
                          'Privacy Policy',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF3E6186),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    CustomButton(
                      text: 'Create Account',
                      icon: Icons.arrow_forward,
                      bgColor: Color(0xFF03192A),
                      textColor: Color(0xFFFFFFFF),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const MainScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'OR SIGN UP WITH',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  // Кнопка Google
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const MainScreen()),
                          );
                        },
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/chrome.png'),
                              const SizedBox(width: 8),
                              const Text(
                                'Google',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Кнопка Apple
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const MainScreen()),
                          );
                        },
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.apple,
                                size: 24,
                                color: Colors.black,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Apple',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF43474C),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Sign In >',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3E6186),
                      ),
                    ),
                  ),
                  
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}
