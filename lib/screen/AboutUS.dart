// aboutUs.dart
import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 800;
          return Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'assets/images/about-us.png', // 👈 Add an image here
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 40, height: 40),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: isMobile
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "About Our Platform",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "At ADmyBRAND AI Suite, we believe that powerful technology should be accessible, intuitive, and transformative. Our mission is to empower businesses and creators with cutting-edge AI tools that streamline workflows, enhance creativity, and drive meaningful growth"
                          "Founded by passionate innovators, ADmyBRAND combines deep expertise in artificial intelligence with a user-centric design philosophy. Whether"  "you're a startup, an established company, or an individual creator, our suite offers tailored solutions to simplify complex tasks — from content generation and data analysis to automation and brand building"

                          "We are committed to continuous innovation, transparency, and customer success. Our team works tirelessly to ensure that every feature delivers real value and adapts to the evolving needs of our users"

                          "Join us on the journey to unlock your full potential with AI-powered tools designed for the future — today.",
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.6,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
