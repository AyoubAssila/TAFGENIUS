import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      color: const Color(0xFF06112A),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: 30,
            alignment: WrapAlignment.center,
            children: const [
              Text("Contact", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("Legal Notice", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("Useful Links", style: TextStyle(color: Colors.white, fontSize: 16)),
              Text("Social Media", style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "AFTGENIUS - Your Excellence Training Partner",
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
