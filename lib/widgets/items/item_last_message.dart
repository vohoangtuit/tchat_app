import 'package:flutter/material.dart';
import 'package:tchat/models/last_message_model.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/constants/const.dart';
import 'package:tchat/widgets/custom_text.dart';
import 'package:tchat/widgets/general_widget.dart';

import '../../utils/time_ago.dart';
import '../cached_network_image.dart';


class ItemLastMessage extends StatefulWidget {
 final UserModel profile;
 final LastMessageModel message;
 final  String languageCode;
 final VoidCallback onClick;
  const ItemLastMessage({Key? key, required this.profile, required this.message, required this.languageCode, required this.onClick}) : super(key: key);

  @override
  State<ItemLastMessage> createState() => _ItemLastMessageState();
}

class _ItemLastMessageState extends State<ItemLastMessage> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Container(
        padding: const EdgeInsets.only(left: 10.0,top: 0.0,right: 5.0,bottom: 0.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0,top: 8.0,right: 0.0,bottom: 10.0),
          child: Stack(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    // child:  CircleAvatar(radius: 30.0, backgroundImage: message.photoReceiver.isEmpty ? AssetImage(PATH_AVATAR_NOT_AVAILABLE):NetworkImage(message.photoReceiver), backgroundColor: Colors.transparent,),
                    width: 45,height: 45,
                    // child:  CircleAvatar(radius: 30.0, backgroundImage: message.photoReceiver.isEmpty ? AssetImage(PATH_AVATAR_NOT_AVAILABLE):NetworkImage(message.photoReceiver), backgroundColor: Colors.transparent,),
                    child: widget.message.photoReceiver!.isEmpty?const CircleAvatar(radius: 30.0,backgroundImage:AssetImage(Const.pathAvatarNotAvailable)):Material(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(45.0)),
                      clipBehavior: Clip.hardEdge,
                      //child: cachedImage(widget.message.photoReceiver!,45.0,45.0),
                      child: cachedAvatar(context,widget.message.photoReceiver!,45.0),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(left: 8.0,top: 0.0,right: 40.0,bottom: 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( widget.message.nameReceiver!,style: textBlackNormal(), overflow: TextOverflow.ellipsis, maxLines: 1,),
                          spaceHeight(5),
                          Text(getContent(widget.message),style: textGraysSmall()),
                        ],

                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerRight,
                child: (Text(TimeAgo().timeAgo(widget.languageCode,TimeAgo().getDateTimeFromString(widget.message.timestamp!)),style: textGraySmaller())),
                //child: (Text('Update: ',style: smallTextGray())),
              )
            ],
          ),
        ),
      ),

    );
  }

  String getContent(LastMessageModel mgs) {
    if(mgs.type==0){
      return mgs.content!;
    }else if(mgs.type==1){
      return '[Photo]';
    }
    return '[Sticker]';
  }
}
