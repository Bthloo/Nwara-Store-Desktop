part of 'get_inventory_items_cubit.dart';

@immutable
sealed class GetInventoryItemsState {}

final class GetInventoryItemsInitial extends GetInventoryItemsState {}
final class GetInventoryItemsLoading extends GetInventoryItemsState {}
final class GetInventoryItemsSuccess extends GetInventoryItemsState {
  final List<InventoryModel> items;
  GetInventoryItemsSuccess(this.items);
}
final class GetInventoryItemsFailure extends GetInventoryItemsState {
  final String errorMessage;
  GetInventoryItemsFailure(this.errorMessage);
}
