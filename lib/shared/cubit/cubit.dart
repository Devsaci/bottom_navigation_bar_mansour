import 'package:bloc/bloc.dart';
import 'package:bottom_navigation_bar_mansour/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
}