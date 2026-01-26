import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'voting_provider.dart';

class VoteScreen extends StatelessWidget {
  const VoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cast Your Vote")),
      body: Consumer<VotingProvider>(
        builder: (context, provider, _) {
          // ⏳ Loading
          if (provider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ✅ USER ALREADY VOTED (BLOCKCHAIN REVERT)
          if (provider.error != null &&
              provider.error!.contains("Already voted")) {
            return const Center(
              child: Text(
                "✅ You have already voted.\nThank you for participating!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          // ❌ ANY OTHER ERROR (HIDDEN RAW RPC)
          if (provider.error != null) {
            return const Center(
              child: Text(
                "❌ Transaction failed",
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          // 📭 No candidates
          if (provider.candidates.isEmpty) {
            return const Center(child: Text("No candidates available"));
          }

          // 🗳️ Candidate list
          return ListView.builder(
            itemCount: provider.candidates.length,
            itemBuilder: (context, index) {
              final candidate = provider.candidates[index];

              return ListTile(
                title: Text(candidate.name),
                subtitle: Text("Votes: ${candidate.voteCount}"),
                trailing: ElevatedButton(
                  onPressed: provider.loading
                      ? null
                      : () {
                          provider.vote(index);
                        },
                  child: const Text("Vote"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
