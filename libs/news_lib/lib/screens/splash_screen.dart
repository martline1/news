import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:news_lib/widgets/screen_message.dart';

class SplashScreen extends StatefulWidget {
  final String redirectTo;

  const SplashScreen({
    super.key,
    required this.redirectTo,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool visible = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        visible = true;
      });
    });

    Future.delayed(const Duration(seconds: 5), () {
      context.go(widget.redirectTo);
    });

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.amber[300]!,
              Colors.amber[900]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: visible ? 1.0 : 0.0,
            child: const ScreenMessage(
              icon: Icons.newspaper,
              label: 'Flutter News',
              iconColor: Colors.white,
              labelColor: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
