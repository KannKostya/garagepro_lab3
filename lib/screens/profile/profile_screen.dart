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

  static const List<String> _presetAvatars = [
    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=256&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=256&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=256&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=256&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=256&auto=format&fit=crop&q=80',
  ];
  
  late final TextEditingController _photoUrlController;

  String? _currentPhotoUrl; // Збережене фото в профілі

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    _nameController = TextEditingController(text: currentUser?.displayName ?? '');
    _currentPhotoUrl = currentUser?.photoURL;
    _photoUrlController = TextEditingController(text: currentUser?.photoURL ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _photoUrlController.dispose();
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
        stream: FirebaseAuth.instance.userChanges(),
        initialData: FirebaseAuth.instance.currentUser,
        builder: (context, snapshot) {
          final user = snapshot.data ?? authRepo.currentUser;

          if (user == null) {
            return const Center(child: Text('User is not authorised'));
          }

          final String displayName = user.displayName?.trim().isNotEmpty == true
              ? user.displayName!
              : 'GaragePro User';
          final String email = user.email ?? 'Unknown eMail';

          final photoUrl = user.photoURL;

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
            child: GestureDetector(
              onTap: () => _showChangePhotoSheet(photoUrl),
              child: CircleAvatar(
                radius: 48,
                backgroundColor: const Color(0xFFE2EAF4),
                child: (photoUrl != null && photoUrl.startsWith('https://'))
                    ? ClipOval(
                        child: Image.network(
                          photoUrl,
                          key: ValueKey(photoUrl), // Примусово перемальовує при зміні URL
                          width: 96,
                          height: 96,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.person,
                            size: 48,
                            color: Color(0xFF0F2439),
                          ),
                        ),
                      )
                    : const Icon(Icons.person, size: 48, color: Color(0xFF0F2439)),
              ),
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

      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const AuthGate()), 
          
          (route) => false,
        );
      }
    }
  }

  void _showChangePhotoSheet(String? currentPhotoUrl) {
    final formKey = GlobalKey<FormState>();
    final urlController = TextEditingController(text: currentPhotoUrl ?? '');
    String? previewUrl = currentPhotoUrl;
    bool isSaving = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setSheetState) {
            Future<void> handleSave() async {
              if (!formKey.currentState!.validate()) return;

              final newUrl = urlController.text.trim();
              setSheetState(() => isSaving = true);

              try {
                // Після reload() StreamBuilder миттєво оновить аватар на сторінці
                await authRepo.updatePhotoUrl(newUrl);

                if (sheetContext.mounted) {
                  Navigator.pop(sheetContext);
                }
                if (mounted) {
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile photo is succesfully changed!'),
                    ),
                  );
                }
              } catch (e) {
                setSheetState(() => isSaving = false);
                if (mounted) {
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            }

            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                // Відступ знизу враховує висоту екранної клавіатури
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Декоративний індикатор зверху модального вікна
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFCBD5E1),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Profile photo change',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F2439),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Попередній перегляд обраного/введеного фото
                    Center(
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: const Color(0xFFE2EAF4),
                        child: (previewUrl != null && previewUrl!.startsWith('https://'))
                            ? ClipOval(
                                child: Image.network(
                                  previewUrl!,
                                  width: 88,
                                  height: 88,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.broken_image_outlined,
                                    size: 36,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              )
                            : const Icon(Icons.person, size: 44, color: Color(0xFF0F2439)),
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Choose a photo',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Горизонтальний набір готових зображень
                    SizedBox(
                      height: 60,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _presetAvatars.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (_, index) {
                          final avatarUrl = _presetAvatars[index];
                          final isSelected = previewUrl == avatarUrl;

                          return GestureDetector(
                            onTap: () {
                              setSheetState(() {
                                previewUrl = avatarUrl;
                                urlController.text = avatarUrl;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF0F2439)
                                      : Colors.transparent,
                                  width: 2.5,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 26,
                                backgroundColor: const Color(0xFFE2EAF4),
                                backgroundImage: NetworkImage(avatarUrl),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Поле для власного HTTPS-посилання
                    TextFormField(
                      controller: urlController,
                      keyboardType: TextInputType.url,
                      decoration: EnterInputDecorations.standard(
                        hintText: 'Or put a HTTPS-link',
                        icon: Icons.link_rounded,
                        suffixIcon: urlController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, size: 18, color: Color(0xFF64748B)),
                                onPressed: () {
                                  setSheetState(() {
                                    urlController.clear();
                                    previewUrl = _currentPhotoUrl;
                                  });
                                },
                              )
                            : null,
                      ),
                      onChanged: (value) {
                        setSheetState(() {
                          previewUrl = value.trim();
                        });
                      },
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Choose a photo prom the list above or put a photo link';
                        }
                        final trimmed = val.trim();
                        final uri = Uri.tryParse(trimmed);
                        if (uri == null ||
                            !uri.hasScheme ||
                            uri.scheme != 'https' ||
                            uri.host.isEmpty) {
                          return 'The link must start with "https://"';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Кнопки дій
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: isSaving ? null : () => Navigator.pop(sheetContext),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(48),
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Color(0xFF64748B)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isSaving ? null : handleSave,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(48),
                              backgroundColor: const Color(0xFF0F2439),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: isSaving
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Save',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      // Безпечно звільняємо контролер після закриття вікна
      urlController.dispose();
    });
  }
}