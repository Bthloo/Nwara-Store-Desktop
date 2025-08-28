part of 'delete_invoice_cubit.dart';

@immutable
sealed class DeleteInvoiceState {}

final class DeleteInvoiceInitial extends DeleteInvoiceState {}
final class DeleteInvoiceLoading extends DeleteInvoiceState {}
final class DeleteInvoiceSuccess extends DeleteInvoiceState {}
final class DeleteInvoiceFailure extends DeleteInvoiceState {
  final String errorMessage;
  DeleteInvoiceFailure(this.errorMessage);
}
