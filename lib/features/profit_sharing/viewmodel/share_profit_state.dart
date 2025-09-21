part of 'share_profit_cubit.dart';

@immutable
sealed class ShareProfitState {}

final class ShareProfitInitial extends ShareProfitState {}
final class ShareProfitLoading extends ShareProfitState {}
final class ShareProfitSuccess extends ShareProfitState {}
final class ShareProfitFailure extends ShareProfitState {
  final String error;
  ShareProfitFailure(this.error);
}
