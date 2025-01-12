import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/clock_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/digital_clock.dart';
import '../widgets/countdown_timer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Clock',
          style: TextStyle(fontSize: 20.sp),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: () => _showColorPicker(context),
          ),
        ],
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const DigitalClock(),
                    SizedBox(height: 20.h),
                    Consumer<ClockProvider>(
                      builder: (context, provider, child) {
                        return ElevatedButton(
                          onPressed: provider.toggleTimeFormat,
                          child: Text(
                            provider.is24HourFormat ? '12-Hour Format' : '24-Hour Format',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 40.h),
                    const CountdownTimer(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pick a color', style: TextStyle(fontSize: 18.sp)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _colorButton(context, Colors.blue, 'Blue'),
                _colorButton(context, Colors.red, 'Red'),
                _colorButton(context, Colors.green, 'Green'),
                _colorButton(context, Colors.purple, 'Purple'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _colorButton(BuildContext context, Color color, String name) {
    return Padding(
      padding: EdgeInsets.all(4.r),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: Size(double.infinity, 40.h),
        ),
        onPressed: () {
          Provider.of<ThemeProvider>(context, listen: false)
              .setPrimaryColor(color);
          Navigator.pop(context);
        },
        child: Text(name, style: TextStyle(fontSize: 16.sp)),
      ),
    );
  }
}
