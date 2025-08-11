import 'package:flutter/material.dart';
import 'home.dart'; // Make sure this file contains your HomePage widget

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Illustration Image
              SizedBox(
                height: 300,
                child: Image.asset(
                  'assets/images/image.jpg', // Replace with your actual image
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),

              // Welcome Text
              const Text(
                'Welcome to Fresher Space',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'Explore us',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),

              const SizedBox(height: 30),

              // Register Button
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Registered Here"),
                ),
              ),

              const SizedBox(height: 15),

              // ✅ Fixed Login Button
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Login Here"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
