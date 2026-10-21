import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;
  final bool isIconOnEnd;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.icon,
    required this.bgColor,
    required this.textColor,
    this.isIconOnEnd = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: bgColor,
        ),
        //suffixIcon: Icon(postfixIcon, color: const Color(0xFF9CA3AF)),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            if (icon != null && !isIconOnEnd) ...[
              Icon(icon, color: textColor),
              const SizedBox(width: 4),
            ],
            
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),

            if (icon != null && isIconOnEnd) ...[
              const SizedBox(width: 4),
              Icon(icon, color: textColor),
            ],
          ]
        ),
      );
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: bgColor,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          if (icon != null && !isIconOnEnd) ...[
            Icon(icon, color: textColor),
            const SizedBox(width: 4),
          ],
          
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),

          if (icon != null && isIconOnEnd) ...[
            const SizedBox(width: 4),
            Icon(icon, color: textColor),
          ],
        ],
      ),
    );
  }
}