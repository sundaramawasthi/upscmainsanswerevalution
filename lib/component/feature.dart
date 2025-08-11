import 'dart:ui';
import 'package:flutter/material.dart';
import '../model/evalutionScreen.dart';
import '../screen/theame.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Column(
        children: [
          const Text(
            "Features",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Everything you need is here!",
            style: TextStyle(fontSize: 18, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 3;
              double maxWidth = constraints.maxWidth;

              if (maxWidth < 600) {
                crossAxisCount = 1;
              } else if (maxWidth < 900) {
                crossAxisCount = 2;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  childAspectRatio: 1.3,
                ),
                itemCount: features.length,
                itemBuilder: (context, index) {
                  final feature = features[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => feature["page"]),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 10,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                feature["icon"]!,
                                style: const TextStyle(fontSize: 44),
                              ),
                              const SizedBox(height: 18),
                              Text(
                                feature["title"]!,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: Text(
                                  feature["description"]!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// === Editable Feature List ===
// You can add/remove/edit features here, and set a unique page for each
final List<Map<String, dynamic>> features = [
  {
    "icon": "📊",
    "title": "Submit answer",
    "description": "View detailed statistics and performance metrics.",
    "page": const UploadAndEvaluatePage(),
  },
  {
    "icon": "📄",
    "title": "Reports",
    "description": "Generate, download, and share reports instantly.",
    "page": const ReportsPage(),
  },
  {
    "icon": "⚙️",
    "title": "Settings",
    "description": "Personalize and configure your application settings.",
    "page": const SettingsPage(),
  },
];

// === Example Pages ===
class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Analytics")),
      body: const Center(child: Text("Analytics Page")),
    );
  }
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reports")),
      body: const Center(child: Text("Reports Page")),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: const Center(child: Text("Settings Page")),
    );
  }
}
