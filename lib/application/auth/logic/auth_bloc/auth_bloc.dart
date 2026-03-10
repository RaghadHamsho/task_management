import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';

import '../../../../configure_di.dart';
import '../../model/user_model.dart';
import '../../repository/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<SignUPEvent>(_onRegister);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading, isLoading: true));
    EasyLoading.show();

    try {
      final user = await getIt<AuthRepo>().login(
        domainName: event.userName,
        password: event.password,
      );

      emit(
        state.copyWith(
          status: AuthStatus.success,
          user: user,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, isLoading: false));
      EasyLoading.dismiss();


    }
  }

  Future<void> _onRegister(SignUPEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading, isLoading: true));
    EasyLoading.show();

    try {
      final user = await getIt<AuthRepo>().signUp(
        domainName: event.userName,
        password: event.password,
        email: event.email,
      );

      emit(
        state.copyWith(
          status: AuthStatus.success,
          user: user,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, isLoading: false));
      EasyLoading.dismiss();
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading, isLoading: true));
    EasyLoading.show();

    try {
      await getIt<AuthRepo>().logout(deviceToken: event.deviceToken);

      emit(
        state.copyWith(
          status: AuthStatus.success,
          user: null,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, isLoading: false));
      EasyLoading.dismiss();
    }
  }
}
