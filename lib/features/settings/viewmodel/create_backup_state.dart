part of 'create_backup_cubit.dart';

@immutable
sealed class CreateBackupState {}

final class CreateBackupInitial extends CreateBackupState {}
final class CreateBackupLoading extends CreateBackupState {}
final class CreateBackupSuccess extends CreateBackupState {
  final File file;
  CreateBackupSuccess({required this.file});
}
final class CreateBackupFailure extends CreateBackupState {
  final String error;
  CreateBackupFailure(this.error);
}
