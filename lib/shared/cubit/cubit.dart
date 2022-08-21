import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);
}