import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:participant/models/participant_data.dart';

class ParticipantDataSourceService {
  Future<List<ParticipantData>> fetchData({int page = 1, int limit = 10, String? searchBy}) async {
    try {
      final String jsonString = await rootBundle.loadString('assets/sample.json');
      final List<dynamic> responseData = json.decode(jsonString);

      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;
      final paginatedData = responseData.sublist(startIndex, endIndex);

      final List<ParticipantData> filteredData = paginatedData.map((json) => ParticipantData.fromJson(json)).where((participant) {
        if (searchBy == null || searchBy.isEmpty) {
          return true;
        } else {
          final searchLower = searchBy.toLowerCase();
          return participant.firstName.toLowerCase().contains(searchLower) ||
              participant.lastName.toLowerCase().contains(searchLower) ||
              participant.participantId.toLowerCase().contains(searchLower) ||
              participant.state.toLowerCase().contains(searchLower);
        }
      }).toList();      
      return filteredData;
    } catch (error) {
      throw Exception(
        'Error: $error',
      );
    }
  }
}
