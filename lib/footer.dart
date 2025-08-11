import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[900],
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        children: const [
          Text("© 2025 R_SGyan • Made with ❤️ for UPSC Aspirants", style: TextStyle(color: Colors.white70)),
          SizedBox(height: 6),
          Text("Terms • Privacy • Contact", style: TextStyle(color: Colors.white38, fontSize: 12)),
        ],
      ),
    );
  }
}
