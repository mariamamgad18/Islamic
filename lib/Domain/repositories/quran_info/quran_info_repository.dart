import 'package:islamic/Domain/entities/response/quran_info/quran_info.dart';

abstract class QuranInfoRepository {
  Future<QuranInfo> getQuranInfo();
}
