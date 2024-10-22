part of 'space_bloc.dart';

sealed class SpaceState extends Equatable {
  const SpaceState();

  @override
  List<Object> get props => [];
}

final class SpaceInitial extends SpaceState {}

final class CreateSpaceLoadig extends SpaceState {}

final class CreateSpaceSuccess extends SpaceState {
  final String spaceName;

  const CreateSpaceSuccess(this.spaceName);

  @override
  List<Object> get props => [spaceName];
}

final class CreateSpaceFailure extends SpaceState {
  final String error;

  const CreateSpaceFailure(this.error);

  @override
  List<Object> get props => [error];
}

final class SpaceError extends SpaceState {
  final String error;

  const SpaceError(this.error);

  @override
  List<Object> get props => [error];
}
