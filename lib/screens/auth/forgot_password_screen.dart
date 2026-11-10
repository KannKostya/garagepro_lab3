import 'package:flutter/material.dart';
//import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_input_decoration.dart';
import '../auth/login_screen.dart';
import '../../repositories/auth_repository.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();

  bool _isLoading = false;
  String? _errorMessage;
  bool _isSuccessSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    // 1. Перевірка валідності email
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _isSuccessSent = false;
    });

    try {
      // 2. Виклик методу скидання пароля
      await _authRepository.resetPassword(
        email: _emailController.text.trim(),
      );

      setState(() {
        _isSuccessSent = true;
      });

      if (mounted) {
        /*ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The instr!'),
            backgroundColor: Colors.green,
          ),
        );*/
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
								spreadRadius: 0,
							),		
						]			
					)
				),
      ),

      backgroundColor: const Color.fromARGB(255, 247, 249, 252),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Form(
            key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              const SizedBox(height: 130),

              Image.asset(
                'assets/images/forgotPassword.png',
                width: 90,
                height: 93,
              ),

              const SizedBox(height: 3),
              
              const Text(
                'Forgot Password?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF03192A),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Enter the email associated with your account\nand we\'ll send you instructions to reset your\npassword.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF43474C),
                ), 
              ),

              const SizedBox(height: 16),

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
                    if (_errorMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(color: Colors.red.shade800, fontSize: 13),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Повідомлення про успішне надсилання
                    if (_isSuccessSent) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: Text(
                          'The message is succesfully delivered. Check your inbox.',
                          style: TextStyle(color: Colors.green.shade900, fontSize: 13),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Email Address',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF43474C),
                          ),
                        ),

                        const Text(
                          'Registered Account',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF3E6186),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Поле введення email
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 15, color: Color(0xFF0F2439)),
                      decoration: EnterInputDecorations.standard(
                        hintText: "example@driver.com",
                        icon: Icons.email_outlined,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter eMail';
                        }
                        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value.trim())) {
                          return 'Unsupported eMail format';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 6),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.verified_user_outlined,
                          color: Color(0xFF3E6186),
                          size: 14,
                        ),
                        
                        const Text(
                          ' We\'ll never share your email with third parties',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF43474C),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /*CustomButton(
                      text: 'Send Reset Link',
                      icon: Icons.arrow_forward,
                      bgColor: Color(0xFF03192A),
                      textColor: Color(0xFFFFFFFF),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Message sent on specified eMail!')),
                        );
                        Navigator.pop(context);
                      },
                    ),*/
                    ElevatedButton(
                      onPressed: _isLoading ? null : _handleResetPassword,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color(0xFF03192A),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.2,
                              ),
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                              
                                Text(
                                  'Set Reset Link',
                                  style: TextStyle(color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                                ),

                                SizedBox(width: 8,),
                                
                                Icon(Icons.arrow_forward,
                                color: Colors.white,),
                                
                              ],
                            )
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.lock_reset_sharp,
                          color: Color(0xFF3E6186),
                          size: 15,
                        ),

                        const Text(
                          ' 256-bit encrypted recovery system',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF43474C),
                          ),
                        ),

                      ],
                    ),

                    const Text(
                      'GaragePro Guard',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF3E6186),
                      ),
                    ),
                  ],

                )
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Remember your password? ',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
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
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E6186),
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}