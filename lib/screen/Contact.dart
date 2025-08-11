import 'package:flutter/material.dart';

class ContactUsSection extends StatefulWidget {
  const ContactUsSection({Key? key}) : super(key: key);

  @override
  State<ContactUsSection> createState() => _ContactUsSectionState();
}

class _ContactUsSectionState extends State<ContactUsSection> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // For now, just show a success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent! We will get back soon.')),
      );
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Us',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: isMobile
                ? Column(
              children: _buildFormFields(),
            )
                : Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _nameController,
                        label: 'Name',
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: _buildTextField(
                    controller: _messageController,
                    label: 'Message',
                    maxLines: 6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: _submit,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                child: Text('Send Message', style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFormFields() => [
    _buildTextField(controller: _nameController, label: 'Name'),
    const SizedBox(height: 20),
    _buildTextField(
      controller: _emailController,
      label: 'Email',
      keyboardType: TextInputType.emailAddress,
    ),
    const SizedBox(height: 20),
    _buildTextField(
      controller: _messageController,
      label: 'Message',
      maxLines: 6,
    ),
  ];

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your $label';
        }
        if (label == 'Email' && !_validateEmail(value.trim())) {
          return 'Please enter a valid email';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(
      r'^[^@]+@[^@]+\.[^@]+',
    );
    return emailRegex.hasMatch(email);
  }
}
