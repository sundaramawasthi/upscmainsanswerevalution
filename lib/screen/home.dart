import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:upscmainsweb/screen/whatweoffer.dart';
import '../component/feature.dart';
import '../footer.dart';
import 'AboutUS.dart';
import 'Contact.dart';
import 'FAQ.dart';
import 'LeaderBoard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userName =
        FirebaseAuth.instance.currentUser?.displayName ?? "Aspirant";

    return Scaffold(
      appBar: AppBar(
        title: const Text("UPSC Mains Hub"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero / Search Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.indigo.shade50,
              child: Column(
                children: [
                  Text(
                    "Welcome, $userName 👋",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search questions...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Navigate to prelims upload
                        },
                        icon: const Icon(Icons.upload_file),
                        label: const Text("Upload Prelims Answer"),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Navigate to mains upload
                        },
                        icon: const Icon(Icons.upload_file),
                        label: const Text("Upload Mains Answer"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Call Feature Screen directly here
            FeaturesSection(),
            const SizedBox(height: 20),



            WhatWeOfferSection(),
            const SizedBox(height: 20),

            LeaderboardSection(),
            FAQSection(),
            AboutSection(),
            ContactUsSection(),
            FooterSection(),



            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
