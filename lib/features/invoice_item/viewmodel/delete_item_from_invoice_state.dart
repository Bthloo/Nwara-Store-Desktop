part of 'delete_item_from_invoice_cubit.dart';

@immutable
sealed class DeleteItemFromInvoiceState {}

final class DeleteItemFromInvoiceInitial extends DeleteItemFromInvoiceState {}
final class DeleteItemFromInvoiceLoading extends DeleteItemFromInvoiceState {}
final class DeleteItemFromInvoiceSuccess extends DeleteItemFromInvoiceState {}
final class DeleteItemFromInvoiceFailure extends DeleteItemFromInvoiceState {
  final String errorMessage;
  DeleteItemFromInvoiceFailure(this.errorMessage);
}
