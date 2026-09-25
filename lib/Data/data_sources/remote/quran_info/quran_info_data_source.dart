import 'package:islamic/api/Models/response/quran_info/quran_info_dto.dart';

abstract class QuranInfoRemoteDataSource {
  Future<QuranInfoDto> getQuranInfo();
}
