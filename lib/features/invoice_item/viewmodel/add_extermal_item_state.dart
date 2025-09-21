part of 'add_extermal_item_cubit.dart';

@immutable
sealed class AddExternalItemState {}

final class AddExternalItemInitial extends AddExternalItemState {}
final class AddExternalItemLoading extends AddExternalItemState {}
final class AddExternalItemSuccess extends AddExternalItemState {}
final class AddExternalItemFailure extends AddExternalItemState {
  final String errorMessage;
  AddExternalItemFailure(this.errorMessage);
}

