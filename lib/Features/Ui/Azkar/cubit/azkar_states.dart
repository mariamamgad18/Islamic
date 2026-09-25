import '../../../../Domain/entities/response/azkar/azkar.dart';

abstract class AzkarState {}

class AzkarInitialState extends AzkarState {}

class AzkarLoadingState extends AzkarState {}

class AzkarSuccessState extends AzkarState {
  final List<Azkar> azkar;

  AzkarSuccessState(this.azkar);
}

class AzkarErrorState extends AzkarState {
  final String message;

  AzkarErrorState(this.message);
}

// =========================
// Favorites Updated
// =========================

class AzkarFavoritesUpdatedState extends AzkarSuccessState {
  AzkarFavoritesUpdatedState(List<Azkar> azkar) : super(azkar);
}
