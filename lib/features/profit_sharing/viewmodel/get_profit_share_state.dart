part of 'get_profit_share_cubit.dart';

@immutable
sealed class GetProfitShareState {}

final class GetProfitShareInitial extends GetProfitShareState {}
final class GetProfitShareLoading extends GetProfitShareState {}
final class GetProfitShareSuccess extends GetProfitShareState {
  final List<ProfitSharingModel> profitShares;
  GetProfitShareSuccess(this.profitShares);
}
final class GetProfitShareFailure extends GetProfitShareState {
  final String error;
  GetProfitShareFailure(this.error);
}
