import 'package:flutter/material.dart';

class WhatWeOfferSection extends StatelessWidget {
  const WhatWeOfferSection({super.key});

  @override
  Widget build(BuildContext context) {
    final offers = [
      {
        'icon': Icons.lightbulb_outline,
        'title': 'Innovative Ideas',
        'desc': 'We bring creative solutions to help you stand out in the market.'
      },
      {
        'icon': Icons.speed,
        'title': 'Fast Performance',
        'desc': 'Our platform is optimized for speed and smooth user experience.'
      },
      {
        'icon': Icons.security,
        'title': 'Secure & Reliable',
        'desc': 'Your data is safe with enterprise-grade security measures.'
      },
      {
        'icon': Icons.support_agent,
        'title': '24/7 Support',
        'desc': 'Get instant help whenever you need it with our support team.'
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'What We Offer',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: offers.map((offer) {
              return Container(
                width: 260,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(offer['icon'] as IconData,
                        size: 48, color: Colors.blueAccent),
                    const SizedBox(height: 15),
                    Text(
                      offer['title'] as String,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      offer['desc'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
