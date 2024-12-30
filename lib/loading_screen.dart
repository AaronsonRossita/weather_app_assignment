import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.teal.withOpacity(0.5),
              ),
            ),
            Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade900),
                  strokeWidth: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
