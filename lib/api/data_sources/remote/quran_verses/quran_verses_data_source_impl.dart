import 'package:injectable/injectable.dart';
import 'package:islamic/api/Models/response/quran_verses/quran_verses_dto.dart';
import 'package:islamic/api/api_services.dart';

import '../../../../Data/data_sources/remote/quran_verses/quran_verses_data_source.dart';

@Injectable(as: QuranVersesRemoteDataSource)
class QuranVersesRemoteDataSourceImpl implements QuranVersesRemoteDataSource {
  final QuranApiServices apiServices;

  QuranVersesRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<QuranVersesDto> getVersesByChapter(int chapterId) async {
    final response = await apiServices.getVersesByChapter(chapterId);

    return response.data;
  }
}
