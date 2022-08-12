import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tchat/constants/color_constants.dart';
import 'package:tchat/widgets/common_widgets.dart';
import 'package:tchat/models/chat_messages.dart';
import 'package:tchat/models/user_model.dart';

class ItemMessage extends StatefulWidget {
  final ChatMessages item;
  final UserModel me;
  final UserModel toUser;

  const ItemMessage({Key? key, required this.item, required this.me, required this.toUser}) : super(key: key);

  @override
  State<ItemMessage> createState() => _ItemMessageState();
}

class _ItemMessageState extends State<ItemMessage> {
  late ChatMessages message;
  @override
  Widget build(BuildContext context) {
    message  =widget.item;
    return _checkIsMeSent()?_itemRight():_itemLeft();
  }
  Widget _itemRight(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            message.type == MessageType.text
                ? messageBubble(
              chatContent: message.content,
              color: AppColors.spaceLight,
              textColor: AppColors.white,
              margin: const EdgeInsets.only(right: 10),
            )
                : message.type == MessageType.image
                ? Container(
              margin: const EdgeInsets.only(
                  right: 10, top: 10),
              child: chatImage(imageSrc: message.content, onTap: () {}),
            )
                : const SizedBox.shrink(),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.network(
                widget.me.photoUrl!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext ctx, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.burgundy,
                      value: loadingProgress.expectedTotalBytes !=
                          null &&
                          loadingProgress.expectedTotalBytes !=
                              null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, object, stackTrace) {
                  return const Icon(
                    Icons.account_circle,
                    size: 35,
                    color: AppColors.greyColor,
                  );
                },
              ),
            ),
          ],
        ),
       Container(
          margin: const EdgeInsets.only(
              right: 50,
              top: 6,
              bottom: 8),
          child: Text(
            DateFormat('dd MMM yyyy, hh:mm a').format(
              DateTime.fromMillisecondsSinceEpoch(
                int.parse(message.timestamp),
              ),
            ),
            style: const TextStyle(
                color: AppColors.lightGrey,
                fontSize: 12,
                fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }
  Widget _itemLeft(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.network(
                widget.toUser.photoUrl!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext ctx, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.burgundy,
                      value: loadingProgress.expectedTotalBytes !=
                          null &&
                          loadingProgress.expectedTotalBytes !=
                              null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, object, stackTrace) {
                  return const Icon(
                    Icons.account_circle,
                    size: 35,
                    color: AppColors.greyColor,
                  );
                },
              ),
            ),
            message.type == MessageType.text
                ? messageBubble(
              color: AppColors.burgundy,
              textColor: AppColors.white,
              chatContent: message.content,
              margin: const EdgeInsets.only(left: 10),
            )
                : message.type == MessageType.image
                ? Container(
              margin: const EdgeInsets.only(
                  left: 10, top: 10),
              child: chatImage(
                  imageSrc: message.content, onTap: () {}),
            )
                : const SizedBox.shrink(),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(
              left: 50,
              top: 6,
              bottom: 8),
          child: Text(
            DateFormat('dd MMM yyyy, hh:mm a').format(
              DateTime.fromMillisecondsSinceEpoch(
                int.parse(message.timestamp),
              ),
            ),
            style: const TextStyle(
                color: AppColors.lightGrey,
                fontSize: 12,
                fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }
 bool _checkIsMeSent(){
    return widget.item.idSender.compareTo(widget.me.id!)==0;
  }
}
