import 'package:injectable/injectable.dart';
import 'package:islamic/api/Models/response/quran_info/quran_info_dto.dart';
import 'package:islamic/api/api_services.dart';

import '../../../../Data/data_sources/remote/quran_info/quran_info_data_source.dart';

@Injectable(as: QuranInfoRemoteDataSource)
class QuranInfoRemoteDataSourceImpl implements QuranInfoRemoteDataSource {
  final QuranApiServices apiServices;

  QuranInfoRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<QuranInfoDto> getQuranInfo() async {
    final response = await apiServices.getQuranInfo();

    return response.data;
  }
}
