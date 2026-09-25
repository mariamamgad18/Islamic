import 'package:islamic/Domain/entities/response/quran_info/quran_info_data.dart';

class QuranInfo {
  final int code;
  final String status;
  final QuranInfoData data;

  QuranInfo({required this.code, required this.status, required this.data});
}
