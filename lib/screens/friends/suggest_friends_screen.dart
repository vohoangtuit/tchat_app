import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/screens/chat/chat_screen.dart';
import 'package:tchat/widgets/general_widget.dart';
import 'package:tchat/widgets/items/item_user.dart';

class SuggestFriendsScreen extends StatefulWidget {
 final UserModel profile;
 const SuggestFriendsScreen({Key? key, required this.profile}) : super(key: key);
  @override
  State<SuggestFriendsScreen> createState() => _SuggestFriendsScreenState();
}
class _SuggestFriendsScreenState extends TChatBaseScreen<SuggestFriendsScreen> {
  Stream<QuerySnapshot>? users;
  List<UserModel> listUser =<UserModel>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithTitle(context, 'Suggest Friends'),
      body: Container(
        child: _userList(),
      ) ,
    );
  }
  @override
  void initState() {
    super.initState();
    getData();
  }
  getData() async {
   await initConfig();
   firebaseDataFunc.getAllUser().then((value){
     setState(() {
       users =value;
     });
   });
  }
  Widget _userList() {
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
}
