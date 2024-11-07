import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:thechnical_assignment_tots/presentation/shared/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        if (await storage.containsKey(key: dotenv.env['TOKEN_VALUE'] ?? '')) {
          if (mounted) {
            context.go('/clients');
          }
        } else {
          if (mounted) {
            context.go('/login');
          }
        }
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeIn(
        duration: const Duration(seconds: 2),
        child: Center(
          child: Image.asset(
            Res.images.logo,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
