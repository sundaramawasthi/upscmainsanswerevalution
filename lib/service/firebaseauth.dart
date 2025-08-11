import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  String? verificationId;
  bool otpSent = false;
  bool loading = false;

  void sendOTP() async {
    setState(() => loading = true);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${phoneController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        setState(() => loading = false);
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification failed: ${e.message}')),
        );
      },
      codeSent: (String id, int? resendToken) {
        setState(() {
          loading = false;
          otpSent = true;
          verificationId = id;
        });
      },
      codeAutoRetrievalTimeout: (String id) {
        verificationId = id;
      },
    );
  }

  void verifyOTP() async {
    setState(() => loading = true);
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: otpController.text,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP verification failed')),
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login via OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (!otpSent)
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  prefixText: "+91 ",
                ),
              ),
            if (otpSent)
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Enter OTP"),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () {
                if (!otpSent) {
                  sendOTP();
                } else {
                  verifyOTP();
                }
              },
              child: Text(loading
                  ? "Please wait..."
                  : otpSent
                  ? "Verify OTP"
                  : "Send OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
