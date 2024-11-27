part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitialState extends SettingsState {}

final class SettingsLoadingState extends SettingsState {}

final class SettingsSuccssState extends SettingsState {}

final class SettingsFailureState extends SettingsState {
  final String errorMessage;

  const SettingsFailureState({required this.errorMessage});
}