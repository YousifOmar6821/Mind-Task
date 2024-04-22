
import 'package:flutter/material.dart';

@immutable
abstract class UserEvent {}

class GetHomeDataEvent extends UserEvent {}
class GetMoreProductsEvent extends UserEvent {
  final String searchKeyword;
  final String productType;
  GetMoreProductsEvent(this.searchKeyword, this.productType);
}

