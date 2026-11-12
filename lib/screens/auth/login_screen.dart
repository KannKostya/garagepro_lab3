import 'package:flutter/material.dart';
import '../../core/widgets/custom_input_decoration.dart';
import 'forgot_password_screen.dart';
import 'registration_screen.dart';
import '../../repositories/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthRepository _authRepo = AuthRepository();
  bool _isChecked = false;

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _isSubmitted = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    setState(() => _isSubmitted = true);

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authRepo.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            
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
                      if (_errorMessage != null) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(color: Colors.red.shade800),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      const Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF43474C),
                        ),
                      ),

                      const SizedBox(height: 2),

                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: EnterInputDecorations.standard(
                          hintText: "example@driver.com",
                          icon: Icons.email_outlined,
                        ),
                        onChanged: (text) {
                          if (_isSubmitted) {
                            setState(() => _isSubmitted = false);
                          }
                        },
                        validator: (value) {
                          if(!_isSubmitted) return null;
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter eMail';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                            return 'Unsupported eMail format';
                          }
                          return null;
                        },
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

                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.next,
                        decoration: EnterInputDecorations.standard(
                          hintText: '••••••••••••••••',
                          icon: Icons.lock_outline_rounded,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: const Color(0xFF64748B),
                              size: 20,
                            ),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                        ),
                        onChanged: (text) {
                          if (_isSubmitted) {
                            setState(() => _isSubmitted = false);
                          }
                        },
                        validator: (value) {
                          if (!_isSubmitted) return null;
                          if (value == null || value.isEmpty) {
                            return 'Enter password';
                          }
                          if (value.length < 8) {
                            return 'Password should be at least 8 symbols';
                          }
                          return null;
                        },
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
                                  borderRadius: BorderRadius.circular(2.5),
                                ),
                                side: BorderSide(
                                  color: Color(0xFF767676),
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


                      ElevatedButton(
                        onPressed: _isLoading ? null : _signIn,
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
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                              
                                Text(
                                  'Sign In',
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
      ),
    );
  }
}