
abstract class FavouritesCubitState{}
final class FavouritesCubitInitial extends FavouritesCubitState {}
final class FavouritesCubitLoading extends FavouritesCubitState {}
final class FavouritesCubitSuccess extends FavouritesCubitState {}
final class FavouritesCubitFailure extends FavouritesCubitState {
  Map<String,dynamic> err;
  FavouritesCubitFailure({required this.err});
}


