import 'package:flutter/material.dart';
import '../../models/candidate.dart';
import '../../blockchain/voting_contract.dart';
import '../../backend/api_service.dart';

class VotingProvider extends ChangeNotifier {
  final VotingContract _contract = VotingContract();
  final ApiService _apiService = ApiService();

  List<Candidate> candidates = [];
  bool loading = false;

  Future<void> loadCandidates() async {
    loading = true;
    notifyListeners();

    final data = await _contract.getCandidates();
    candidates = data.map((e) => Candidate.fromBlockchain(e)).toList();

    loading = false;
    notifyListeners();
  }

  Future<void> vote(int candidateId) async {
    await _apiService.submitVote(candidateId);
    await loadCandidates();
  }
}
