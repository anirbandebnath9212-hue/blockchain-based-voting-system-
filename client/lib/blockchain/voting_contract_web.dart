// ONLY USED ON FLUTTER WEB

import 'dart:js' as js;

/// Web-only MetaMask helper
class VotingContractWeb {
  /// Request connected MetaMask accounts
  static Future<List<String>> requestAccounts() async {
    final result = js.context.callMethod(
      'eval',
      [
        '''
        ethereum.request({ method: 'eth_requestAccounts' })
        '''
      ],
    );

    // result is a JS Promise → MetaMask injects array
    return List<String>.from(result as List);
  }

  /// Send transaction via MetaMask
  static Future<void> sendTransaction({
    required String from,
    required String to,
    required String data,
  }) async {
    js.context.callMethod(
      'eval',
      [
        '''
        ethereum.request({
          method: 'eth_sendTransaction',
          params: [{
            from: "$from",
            to: "$to",
            data: "$data"
          }]
        })
        '''
      ],
    );
  }
}
