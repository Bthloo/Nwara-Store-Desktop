part of 'get_invoices_cubit.dart';

@immutable
sealed class GetInvoicesState {}

final class GetInvoicesInitial extends GetInvoicesState {}
final class GetInvoicesLoading extends GetInvoicesState{}
final class GetInvoicesSuccess extends GetInvoicesState {
  final List<InvoiceModel> invoices;
  GetInvoicesSuccess(this.invoices);
}
final class GetInvoicesFailure extends GetInvoicesState {
  final String errorMessage;
  GetInvoicesFailure(this.errorMessage);
}