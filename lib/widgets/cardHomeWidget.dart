import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget cardHomeWidget({
  required String name,
  required String image,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 15.h),
          Expanded(
            child: Image.asset(
              image,
              width: 50.sp,
              height: 50.sp,
            ),
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    ),
  );
}
