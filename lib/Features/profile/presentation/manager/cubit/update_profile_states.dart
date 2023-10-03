abstract class UpdateProfileState {}

final class UpdateProfileCubitInitial extends UpdateProfileState {}

final class UpdateProfileCubitLoading extends UpdateProfileState {}

final class UpdateProfileCubitSuccess extends UpdateProfileState {}

final class UpdateProfileCubitFailure extends UpdateProfileState {
  Map<String,dynamic> errmsg;

  UpdateProfileCubitFailure({required this.errmsg});
}