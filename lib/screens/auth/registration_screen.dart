import 'package:flutter/material.dart';
import '../../core/widgets/custom_input_decoration.dart';
import '../auth/login_screen.dart';
import '../../repositories/auth_repository.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  final AuthRepository _authRepository = AuthRepository();

  bool _isChecked = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool _isLoading = false;
  bool _isSubmitted = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    setState(() => _isSubmitted = true);

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authRepository.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        displayName: _nameController.text.trim(),
      );

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
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
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            
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
                      
                    const Text(
                      'Full Name',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF43474C),
                      ),
                    ),

                    const SizedBox(height: 6),

                    TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      decoration: EnterInputDecorations.standard(
                        hintText: "e. g. Kostiantyn Kann",
                        icon: Icons.person_outline_rounded,
                      ),
                      onChanged: (text) {
                        if (_isSubmitted) {
                          setState(() => _isSubmitted = false);
                        }
                      },
                      validator: (value) {
                        if (!_isSubmitted) return null;
                        if (value == null || value.trim().isEmpty) {
                          return "Enter name";
                        }
                        return null;
                      },
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

                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: EnterInputDecorations.standard(
                        hintText: 'example@driver.com',
                        icon: Icons.email_outlined,
                      ),
                      onChanged: (text) {
                        if (_isSubmitted) {
                          setState(() => _isSubmitted = false);
                        }
                      },
                      validator: (value) {
                        if (!_isSubmitted) return null;
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

                    const Text(
                      'Confirm Password',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF43474C),
                      ),
                    ),

                    const SizedBox(height: 6),

                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      textInputAction: TextInputAction.done,
                      decoration: EnterInputDecorations.standard(
                        hintText: '••••••••••••••••',
                        icon: Icons.lock_outline_rounded,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: const Color(0xFF64748B),
                            size: 20,
                          ),
                          onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
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
                          return 'Repeat password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords dont match';
                        }
                        return null;
                      },
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

                    ElevatedButton(
                        onPressed: _isLoading ? null : _handleRegister,
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
                                  'Create account',
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

              const SizedBox(height: 10),

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
          ),
          )
        ),
      ),
    );
  }
}
