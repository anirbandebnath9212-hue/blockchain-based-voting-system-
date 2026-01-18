class Candidate {
  final int id;
  final String name;
  final int voteCount;

  Candidate({
    required this.id,
    required this.name,
    required this.voteCount,
  });

  factory Candidate.fromBlockchain(dynamic data) {
    return Candidate(
      id: data[0].toInt(),
      name: data[1],
      voteCount: data[2].toInt(),
    );
  }
}
