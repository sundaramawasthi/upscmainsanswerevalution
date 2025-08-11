import 'package:flutter/material.dart';

class FAQSection extends StatefulWidget {
  const FAQSection({Key? key}) : super(key: key);

  @override
  State<FAQSection> createState() => _FAQSectionState();
}

class _FAQSectionState extends State<FAQSection> {
  final List<FAQItem> _faqs = const [
    FAQItem(
        question: "How does ADmyBRAND AI Suite work?",
        answer:
        "Our AI analyzes your marketing data and provides actionable insights tailored to your campaigns."),
    FAQItem(
        question: "Can I upgrade my plan later?",
        answer:
        "Yes, you can upgrade or downgrade your plan anytime from your account settings."),
    FAQItem(
        question: "Is there a free trial available?",
        answer:
        "We offer a 14-day free trial for new users to explore the core features."),
    FAQItem(
        question: "How do I contact support?",
        answer:
        "You can contact our support team via email, chat, or phone anytime."),
  ];

  final List<bool> _expanded = [];

  @override
  void initState() {
    super.initState();
    _expanded.addAll(List.filled(_faqs.length, false));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _faqs.length,
            itemBuilder: (context, index) {
              final faq = _faqs[index];
              final isExpanded = _expanded[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ExpansionTile(
                  initiallyExpanded: isExpanded,
                  title: Text(
                    faq.question,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(faq.answer),
                    ),
                  ],
                  onExpansionChanged: (expanded) {
                    setState(() {
                      _expanded[index] = expanded;
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  const FAQItem({required this.question, required this.answer});
}
