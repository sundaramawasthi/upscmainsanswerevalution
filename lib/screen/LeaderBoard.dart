import 'package:flutter/material.dart';

class LeaderboardSection extends StatelessWidget {
  final List<Map<String, dynamic>> leaderboardData = [
    {"name": "Alice", "score": 1200},
    {"name": "Bob", "score": 1150},
    {"name": "Charlie", "score": 1100},
    {"name": "David", "score": 1050},
    {"name": "Eve", "score": 1000},
    {"name": "Frank", "score": 950},
    {"name": "Grace", "score": 900},
    {"name": "Hank", "score": 850},
    {"name": "Ivy", "score": 800},
    {"name": "Jack", "score": 750},
  ];

  LeaderboardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Leaderboard",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 300, // Scrollable height
          child: ListView.builder(
            itemCount: leaderboardData.length,
            itemBuilder: (context, index) {
              final player = leaderboardData[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: Text(
                    "#${index + 1}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  title: Text(player["name"]),
                  trailing: Text(
                    "${player["score"]} pts",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
