
abstract class GovCubitState{}
final class GovCubitInitial extends GovCubitState {}
final class GovCubitLoading extends GovCubitState {}
final class GovCubitSuccess extends GovCubitState {}
final class GovCubitFailure extends GovCubitState {
  Map<String,dynamic> err;
  GovCubitFailure({required this.err});
}


