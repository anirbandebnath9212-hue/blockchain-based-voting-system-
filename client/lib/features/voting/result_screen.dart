import 'package:flutter/material.dart';
import '../../models/candidate.dart';

class ResultScreen extends StatelessWidget {
  final List<Candidate> candidates;

  const ResultScreen({super.key, required this.candidates});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Results")),
      body: ListView(
        children: candidates
            .map(
              (c) => ListTile(
                title: Text(c.name),
                trailing: Text("Votes: ${c.voteCount}"),
              ),
            )
            .toList(),
      ),
    );
  }
}
