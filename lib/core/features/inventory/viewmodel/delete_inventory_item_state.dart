part of 'delete_inventory_item_cubit.dart';

@immutable
sealed class DeleteInventoryItemState {}

final class DeleteInventoryItemInitial extends DeleteInventoryItemState {}
final class DeleteInventoryItemLoading extends DeleteInventoryItemState {}
final class DeleteInventoryItemSuccess extends DeleteInventoryItemState {}
final class DeleteInventoryItemFailure extends DeleteInventoryItemState {
  final String errorMessage;
  DeleteInventoryItemFailure(this.errorMessage);
}
