import 'package:flutter/material.dart';
import '../main_screen.dart';
import '../home/garage_screen.dart';
import '../../repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../screens/auth/auth_gate.dart';
import '../../core/widgets/custom_input_decoration.dart';

class ProfileScreen extends StatefulWidget {
  final bool showBackButton;

  const ProfileScreen({
    super.key,
    this.showBackButton = false,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  final AuthRepository authRepo = AuthRepository();

  // Окремі ключі валідації для кожної секції
  final _nameFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  bool _isNameLoading = false;
  bool _isPasswordLoading = false;
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _isNameSubmitted = false;
  bool _isPasswordSubmitted = false;

  String? _currentPasswordError;

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    _nameController = TextEditingController(text: currentUser?.displayName ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _updateName() async {
    setState(() => _isNameSubmitted = true);

    if (!_nameFormKey.currentState!.validate()) return;

    setState(() => _isNameLoading = true);
    try {
      await authRepo.updateDisplayName(_nameController.text.trim());
      if (mounted) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Name succesfully changed!"),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isNameLoading = false);
    }
  }

  Future<void> _updatePassword() async {
    setState(() => _isPasswordSubmitted = true);

    if (!_passwordFormKey.currentState!.validate()) return;

    setState(() => _isPasswordLoading = true);
    try {
      final bool isCorrect = await authRepo.verifyCurrentPassword(
        _currentPasswordController.text.trim(),
      );

      if (!isCorrect) {
        if (mounted) {
          setState(() {
            _currentPasswordError = 'Incorrect password';
          });
          _passwordFormKey.currentState!.validate();
        }
        return;
      }

      await authRepo.updatePassword(_newPasswordController.text.trim());
      if (mounted) {
        _currentPasswordController.clear();
        _newPasswordController.clear();
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password succesfully changed!'),
          ),
        );
        _isPasswordSubmitted = false;
        _passwordFormKey.currentState!.validate();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isPasswordLoading = false);
    }
  }

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

      body: StreamBuilder<User?>(
        stream: authRepo.authStateChanges,
        builder: (context, snapshot) {
          final user = snapshot.data ?? authRepo.currentUser;

          if (user == null) {
            return const Center(child: Text('User is not authorised'));
          }

          final String displayName = user.displayName?.trim().isNotEmpty == true
              ? user.displayName!
              : 'GaragePro User';
          final String email = user.email ?? 'Unknown eMail';

          return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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

                const Text(
                  'Profile',
                  style: TextStyle(
                    color: Color(0xFF03192A),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 44),
              ],
            ),

            const SizedBox(height: 24),

            Center(
              child: Image.asset(
                'assets/images/profileTop.png',
                height: 136,
                width: 135,
              ),
            ),

            Text(
              displayName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF191C1E),
              ),
            ),

