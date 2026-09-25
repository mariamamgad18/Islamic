import 'package:injectable/injectable.dart';
import 'package:islamic/api/Mappers/quran_info_mapper.dart';

import '../../../Domain/entities/response/quran_info/quran_info.dart';
import '../../../Domain/repositories/quran_info/quran_info_repository.dart';
import '../../data_sources/remote/quran_info/quran_info_data_source.dart';

@Injectable(as: QuranInfoRepository)
class QuranInfoRepositoryImpl implements QuranInfoRepository {
  final QuranInfoRemoteDataSource remoteDataSource;

  QuranInfoRepositoryImpl(this.remoteDataSource);

  @override
  Future<QuranInfo> getQuranInfo() async {
    final quranInfoDto = await remoteDataSource.getQuranInfo();

    return quranInfoDto.toQuranInfo();
  }
}
