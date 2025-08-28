part of 'get_invoive_cubit.dart';

@immutable
sealed class GetInvoiceState {}

final class GetInvoiceInitial extends GetInvoiceState {}
final class GetInvoiceLoading extends GetInvoiceState {}
final class GetInvoiceSuccess extends GetInvoiceState {
  final InvoiceModel item;
  GetInvoiceSuccess(this.item);
}
final class GetInvoiceFailure extends GetInvoiceState {
  final String errorMessage;
  GetInvoiceFailure(this.errorMessage);
}

