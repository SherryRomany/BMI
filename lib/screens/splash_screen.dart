import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  bool _showLogo = false;
  bool _showAppName = false;
  bool _showNames = false;
  bool _showTapPrompt = false;
  bool _canNavigate = false;

  @override
  void initState() {
    super.initState();

    // Sequence the animations
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _showLogo = true;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() {
          _showAppName = true;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 4000), () {
      if (mounted) {
        setState(() {
          _showNames = true;
        });
      }
    });

    // Show "Tap to continue" prompt after all elements are visible
    Future.delayed(const Duration(milliseconds: 5500), () {
      if (mounted) {
        setState(() {
          _showTapPrompt = true;
          _canNavigate = true;  // Now user can navigate
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: InkWell(  // Changed from GestureDetector to InkWell for better feedback
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (_canNavigate) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // University Logo with animation
                AnimatedOpacity(
                  opacity: _showLogo ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeInOut,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 1200),
                    transform: _showLogo
                        ? Matrix4.identity()
                        : Matrix4.identity()..translate(0.0, -50.0),
                    child: Image.asset(
                      'assets/images/ECU-Logo.png',
                      height: 150,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // App Name with animation
                AnimatedOpacity(
                  opacity: _showAppName ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1200),
                  child: AnimatedContainer(
                    width: double.infinity,
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 1200),
                    transform: _showAppName
                        ? Matrix4.identity()
                        : Matrix4.identity()..translate(0.0, 0.0),
                    child: Text(
                      "BMI Calculator",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),

                // Team Members with animation
                AnimatedOpacity(
                  opacity: _showNames ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1200),
                  child: AnimatedContainer(
                    width: double.infinity,
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 1200),
                    transform: _showNames
                        ? Matrix4.identity()
                        : Matrix4.identity()..translate(0.0, 30.0),
                    child: Column(
                      children: [
                        Text(
                          "Developed by:",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Sherry • George • Mahmoud",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Tap to continue prompt
                const SizedBox(height: 80),
                AnimatedOpacity(
                  opacity: _showTapPrompt ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    "Tap anywhere to continue",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}