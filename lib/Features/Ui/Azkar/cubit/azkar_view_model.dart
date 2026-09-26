import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Domain/entities/response/azkar/azkar.dart';
import '../../../../Domain/use_case/azkar/get_azkar_use_case.dart';
import '../../../../api/Models/response/azkar/azkar_dto.dart';
import 'azkar_states.dart';

@injectable
class AzkarViewModel extends Cubit<AzkarState> {
  final GetAzkarUseCase getAzkarUseCase;

  AzkarViewModel(this.getAzkarUseCase) : super(AzkarInitialState());

  static AzkarViewModel get(context) =>
      BlocProvider.of<AzkarViewModel>(context);

  static const String favoritesKey = 'favorite_azkar';

  List<Azkar> currentAzkar = [];

  List<Azkar> favoriteAzkar = [];

  int get favoritesCount => favoriteAzkar.length;

  Future<void> getAzkar(String category) async {
    emit(AzkarLoadingState());

    try {
      final List<Azkar> azkar = await getAzkarUseCase(category);

      currentAzkar = azkar;

      emit(AzkarSuccessState(azkar));
    } catch (e) {
      emit(AzkarErrorState(e.toString()));
    }
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final savedFavorites = prefs.getStringList(favoritesKey) ?? [];

    favoriteAzkar =
        savedFavorites.map((item) {
          final Map<String, dynamic> json = Map<String, dynamic>.from(
            jsonDecode(item),
          );

          final AzkarDto dto = AzkarDto.fromJson(json);

          return Azkar(
            id: dto.id,
            count: dto.count,
            text: dto.text,
            reference: dto.reference,
          );
        }).toList();

    emit(AzkarFavoritesUpdatedState(currentAzkar));
  }

  bool isFavorite(Azkar zekr) {
    return favoriteAzkar.any(
      (item) => item.id == zekr.id && item.text == zekr.text,
    );
  }

  Future<void> toggleFavorite(Azkar zekr) async {
    final prefs = await SharedPreferences.getInstance();

    final index = favoriteAzkar.indexWhere(
      (item) => item.id == zekr.id && item.text == zekr.text,
    );

    if (index != -1) {
      favoriteAzkar.removeAt(index);
    } else {
      favoriteAzkar.add(zekr);
    }

    final List<String> favoritesToSave =
        favoriteAzkar.map((item) {
          final AzkarDto dto = AzkarDto(
            id: item.id,
            count: item.count,
            text: item.text,
            reference: item.reference,
          );

          return jsonEncode(dto.toJson());
        }).toList();

    await prefs.setStringList(favoritesKey, favoritesToSave);

    emit(AzkarFavoritesUpdatedState(currentAzkar));
  }
}
