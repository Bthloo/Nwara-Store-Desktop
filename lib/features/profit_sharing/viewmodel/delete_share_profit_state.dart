part of 'delete_share_profit_cubit.dart';

@immutable
sealed class DeleteShareProfitState {}

final class DeleteShareProfitInitial extends DeleteShareProfitState {}
final class DeleteShareProfitLoading extends DeleteShareProfitState {}
final class DeleteShareProfitSuccess extends DeleteShareProfitState {}
final class DeleteShareProfitFailure extends DeleteShareProfitState {
  final String errorMessage;
  DeleteShareProfitFailure(this.errorMessage);
}
