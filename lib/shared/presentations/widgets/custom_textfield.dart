import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget icon;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: icon,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
