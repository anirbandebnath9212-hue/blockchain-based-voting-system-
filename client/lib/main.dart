import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/voting/voting_provider.dart';
import 'app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => VotingProvider()..loadCandidates(),
      child: const MyApp(),
    ),
  );
}
