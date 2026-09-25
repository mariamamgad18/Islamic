import 'package:injectable/injectable.dart';
import 'package:islamic/api/Mappers/azkar_mapper.dart';

import '../../../Domain/entities/response/azkar/azkar.dart';
import '../../../Domain/repositories/azkar/azkar_repository.dart';
import '../../data_sources/local/azkar/azkar_local_data_source.dart';

@LazySingleton(as: AzkarRepository)
class AzkarRepositoryImpl implements AzkarRepository {
  final AzkarLocalDataSource localDataSource;

  AzkarRepositoryImpl(this.localDataSource);

  @override
  Future<List<Azkar>> getAzkar(String category) async {
    final azkarDto = await localDataSource.getAzkar(category);

    return azkarDto.map((dto) => dto.toDomain()).toList();
  }
}
