import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'voting_provider.dart';

class VoteScreen extends StatelessWidget {
  const VoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cast Your Vote"),
        centerTitle: true,
      ),
      body: Consumer<VotingProvider>(
        builder: (context, provider, _) {
          // 🔄 Loading
          if (provider.loading && provider.candidates.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ Error → show SnackBar
          if (provider.error != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(provider.error!),
                  backgroundColor: Colors.redAccent,
                ),
              );
              provider.error = null; // clear after showing
            });
          }

          // 📭 No candidates
          if (provider.candidates.isEmpty) {
            return const Center(child: Text("No candidates available"));
          }

          // ✅ Candidate list
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
              itemCount: provider.candidates.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final candidate = provider.candidates[index];

                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    title: Text(
                      candidate.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        "Votes: ${candidate.voteCount}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      onPressed: provider.loading
                          ? null
                          : () async {
                              await provider.vote(index);
                            },
                      child: provider.loading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text("Vote"),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
