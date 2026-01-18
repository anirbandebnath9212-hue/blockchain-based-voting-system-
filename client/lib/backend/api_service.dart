import 'package:http/http.dart' as http;
import '../config/env.dart';

class ApiService {
  Future<void> submitVote(int candidateId) async {
    final response = await http.post(
      Uri.parse('${Env.backendBaseUrl}/vote'),
      body: {
        'candidateId': candidateId.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Vote submission failed');
    }
  }
}
