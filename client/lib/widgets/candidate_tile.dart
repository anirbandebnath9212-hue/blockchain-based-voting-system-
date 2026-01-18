import 'package:flutter/material.dart';
import '../models/candidate.dart';

class CandidateTile extends StatelessWidget {
  final Candidate candidate;
  final VoidCallback onVote;

  const CandidateTile({
    super.key,
    required this.candidate,
    required this.onVote,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(candidate.name),
        subtitle: Text("Votes: ${candidate.voteCount}"),
        trailing: ElevatedButton(
          onPressed: onVote,
          child: const Text("Vote"),
        ),
      ),
    );
  }
}
