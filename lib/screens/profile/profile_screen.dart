import 'package:flutter/material.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../auth/login_screen.dart';
import '../main_screen.dart';
import '../home/garage_screen.dart';

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

            const Text(
              'Kostiantyn Kann',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF191C1E),
              ),
            ),

            const Text(
              'example@driver.com',
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
                child: ExpansionTile(
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
                    _buildInputField(
                      hintText: 'Change name...',
                      onApply: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Name succesfully changed!')),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      hintText: 'Change eMail...',
                      keyboardType: TextInputType.emailAddress,
                      onApply: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('eMail succesfully changed!')),
                        );
                      },
                    ),
                  ],
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
                child: ExpansionTile(
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

                    const CustomTextField(
                      label: 'Enter old password...',
                      prefixIcon: Icons.lock_reset,
                      isPassword: true,
                      bgColor: Colors.white,
                    ),

                    const SizedBox(height: 16),

                    const CustomTextField(
                      label: 'Enter new password...',
                      prefixIcon: Icons.lock_reset,
                      isPassword: true,
                      bgColor: Colors.white,
                    ),

                    const SizedBox(height: 16),

                    CustomButton(
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
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            CustomButton(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    TextEditingController? controller,
    required String hintText,
    required VoidCallback onApply,
    TextInputType? keyboardType,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.edit_outlined,
            size: 18,
            color: Color(0xFF64748B),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF0F2439),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                filled: false,
                fillColor: Colors.transparent,
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          const SizedBox(width: 8),

          ElevatedButton(
            onPressed: onApply,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A2E40),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Apply',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}