import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'voting_provider.dart';
import '../../widgets/candidate_tile.dart';

class VoteScreen extends StatelessWidget {
  const VoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VotingProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Cast Your Vote")),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.candidates.length,
              itemBuilder: (_, index) {
                return CandidateTile(
                  candidate: provider.candidates[index],
                  onVote: () =>
                      provider.vote(provider.candidates[index].id),
                );
              },
            ),
    );
  }
}
