
abstract class CartCubitState{}
final class CartCubitInitial extends CartCubitState {}
final class CartCubitLoading extends CartCubitState {}
final class CartCubitSuccess extends CartCubitState {}
final class CartCubitFailure extends CartCubitState {
  Map<String,dynamic> err;
  CartCubitFailure({required this.err});
}


