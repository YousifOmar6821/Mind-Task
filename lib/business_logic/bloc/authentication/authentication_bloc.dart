import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/local/global_settings.dart';
import '../../../data/local/local_storage_helper.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/authentication_repository.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;
  AuthenticationBloc(this.authenticationRepository) : super(AuthenticationInitial()) {
    on<Login>((event, emit) async {
      await login(event, emit);
    });
  }

  Future<void> login(Login event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    final User userData;
    try {
      userData = await authenticationRepository.login(event.email, event.password);
        GlobalSettings.user = userData;
        try {
            await LocalStorageHelper.saveUser();
            emit(LoginSuccess(userData));
          } on DioException catch (e) {
            if (e.type == DioExceptionType.connectionTimeout) {
              emit(AuthenticationTimeOut());
            } else {
              emit(AuthenticationError(e.toString()));
            }
          } catch (e) {
            emit(AuthenticationError(e.toString()));
          }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        emit(AuthenticationTimeOut());
      } else {
        emit(LoginError(e.toString()));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
