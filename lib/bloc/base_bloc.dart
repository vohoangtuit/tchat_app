import 'package:tchat/bloc/base_config.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';

class BaseBloc extends BaseConfig{

  final TChatBaseScreen screen;
  BaseBloc({required this.screen}) : super.internal();
  void dispose() {}
  //  inti()async {
  //  await floorDB.init();
  // }
}