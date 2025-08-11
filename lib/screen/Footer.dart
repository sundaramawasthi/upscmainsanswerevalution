import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          Text(
            'SaaS Landing Page',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 20,
            children: [
              _footerLink('Home'),
              _footerLink('Features'),
              _footerLink('About'),
              _footerLink('Contact'),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIcon(Icons.facebook),
              _socialIcon(Icons.linked_camera),
              _socialIcon(Icons.email),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '© 2025 SaaS Landing Page. All rights reserved.',
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _footerLink(String title) {
    return InkWell(
      onTap: () {},
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }
}
