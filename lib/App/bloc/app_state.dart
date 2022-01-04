part of 'app_bloc.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class IsVerfitState extends AppState {
  final bool isverfiy;

  IsVerfitState(this.isverfiy);
}
