sealed class ListCubitState {}

final class ListCubitInitial extends ListCubitState {}

final class ListCubitLoading extends ListCubitState {}

final class ListCubitSuccess extends ListCubitState {}

final class ListCubitFailure extends ListCubitState {
  Map<String,dynamic> err;

  ListCubitFailure({required this.err});
}
