import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/clock_provider.dart';

class DigitalClock extends StatelessWidget {
  const DigitalClock({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClockProvider>(
      builder: (context, provider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.formattedTime,
              style: TextStyle(
                fontSize: 60.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.w,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              provider.formattedDate,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.w,
              ),
            ),
          ],
        );
      },
    );
  }
}
