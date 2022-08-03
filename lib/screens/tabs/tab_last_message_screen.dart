import 'package:flutter/material.dart';
import 'package:tchat/models/last_message_model.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/widgets/items/item_last_message.dart';

class TabLastMessageScreen extends StatefulWidget {
  final UserModel profile;
  const TabLastMessageScreen({Key? key, required this.profile}) : super(key: key);

  @override
  State<TabLastMessageScreen> createState() => _TabLastMessageScreenState();
}

class _TabLastMessageScreenState extends TChatBaseScreen<TabLastMessageScreen> {
  List<LastMessageModel> listMessage = <LastMessageModel>[];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: listView(),
        ),
      ],
    );
  }
  @override
  void initState() {
    super.initState();
    log('TabLastMessageScreen initState');
    _init();
  }
  Widget listView() {
      return listMessage.isNotEmpty?ListView.separated(
        padding: const EdgeInsets.only(left: 0.0,top: 0.0,right: 0.0,bottom: 8.0),
        itemBuilder: (context, index) =>
            ItemLastMessage(profile:widget.profile, message:listMessage[index],languageCode:'vi'),
        itemCount: listMessage.length,
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.grey,height: 0.5,
            indent: 60.0,// padding left
            endIndent: 0,// padding right
          );
        },
      ):Container();

  }
  _init()async{
    log('TabLastMessageScreen _init');
    await initConfig();
   await _getListLastMessage();
  }
  _getListLastMessage() async{
    log('TabLastMessageScreen _getListLastMessage');
    floorDB.lastMessage().getSingleLastMessage(widget.profile.id).then((value) {
      log('value ${value.toString()}');
      listMessage.clear();
      Future.delayed(Duration.zero, () async {
        if(mounted){
          setState(() {
          listMessage.addAll(value);
        });}
      });
    });
  }
}

