import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import '../config/env.dart';

final Web3Client web3client = Web3Client(
  Env.rpcUrl,
  Client(),
);
