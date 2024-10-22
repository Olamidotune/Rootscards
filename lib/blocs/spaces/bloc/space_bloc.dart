import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rootscards/repos/repos.dart';

part 'space_event.dart';
part 'space_state.dart';

class SpaceBloc extends Bloc<SpaceEvent, SpaceState> {
  final AuthRepository authRepository;
  SpaceBloc(this.authRepository) : super(SpaceInitial()) {
    on<CreateSpace>(_createSpace);
  }

  void _createSpace(CreateSpace event, Emitter<SpaceState> emit) {
    emit(CreateSpaceLoadig());
    try {
      // ignore: avoid_print
      print('Creating space with name: ${event.spaceName}');
      emit(CreateSpaceSuccess(event.spaceName));
    } catch (e) {
      emit(CreateSpaceFailure('Failed to create space'));
    }
  }
}
