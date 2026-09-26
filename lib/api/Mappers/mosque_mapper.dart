import 'package:islamic/Domain/entities/response/nearby_mosques/mosque_entity.dart';

import '../Models/response/nearby_mosques/mosque_dto.dart';

extension MosqueMapper on MosqueDto {
  MosqueEntity toEntity() {
    return MosqueEntity(
      id: id ?? '',
      name: displayName?.text ?? 'مسجد',
      address: formattedAddress ?? 'العنوان غير متوفر',
      latitude: location?.latitude ?? 0,
      longitude: location?.longitude ?? 0,
    );
  }
}
