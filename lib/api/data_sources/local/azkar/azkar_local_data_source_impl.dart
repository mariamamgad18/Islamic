import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../../../Data/data_sources/local/azkar/azkar_local_data_source.dart';
import '../../../Models/response/azkar/azkar_dto.dart';

@LazySingleton(as: AzkarLocalDataSource)
class AzkarLocalDataSourceImpl implements AzkarLocalDataSource {
  @override
  Future<List<AzkarDto>> getAzkar(String category) async {
    final jsonString = await rootBundle.loadString('assets/json/azkar.json');

    final Map<String, dynamic> jsonData = json.decode(jsonString);

    final List<dynamic> azkarList = jsonData[category];

    return azkarList.map((item) => AzkarDto.fromJson(item)).toList();
  }
}
