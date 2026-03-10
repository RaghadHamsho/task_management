import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_card_state.dart';

class ChangeCardCubit extends Cubit<bool> {
  ChangeCardCubit() : super(false);
  void toggleAuth() {
    emit(!state);
  }

  void showSignUp() {
    emit(true);
  }

  void showSignIn() {
    emit(false);
  }
}