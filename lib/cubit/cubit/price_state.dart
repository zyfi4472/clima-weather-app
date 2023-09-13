part of 'price_cubit.dart';

@immutable
sealed class PriceState {}

final class PriceInitial extends PriceState {}

final class PriceLoading extends PriceState {}

final class PriceLoaded extends PriceState {}

final class PriceNoInternet extends PriceState {}

// ignore: must_be_immutable
final class PriceException extends PriceState {
  String error;
  PriceException({required this.error});
}
