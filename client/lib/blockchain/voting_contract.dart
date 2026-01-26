import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

import '../config/env.dart';

// ✅ Conditional import (web vs non-web)
import 'voting_contract_stub.dart'
    if (dart.library.html) 'voting_contract_web.dart';

class VotingContract {
  late Web3Client _client;
  late DeployedContract _contract;

  VotingContract() {
    _client = Web3Client(Env.rpcUrl, Client());
    _contract = DeployedContract(
      ContractAbi.fromJson(_abi, 'Voting'),
      EthereumAddress.fromHex(Env.contractAddress),
    );
  }

  // ==================================================
  // ✅ THIS METHOD WAS MISSING (FIXES YOUR ERROR)
  // ==================================================
  Future<List<List<dynamic>>> getCandidates() async {
    final countFn = _contract.function('getCandidatesCount');
    final getFn = _contract.function('getCandidate');

    final countResult = await _client.call(
      contract: _contract,
      function: countFn,
      params: [],
    );

    final count = (countResult.first as BigInt).toInt();
    final List<List<dynamic>> result = [];

    for (int i = 0; i < count; i++) {
      final candidate = await _client.call(
        contract: _contract,
        function: getFn,
        params: [BigInt.from(i)],
      );
      result.add(candidate);
    }

    return result;
  }

  // ==================================================
  // WRITE → MetaMask (Flutter Web only)
  // ==================================================
  Future<void> vote(int candidateIndex) async {
    final accounts = await VotingContractWeb.requestAccounts();
    final from = accounts.first;

    final data = _encodeVoteData(candidateIndex);

    await VotingContractWeb.sendTransaction(
      from: from,
      to: Env.contractAddress,
      data: data,
    );
  }

  // vote(uint256)
  String _encodeVoteData(int index) {
    const selector = '0x0121b93f'; // keccak256("vote(uint256)")
    final value = index.toRadixString(16).padLeft(64, '0');
    return selector + value;
  }
}

// ==================================================
// ABI (READ ONLY)
// ==================================================
const String _abi = '''
[
  {
    "inputs": [],
    "name": "getCandidatesCount",
    "outputs": [{ "type": "uint256" }],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [{ "type": "uint256", "name": "index" }],
    "name": "getCandidate",
    "outputs": [
      { "type": "string" },
      { "type": "uint256" }
    ],
    "stateMutability": "view",
    "type": "function"
  }
]
''';
