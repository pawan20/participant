// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:participant/models/participant_data.dart';
import 'package:participant/services/participant_data_source_service.dart';
import 'package:participant/services/locator.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final _intialDataService = locator<ParticipantDataSourceService>();

  String? errorMessage;
  String _searchQuery = '';
  bool isLoading = false;
  int _currentPage = 1;
  final int _pageSize = 20;

  String get searchQuery => _searchQuery;

  final List<ParticipantData?> _participantData = [];
  List<ParticipantData?> get participantData => _participantData;

  Future<void> setSearchQuery(String value) async {
    _searchQuery = value;
    _participantData.clear();
    await fetchParticipants(page: 1, limit: 20, searchQuery: searchQuery); 
  }

  Future<void> fetchParticipants({int page = 1, int limit = 10, String? searchQuery}) async {
    errorMessage = null;
    isLoading = true;
    try {
      final data = await _intialDataService.fetchData(page: page, limit: limit, searchBy: searchQuery);

      _participantData.addAll(data);
    } catch (error) {
      errorMessage = error.toString();
      print('Error: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreData() async {
    if (isLoading) {
      return;
    }

    try {
      _currentPage++;
      await fetchParticipants(page: _currentPage, limit: _pageSize, searchQuery: searchQuery);
    } catch (error) {
      errorMessage = error.toString();
      print('Error: $error');
    }
  }
}
