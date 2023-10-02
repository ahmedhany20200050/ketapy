
abstract class SearchCubitState{}
final class SearchCubitInitial extends SearchCubitState {}
final class SearchCubitLoading extends SearchCubitState {}
final class SearchCubitSuccess extends SearchCubitState {}
final class SearchCubitFailure extends SearchCubitState {
  Map<String,dynamic> err;
  SearchCubitFailure({required this.err});
}
