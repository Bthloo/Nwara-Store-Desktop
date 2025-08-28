part of 'rail_bar_cubit.dart';

@immutable
sealed class RailBarState {}

final class RailBarInitial extends RailBarState {}
final class ChangeRailBarState extends RailBarState {}
