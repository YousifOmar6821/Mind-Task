import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/business_logic/bloc/user/user_event.dart';
import 'package:task/business_logic/bloc/user/user_state.dart';
import 'package:task/data/models/category.dart';
import 'package:task/data/models/product.dart';
import 'package:task/data/models/slider.dart';
import '../../../data/local/global_settings.dart';
import '../../../data/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(ServiceInitial()) {
    on<GetHomeDataEvent>((event, emit) async { await getHomeData(event, emit); });
    on<GetMoreProductsEvent>((event, emit) async { await getMoreProducts(event, emit); });
  }

  Future<void> getHomeData(GetHomeDataEvent event, Emitter<UserState> emit) async {
    emit(ServiceLoading());
    try {
      List data = await userRepository.getHomeData();
      GlobalSettings.sliders = data[0] as List<Sliders>;
      GlobalSettings.categories = data[1] as List<Categories>;
      GlobalSettings.products = data[2] as List<Product>;
      GlobalSettings.selectedProducts = data[3] as List<Product>;
      GlobalSettings.newProducts = data[4] as List<Product>;
      emit(GetHomeDataSuccess());
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        emit(ServiceTimeout());
        return;
      }
      emit(GetHomeDataError(e.toString()));
      return;
    } catch (e) {
      emit(GetHomeDataError(e.toString()));
    }
  }

  Future<void> getMoreProducts(GetMoreProductsEvent event, Emitter<UserState> emit) async {
    emit(ServiceLoading());
    try {
      List <Product> data = await userRepository.getMoreProductsData(event.productType, event.searchKeyword);
      emit(GetMoreProductsSuccess(data));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        emit(ServiceTimeout());
        return;
      }
      emit(GetMoreProductsError(e.toString()));
      return;
    } catch (e) {
      emit(GetMoreProductsError(e.toString()));
    }
  }
}
