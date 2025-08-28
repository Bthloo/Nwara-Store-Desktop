part of 'add_inventory_item_cubit.dart';

@immutable
sealed class AddInventoryItemState {}

final class AddInventoryItemInitial extends AddInventoryItemState {}
final class AddInventoryItemLoading extends AddInventoryItemState {}
final class AddInventoryItemSuccess extends AddInventoryItemState {}
final class AddInventoryItemFailure extends AddInventoryItemState {
  final String errorMessage;
  AddInventoryItemFailure(this.errorMessage);
}
