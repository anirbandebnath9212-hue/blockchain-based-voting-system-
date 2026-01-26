// USED ON NON-WEB PLATFORMS (Android / iOS / Desktop)

class VotingContractWeb {
  static Future<List<String>> requestAccounts() async {
    throw UnsupportedError(
      'MetaMask is only supported on Flutter Web',
    );
  }

  static Future<void> sendTransaction({
    required String from,
    required String to,
    required String data,
  }) async {
    throw UnsupportedError(
      'MetaMask is only supported on Flutter Web',
    );
  }
}
