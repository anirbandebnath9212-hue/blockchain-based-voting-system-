class Candidate {
  final String name;
  final int voteCount;

  Candidate({
    required this.name,
    required this.voteCount,
  });

  factory Candidate.fromBlockchain(List<dynamic> data) {
    return Candidate(
      name: data[0] as String,                 // ✅ "Alice"
      voteCount: (data[1] as BigInt).toInt(),  // ✅ BigInt → int
    );
  }
}
