import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:islamic/Domain/entities/response/quran_info/chapter.dart';
import 'package:islamic/Domain/use_case/quran_info/get_quran_info_use_case.dart';

import 'quran_info_states.dart';

@injectable
class QuranInfoViewModel extends Cubit<QuranInfoStates> {
  final GetQuranInfoUseCase getQuranInfoUseCase;

  QuranInfoViewModel({required this.getQuranInfoUseCase})
    : super(QuranInfoInitialState());

  Future<void> getQuranInfo() async {
    emit(QuranInfoLoadingState());

    try {
      final quranInfo = await getQuranInfoUseCase();

      emit(QuranInfoSuccessState(quranInfo: quranInfo));
    } catch (e, stackTrace) {
      print('================ QURAN ERROR ================');
      print(e);
      print(stackTrace);
      print('==============================================');

      emit(QuranInfoErrorState(errorMsg: e.toString()));
    }
  }

  List<Chapter> filterChapters({
    required List<Chapter> chapters,
    required int selectedIndex,
    String searchText = '',
  }) {
    List<Chapter> filteredList;

    if (selectedIndex == 0) {
      // مكية
      filteredList =
          chapters
              .where(
                (chapter) => chapter.revelationPlace.toLowerCase() == 'makkah',
              )
              .toList();
    } else if (selectedIndex == 1) {
      // مدنية
      filteredList =
          chapters
              .where(
                (chapter) => chapter.revelationPlace.toLowerCase() == 'madinah',
              )
              .toList();
    } else {
      // الكل
      filteredList = List<Chapter>.from(chapters);
    }

    // Search
    final query = searchText.trim().toLowerCase();

    if (query.isNotEmpty) {
      filteredList =
          filteredList.where((chapter) {
            return chapter.nameArabic.toLowerCase().contains(query) ||
                chapter.nameSimple.toLowerCase().contains(query) ||
                chapter.translatedName.name.toLowerCase().contains(query);
          }).toList();
    }

    return filteredList;
  }
}
