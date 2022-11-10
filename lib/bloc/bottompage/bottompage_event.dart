part of 'bottompage_bloc.dart';

abstract class BottomPageEvent extends Equatable {
  const BottomPageEvent();

  @override
  List<Object> get props => [];
}

class ChangePage extends BottomPageEvent {
  final int page;
  ChangePage({required this.page});
}
