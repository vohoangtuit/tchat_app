import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tchat/allConstants/color_constants.dart';
import 'package:tchat/allConstants/size_constants.dart';
import 'package:tchat/allWidgets/loading_view.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/screens/chat/chat_screen.dart';
import 'package:tchat/screens/profile_page.dart';
import 'package:tchat/utilities/debouncer.dart';
import 'package:tchat/widgets/items/item_user.dart';

import '../../allConstants/text_field_constants.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends TChatBaseScreen<HomeScreen> {
  List<UserModel> list =<UserModel>[];
  var searchTextEditingController = TextEditingController();

  Debouncer searchDebouncer = Debouncer(milliseconds: 300);
  StreamController<bool> buttonClearController = StreamController<bool>();
  String _textSearch = "";
  // Stream<QuerySnapshot> users =FirebaseFirestore.instance.collection(FirebaseDataFunc.firebaseUsers).snapshots();
   Stream<QuerySnapshot>? users;
  List<UserModel> listUser =<UserModel>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('TChat'),centerTitle: true,actions: [
        IconButton(
            onPressed: () =>  logOut(),
            icon: const Icon(Icons.logout)),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfilePage()));
            },
            icon: const Icon(Icons.person)),
      ]),
        body: WillPopScope(
          onWillPop: onBackPress,
          child: Stack(
            children: [
              Column(
                children: [
                  buildSearchBar(),
                  Expanded(
                    child: _listUser(),
                  ),
                ],
              ),
              Positioned(
                child:
                isLoading! ? const LoadingView() : const SizedBox.shrink(),
              ),
            ],
          ),
        )
    );
  }
  @override
  void initState() {
    super.initState();
    _init();
  }
  _init()async{
    await getAccountFromFloorDB();
    _getListUsers();
  }
  _getListUsers()async{
    firebaseDataFunc.getAllUser().then((value){
      setState(() {
        users =value;
      });
    });

  }

  Widget buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(Sizes.dimen_10),
      height: Sizes.dimen_50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.dimen_30),
        color: AppColors.spaceLight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: Sizes.dimen_10,
          ),
          const Icon(
            Icons.person_search,
            color: AppColors.white,
            size: Sizes.dimen_24,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextFormField(
              textInputAction: TextInputAction.search,
              controller: searchTextEditingController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  buttonClearController.add(true);
                  setState(() {
                    _textSearch = value;
                  });
                } else {
                  buttonClearController.add(false);
                  setState(() {
                    _textSearch = "";
                  });
                }
              },
              decoration: const InputDecoration.collapsed(
                hintText: 'Search here...',
                hintStyle: TextStyle(color: AppColors.white),
              ),
            ),
          ),
          StreamBuilder(
              stream: buttonClearController.stream,
              builder: (context, snapshot) {
                return snapshot.data == true
                    ? GestureDetector(
                  onTap: () {
                    searchTextEditingController.clear();
                    buttonClearController.add(false);
                    setState(() {
                      _textSearch = '';
                    });
                  },
                  child: const Icon(
                    Icons.clear_rounded,
                    color: AppColors.greyColor,
                    size: 20,
                  ),
                )
                    : const SizedBox.shrink();
              })
        ],
      ),
    );
  }
  Widget _listUser(){
    return StreamBuilder<QuerySnapshot>(
      stream: users,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          listUser.clear();
          listUser.addAll(UserModel().listFromSnapshot(snapshot.data!.docs));
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(4.0),
            itemCount: listUser.length,
            itemBuilder: (context, index) => ItemUser(me: account, user: listUser[index],onSelected: (){
              addScreen(ChatScreen(meAccount: account, toUser: listUser[index]));
            },),
          );

        }else{
          return Container();
        }

      },
    );
  }
  Future<bool> onBackPress() {
    openDialog();
    return Future.value(false);
  }
  Future<void> openDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return SimpleDialog(
            backgroundColor: AppColors.burgundy,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Exit Application',
                  style: TextStyle(color: AppColors.white),
                ),
                Icon(
                  Icons.exit_to_app,
                  size: 30,
                  color: Colors.white,
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.dimen_10),
            ),
            children: [
              vertical10,
              const Text(
                'Are you sure?',
                textAlign: TextAlign.center,
                style:
                TextStyle(color: AppColors.white, fontSize: Sizes.dimen_16),
              ),
              vertical15,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 0);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 1);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(Sizes.dimen_8),
                      ),
                      padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: AppColors.spaceCadet),
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        })) {
      case 0:
        break;
      case 1:
        exit(0);
    }
  }
}
