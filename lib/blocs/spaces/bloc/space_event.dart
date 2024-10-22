part of 'space_bloc.dart';

sealed class SpaceEvent extends Equatable {
  const SpaceEvent();

  @override
  List<Object> get props => [];
}


final class CreateSpace extends SpaceEvent {
  final String spaceName;

  const CreateSpace(this.spaceName);

  @override
  List<Object> get props => [spaceName];
}

final class GetSpaces extends SpaceEvent {}
