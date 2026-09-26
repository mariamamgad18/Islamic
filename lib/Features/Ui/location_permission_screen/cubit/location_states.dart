abstract class LocationStates {}

class LocationInitialState extends LocationStates {}

class LocationLoadingState extends LocationStates {}

class LocationSuccessState extends LocationStates {}

class LocationErrorState extends LocationStates {
  final String errorMsg;

  LocationErrorState({required this.errorMsg});
}
