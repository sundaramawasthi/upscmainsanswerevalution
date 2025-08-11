import 'package:flutter/material.dart';
import '../screen/admin.dart';
import '../screen/home.dart';

class OtpLoginScreen extends StatefulWidget {
  const OtpLoginScreen({super.key});

  @override
  State<OtpLoginScreen> createState() => _OtpLoginScreenState();
}

class _OtpLoginScreenState extends State<OtpLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool otpSent = false;
  String generatedOtp = '123456'; // Set a dummy OTP

  void sendOtp() {
    final phone = _phoneController.text.trim();

    if (phone.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 10-digit phone number')),
      );
      return;
    }

    // Simulate sending OTP
    setState(() {
      otpSent = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('OTP sent to $phone')),
    );
  }

  void verifyOtp() {
    final enteredOtp = _otpController.text.trim();

    if (enteredOtp == generatedOtp) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Login')),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              if (otpSent)
                TextField(
                  controller: _otpController,
                  decoration: const InputDecoration(
                    labelText: 'Enter OTP',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: otpSent ? verifyOtp : sendOtp,
                child: Text(otpSent ? 'Verify OTP' : 'Send OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
