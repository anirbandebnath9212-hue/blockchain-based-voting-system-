import 'package:flutter/foundation.dart';

import '../../blockchain/voting_contract.dart';
import '../../models/candidate.dart';

class VotingProvider extends ChangeNotifier {
  final VotingContract _contract = VotingContract();

  bool loading = false;
  String? error;
  List<Candidate> candidates = [];

  // -------------------------------
  // LOAD CANDIDATES
  // -------------------------------
  Future<void> loadCandidates() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      final List<List<dynamic>> data =
          await _contract.getCandidates(); // ✅ CORRECT METHOD

      candidates = data.map((e) {
        return Candidate(
          name: e[0] as String,
          voteCount: (e[1] as BigInt).toInt(),
        );
      }).toList();
    } catch (e) {
      error = e.toString();
      candidates = [];
    }

    loading = false;
    notifyListeners();
  }

  // -------------------------------
  // VOTE
  // -------------------------------
  Future<void> vote(int candidateIndex) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      await _contract.vote(candidateIndex);
      await loadCandidates();
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }
}
