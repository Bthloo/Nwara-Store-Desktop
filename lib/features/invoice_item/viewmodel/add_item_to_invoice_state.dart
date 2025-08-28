part of 'add_item_to_invoice_cubit.dart';

@immutable
sealed class AddItemToInvoiceState {}

final class AddItemToInvoiceInitial extends AddItemToInvoiceState {}
final class AddItemToInvoiceLoading extends AddItemToInvoiceState {}
final class AddItemToInvoiceSuccess extends AddItemToInvoiceState {}
final class AddItemToInvoiceFailure extends AddItemToInvoiceState {
  final String errorMessage;
  AddItemToInvoiceFailure(this.errorMessage);
}
