
import 'package:flutter/material.dart';

import '../../../data/models/product.dart';

@immutable
abstract class UserState {}

class ServiceInitial extends UserState {}

class ServiceLoading extends UserState {}

class ServiceTimeout extends UserState {}

class GetHomeDataSuccess extends UserState {}

class GetHomeDataError extends UserState {
  final String errMsg;

  GetHomeDataError(this.errMsg);
}
class GetMoreProductsSuccess extends UserState {
  final List<Product> prods;
  GetMoreProductsSuccess(this.prods);
}

class GetMoreProductsError extends UserState {
  final String errMsg;

  GetMoreProductsError(this.errMsg);
}
