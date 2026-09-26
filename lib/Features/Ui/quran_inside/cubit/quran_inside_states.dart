import 'package:islamic/Domain/entities/response/quran_verses/quran_verses.dart';

abstract class QuranInsideStates {}

class QuranInsideInitialState extends QuranInsideStates {}

class QuranInsideLoadingState extends QuranInsideStates {}

class QuranInsideErrorState extends QuranInsideStates {
  final String errorMsg;

  QuranInsideErrorState({required this.errorMsg});
}

class QuranInsideSuccessState extends QuranInsideStates {
  final QuranVerses quranVerses;

  QuranInsideSuccessState({required this.quranVerses});
}
