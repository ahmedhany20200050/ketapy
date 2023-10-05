
abstract class CheckoutCubitState{}
final class CheckoutCubitInitial extends CheckoutCubitState {}
final class CheckoutCubitLoading extends CheckoutCubitState {}
final class CheckoutCubitSuccess extends CheckoutCubitState {}
final class CheckoutCubitFailure extends CheckoutCubitState {
  Map<String,dynamic> err;
  CheckoutCubitFailure({required this.err});
}