            Text(
              email,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF43474C),
              ),
            ),

            const SizedBox(height: 24),

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFAFD2FD),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.drive_eta_outlined,
                          color: Color(0xFF375A7F),
                          size: 24,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Registered Garage',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF191C1E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            '3 vehicles currently tracked',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF43474C),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  ElevatedButton.icon(
                    onPressed: () {
                      MainScreen.of(context)?.navigateToGarageWithScreen(
                        GarageScreen(),
                      );
                    },
                    label: const Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF03192A),
                      elevation: 4,
                      shadowColor: Color.fromARGB(5, 0, 0, 0),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      shape: const StadiumBorder(),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
              
            ),
            
            const SizedBox(height: 24),

            Container(
              decoration: BoxDecoration(
                //color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(5, 0, 0, 0),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: 
                Form(
                  key: _nameFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  child:
                ExpansionTile(
                  backgroundColor: Color(0xFFF2F4F7),
                  collapsedBackgroundColor: Color(0xFFF2F4F7),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide.none, // Прибирає межі
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide.none,
                  ),

                  splashColor: Colors.transparent,

                  initiallyExpanded: true,
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),

                  leading: const Icon(
                    Icons.person_outline,
                    color: Color(0xFF191C1E),
                    size: 16,
                  ),
                  title: const Text(
                    'Edit Personal Info',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF191C1E),
                    ),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF191C1E),
                  ),

                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: ChangeInputDecorations.standard(
                        hintText: 'Change name...',
                        icon: Icons.edit_outlined,
                      ),
                      onChanged: (text) {
                        if (_isNameSubmitted) {
                          setState(() => _isNameSubmitted = false);
                        }
                      },
                      validator: (value) {
                        if (!_isNameSubmitted) return null;
                        if (value == null || value.trim().isEmpty) {
                          return 'The name cannot be empty';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    ElevatedButton(
                        onPressed: _isNameLoading ? null : _updateName,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: const Color(0xFF03192A),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      child: _isNameLoading
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                          )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [

                                Icon(Icons.check_circle_outline,
                                color: Colors.white,),

                                SizedBox(width: 8,),

                                Text(
                                  'Apply Changes',
                                  style: TextStyle(color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                                ),
                              ],
                            )
                    ),


                    /*ListTile(
                      onTap: () => _confirmSignOut(context),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      tileColor: const Color(0xFFF1F4F6),
                      leading: const Icon(Icons.edit_outlined, color: Color(0xFF0F2439)),
                      title: const Text("Змінити ім'я", style: TextStyle(fontWeight: FontWeight.w600)),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFF94A3B8)),
                    ),*/

                  ],
                ),

                ),
              ),
            ),

             const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                //color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(5, 0, 0, 0),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: Form(
                  key: _passwordFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  child:
                  ExpansionTile(
                  backgroundColor: Color(0xFFF2F4F7),
                  collapsedBackgroundColor: Color(0xFFF2F4F7),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide.none, // Прибирає межі
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide.none,
                  ),

                  splashColor: Colors.transparent,

                  initiallyExpanded: true,
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),

                  leading: const Icon(
                    Icons.lock_outline,
                    color: Color(0xFF191C1E),
                    size: 16,
                  ),
                  title: const Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF191C1E),
                    ),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF191C1E),
                  ),
                  children: [

                    TextFormField(
                      controller: _currentPasswordController,
                      obscureText: _obscureCurrentPassword,
                      textInputAction: TextInputAction.done,
                      decoration: ChangeInputDecorations.standard(
                        hintText: 'Enter current password...',
                        icon: Icons.lock_reset,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureCurrentPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: const Color(0xFF64748B),
                            size: 20,
                          ),
                          onPressed: () => setState(() => _obscureCurrentPassword = !_obscureCurrentPassword),
                        ),
                      ),
                      onChanged: (value){
                        if (_currentPasswordError != null) {
                          setState(() {
                            _currentPasswordError = null;
                          });
                        }
                        if (_isPasswordSubmitted) {
                          setState(() => _isPasswordSubmitted = false);
                        }
                      },
                      validator: (value) {
                        if (!_isPasswordSubmitted) return null;
                        if (value == null || value.isEmpty) {
                          return 'Enter password';
                        }
                        if (value.length < 8) {
                          return 'Password should be at least 8 symbols';
                        }
                        if (_currentPasswordError != null){
                          return _currentPasswordError;
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),
                    
                    TextFormField(
                      controller: _newPasswordController,
                      obscureText: _obscureNewPassword,
                      textInputAction: TextInputAction.done,
                      decoration: ChangeInputDecorations.standard(
                        hintText: 'Enter new password...',
                        icon: Icons.lock_reset,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureNewPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: const Color(0xFF64748B),
                            size: 20,
                          ),
                          onPressed: () => setState(() => _obscureNewPassword = !_obscureNewPassword),
                        ),
                      ),
                      onChanged: (text) {
                        if (_isPasswordSubmitted) {
                          setState(() => _isPasswordSubmitted = false);
                        }
                      },
                      validator: (value) {
                        if (!_isPasswordSubmitted) return null;
                        if (value == null || value.isEmpty) {
                          return 'Enter new password';
                        }
                        if (value.length < 8) {
                          return 'Password should be at least 8 symbols';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    /*CustomButton(
                      text: 'Change Password',
                      bgColor: Color(0xFF03192A),
                      textColor: Color(0xFFFFFFFF),
                      icon: Icons.check_circle_outline,
                      isIconOnEnd: false,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Password succesfully changed!')),
                        );
                      },
                    ),*/

                    ElevatedButton(
                        onPressed: _isPasswordLoading ? null : _updatePassword,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: const Color(0xFF03192A),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      child: _isNameLoading
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                          )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [

                                Icon(Icons.check_circle_outline,
                                color: Colors.white,),

                                SizedBox(width: 8,),

                                Text(
                                  'Change Password',
                                  style: TextStyle(color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                                ),
                              ],
                            )
                    ),
                  ],
                ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => _confirmSignOut(context),
                icon: const Icon(Icons.logout_rounded, color: Color(0xFFEF4444), size: 20),
                label: const Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFEF4444),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFEE2E2), // М'який світло-червоний фон
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            /*CustomButton(
              text: 'Log out',
              isOutlined: false,
              icon: Icons.logout,
              isIconOnEnd: false,
              bgColor: Color(0xFFFFDAD6),
              textColor: Color(0xFF93000A),

              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),*/
          ],
        ),
          );
        },
    ),
    );
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            'Logging Out',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F2439),
            ),
          ),
          content: const Text(
            'Are you sure you want to Log Out?',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('No', style: TextStyle(color: Color(0xFF64748B))),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444), // Червоний колір для деструктивної дії
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Yes', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      await AuthRepository().signOut();

      // Очищаємо всі відкриті екрани та скидаємо стек до кореня
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const AuthGate()), 
          // або прямо на SignInScreen() / LoginScreen()
          (route) => false,
        );
      }
    }
  }
}