import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:islamic/Domain/use_case/quran_verses/get_quran_verses_use_case.dart';

import 'quran_inside_states.dart';

@injectable
class QuranInsideViewModel extends Cubit<QuranInsideStates> {
  final GetQuranVersesUseCase getQuranVersesUseCase;

  QuranInsideViewModel({required this.getQuranVersesUseCase})
    : super(QuranInsideInitialState());

  Future<void> getQuranVerses(int chapterId) async {
    emit(QuranInsideLoadingState());

    try {
      final quranVerses = await getQuranVersesUseCase(chapterId);

      emit(QuranInsideSuccessState(quranVerses: quranVerses));
    } catch (e) {
      emit(QuranInsideErrorState(errorMsg: e.toString()));
    }
  }
}
