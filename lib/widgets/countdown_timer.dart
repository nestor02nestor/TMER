import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/clock_provider.dart';

class CountdownTimer extends StatelessWidget {
  const CountdownTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClockProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Text(
              'Countdown Timer',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.w,
              ),
            ),
            SizedBox(height: 10.h),
            if (provider.isCountdownActive)
              Text(
                provider.countdownDisplay,
                style: TextStyle(
                  fontSize: 36.sp,
                  letterSpacing: 2.w,
                ),
              )
            else
              Text(
                '00:00:00',
                style: TextStyle(
                  fontSize: 36.sp,
                  letterSpacing: 2.w,
                ),
              ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: provider.isCountdownActive
                      ? null
                      : () => _showTimePicker(context),
                  child: Text(
                    'Set Timer',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
                SizedBox(width: 10.w),
                if (provider.isCountdownActive)
                  ElevatedButton(
                    onPressed: provider.stopCountdown,
                    child: Text(
                      'Stop',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showTimePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        int hours = 0;
        int minutes = 0;
        int seconds = 0;

        return AlertDialog(
          title: Text(
            'Set Countdown Timer',
            style: TextStyle(fontSize: 18.sp),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: TextField(
                          decoration: const InputDecoration(labelText: 'Hours'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => hours = int.tryParse(value) ?? 0,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: TextField(
                          decoration: const InputDecoration(labelText: 'Minutes'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => minutes = int.tryParse(value) ?? 0,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: TextField(
                          decoration: const InputDecoration(labelText: 'Seconds'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => seconds = int.tryParse(value) ?? 0,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            TextButton(
              onPressed: () {
                int totalSeconds = (hours * 3600) + (minutes * 60) + seconds;
                if (totalSeconds > 0) {
                  Provider.of<ClockProvider>(context, listen: false)
                      .startCountdown(totalSeconds);
                }
                Navigator.pop(context);
              },
              child: Text(
                'Start',
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ],
        );
      },
    );
  }
}
