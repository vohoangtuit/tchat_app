import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tchat/firebase/database/firestore_database.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/screens/tabs/tab_contact_screen.dart';
import 'package:tchat/screens/tabs/tab_last_message_screen.dart';
import 'package:tchat/screens/tabs/tab_profile_screen.dart';
import 'package:tchat/screens/tabs/tab_timeline_screen.dart';
import 'package:tchat/widgets/toolbar_main.dart';

class MainScreen extends StatefulWidget {
  final bool synData;
  final UserModel profile;
  const MainScreen({
    Key? key,
    required this.synData,
    required this.profile
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends TChatBaseScreen<MainScreen>  with SingleTickerProviderStateMixin{
  int positionTab = 0;
  TabController? tabController;
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(top: 0.0),
      color: Colors.lightBlue,
      child: Stack(
        children: [
          SafeArea(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  ToolBarMain(position: positionTab, onClick: (click) {
                    handleClick(click);
                  },),
                  Expanded(
                      child: Scaffold(
                        body:  TabBarView(
                          physics: const NeverScrollableScrollPhysics(), // todo: disable swip
                          controller: tabController,
                          children:   <Widget>[
                            TabLastMessageScreen(profile: widget.profile),
                            TabContactScreen(),
                            TabTimeLineScreen(),
                            TabProfileScreen(profile: widget.profile)
                          ],
                        ),
                        bottomNavigationBar: Material(
                          color: Colors.white,
                          child:
                          TabBar(
                             indicatorColor: Colors.transparent,
                            //indicatorColor: Colors.blue,
                            labelColor: Colors.blue,
                            unselectedLabelColor: Colors.grey,
                            labelPadding: const EdgeInsets.only(
                                left: 0.0, top: 5.0, right: 0.0, bottom: 0.0),
                            labelStyle: const TextStyle(color: Colors.blue, fontSize: 10.5),
                            unselectedLabelStyle: const TextStyle(
                                color: Colors.grey, fontSize: 11),
                            tabs: listTab(),
                            controller: tabController,
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
        ],

      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _init();

  }
  _init()async{
    tabController = TabController(length: 4, vsync: this);
    tabController!.addListener(handleTabSelection);
    _registerFBToken();
  }
  List<Tab> listTab() {
    return <Tab>[
      // todo: custom view tabs
      Tab(child: Column(children: [
        const SizedBox(height: 3,),
        Icon(Icons.message,
            color: tabController!.index == 0 ? Colors.blue : Colors.grey),
        const Text("Messages"),
      ],)),
      Tab(child: Column(children: [
        const SizedBox(height: 5,),
        Icon(Icons.account_box_outlined,
            color: tabController!.index == 1 ? Colors.blue : Colors.grey),
        const Text("Contacts"),
      ],)),

      Tab(child: Column(children: [
        const SizedBox(height: 5,),
        Icon(Icons.timelapse_outlined,
            color: tabController!.index == 2 ? Colors.blue : Colors.grey),
        const Text("TimeLine"),
      ],)),
      Tab(child: Column(children: [
        const SizedBox(height: 5,),
        Icon(Icons.person,
            color: tabController!.index == 3 ? Colors.blue : Colors.grey),
        const Text("Me"),
      ],)),
    ];
  }
  void handleTabSelection() {
    if(mounted){
      setState(() {
        positionTab = tabController!.index;
      });
    }
  }
  handleClick(int click) {
    log('handleClick $int');
    // if (click == MAIN_CLICK_SETTING_TAB_MORE) {
    //   openScreenWithName(SettingScreen());
    // }
    // if (click == MAIN_CLICK_EDIT_TAB_TIME_LINE) {
    //   //showBaseDialog('Edit','tab timeline',);
    //   DialogController(context).showBaseNotification(
    //       dialog, 'Edit', 'tab timeline');
    // }
    // if (click == MAIN_CLICK_NOTIFICATION_TAB_TIME_LINE) {
    //   // showBaseDialog('notification', 'tab timeline',);
    //   DialogController(context).showBaseNotification(
    //       dialog, 'notification', 'tab timeline');
    // }
  }
  _registerFBToken() async {
     Future.delayed( const Duration(seconds: 4), () {
       FirebaseMessaging.instance.getToken().then((token) {
         log("token::: ${token!}");
         if(token.isNotEmpty&&widget.profile.id!.isNotEmpty){
           widget.profile.deviceToken =token;
           firebaseService.firebaseFirestore.collection(FirebaseService.firebaseUsers).doc(widget.profile.id).update(
               {
                 UserModel.userDeviceToken:token
               }
           );
         }
       });
    });
  }
}
