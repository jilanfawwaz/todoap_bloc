import 'package:todoapp_bloc/bloc/bloc_export.dart';
import 'package:equatable/equatable.dart';

part 'bottompage_event.dart';

class BottomPageBloc extends Bloc<BottomPageEvent, int> {
  BottomPageBloc() : super(1) {
    on<ChangePage>((event, emit) {
      // TODO: implement event handler
      emit(event.page);
    });
  }
}
