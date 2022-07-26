import 'package:flutter/material.dart';
import 'package:tchat/general/genneral_screen.dart';

abstract class TChatScreen  <T extends StatefulWidget> extends GeneralScreen<T> {
  bool isOnline = true;
  bool? isLoading = false;
  bool firstLoad = true;
  bool endData = false;

  //FirebaseDB? firebaseDatabase;
  bool isLogin = false;
  Dialog? dialog;
  //late NotificationController notificationController;

  @override
  void initAll() {
    initFireBase();
    super.initAll();
  }
  initFireBase() async {

  }
  @override
  void disposeAll() {
    _disposeBloc();
    isLoading = false;
    firstLoad = true;
    endData = false;
    super.disposeAll();
  }
  void _disposeBloc(){

  }

}
