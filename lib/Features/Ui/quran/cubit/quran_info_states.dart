import 'package:islamic/Domain/entities/response/quran_info/quran_info.dart';

abstract class QuranInfoStates {}

class QuranInfoInitialState extends QuranInfoStates {}

class QuranInfoLoadingState extends QuranInfoStates {}

class QuranInfoErrorState extends QuranInfoStates {
  final String errorMsg;

  QuranInfoErrorState({required this.errorMsg});
}

class QuranInfoSuccessState extends QuranInfoStates {
  final QuranInfo quranInfo;

  QuranInfoSuccessState({required this.quranInfo});
}
