part of 'edit_inventory_item_cubit.dart';

@immutable
sealed class EditInventoryItemState {}

final class EditInventoryItemInitial extends EditInventoryItemState {}
final class EditInventoryItemLoading extends EditInventoryItemState {}
final class EditInventoryItemSuccess extends EditInventoryItemState {}
final class EditInventoryItemFailure extends EditInventoryItemState {
  final String errorMessage;
  EditInventoryItemFailure(this.errorMessage);
}
