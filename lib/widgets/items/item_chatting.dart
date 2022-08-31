import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tchat/models/chat_messages.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/utils/utils.dart';
import 'package:tchat/widgets/custom_text.dart';
import 'package:tchat/widgets/general_widget.dart';

import '../../utils/colors.dart';

class ItemChatting extends StatefulWidget {
  final ChatMessages item;
  final UserModel me;
  final UserModel toUser;
  final int index;
  final  VoidCallback onClick;
  final List<ChatMessages>list;

  const ItemChatting({Key? key, required this.item, required this.me, required this.toUser, required this.index, required this.list, required this.onClick}) : super(key: key);

  @override
  State<ItemChatting> createState() => _ItemChattingState();
}

class _ItemChattingState extends State<ItemChatting> {
  late ChatMessages message;
  @override
  Widget build(BuildContext context) {
    message  =widget.item;
    return _checkIsMeSent()?_itemRight():_itemLeft();
  }
  Widget _itemRight(){
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _viewContent(message),

            ],
          ),

        ],
      ),
    );

  }
  Widget _itemLeft(){
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              isLastMessageLeft(widget.list,widget.index,widget.me.uid!)
                  ? Material(// todo left show avatar
                borderRadius: const BorderRadius.all(
                  Radius.circular(18.0),
                ),
                clipBehavior: Clip.hardEdge,
                child: Utils.isNotEmpty(widget.toUser.photoUrl)??true?
                Image.network(widget.toUser.photoUrl!, width: 35,height: 35,fit: BoxFit.cover,)
                    :const Icon(
                  Icons.account_circle,
                  size: 50.0,
                  color: greyColor,
                ),
              )
                  : Container(width: 35.0),
              _viewContent(message),
            ],
          ),

        ],
      ),
    );
  }
  Widget _viewContent(ChatMessages chatMessages){
    return   message.type == MessageType.text ?
    //todo 1 text
    Container(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      // width: 200.0,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.only(left: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:CrossAxisAlignment.start ,
        children: [
          textWhite(message.content),
          isLastMessageLeft(widget.list,widget.index,widget.me.uid!)
              ? _viewTimestamp(message.timestamp,AppColor.textColorLight)
              : Container()
        ],
      ),
    )
        : message.type == MessageType.image
        ?
    //todo 2 image
    Container(
      margin: const EdgeInsets.only(left: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:CrossAxisAlignment.start ,
        children: [
          InkWell(
            onTap: widget.onClick,
            child: Material(
              borderRadius:
              const BorderRadius.all(Radius.circular(8.0)),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                placeholder: (context, url) => Container(
                  width: 200.0,
                  height: 200.0,
                  padding: const EdgeInsets.all(70.0),
                  decoration: const BoxDecoration(
                    color: greyColor2,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  child:  const SizedBox(
                    width: 20,height: 20,
                    child: CircularProgressIndicator(
                    ),
                  ),
                ),
                errorWidget: (context, url, error) =>
                    Material(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        'images/img_not_available.jpeg',
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                imageUrl: message.content,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          isLastMessageLeft(widget.list,widget.index,widget.me.uid!)
              ? _viewTimestamp(message.timestamp,AppColor.textColorLight)
              : Container()
        ],
      ),
    )
        :
    //todo 3 sticker
    Container(
      margin: EdgeInsets.only(
          bottom: isLastMessageRight(widget.list,widget.index,widget.me.uid!) ? 20.0 : 10.0,
          right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:CrossAxisAlignment.start ,
        children: [
          Image.asset(
            'assets/images/${message.content}.gif',
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          isLastMessageLeft(widget.list,widget.index,widget.me.uid!)
              ? _viewTimestamp(message.timestamp,AppColor.textColorLight)
              : Container()
        ],
      ),
    );
  }
  Widget _viewTimestamp(String time,Color color){
    return Column(
      children: [
        spaceHeight(4),
        Text(
          // dd MMM kk:mm
          DateFormat('HH:mm').format(
              DateTime.fromMillisecondsSinceEpoch(
                  int.parse(message.timestamp))),
          style:  TextStyle(
              color: color,
              fontSize: 11.0,
              fontStyle: FontStyle.italic),
        ),
      ],
    );

  }
  bool _checkIsMeSent(){
    return widget.item.idSender.compareTo(widget.me.uid!)==0;
  }
  bool isLastMessageRight(List<ChatMessages> list,int index,String idFirebase) {
    if (index > 0 && list.isNotEmpty && list[index-1].idSender.compareTo(idFirebase)!=0 || index == 0) {
      return true;
    } else {
      return false;
    }
  }
  bool isLastMessageLeft(List<ChatMessages> list,int index,String idFirebase) {
    if(index>0 && list.isNotEmpty && list[index-1].idSender.compareTo(idFirebase)==0||index==0){

      return true;
    }
    return false;
  }
  bool isFirstMessageLeft(List<ChatMessages> list,int index,String idFirebase) {
    //todo: || index==list.length-1
    if(index>0&&index<list.length-1){

      if(list[index+1].idSender.compareTo(idFirebase)==0){
        return true;
      }
    }
    else if(index==list.length-1){
     return true;
    }
    return false;
    // todo last left
    // if(index>0 && list[index-1].idSender.compareTo(idFirebase)==0){
    //   return true;
    // }
    // return false;
  }

}
