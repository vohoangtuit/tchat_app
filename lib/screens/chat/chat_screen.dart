import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tchat/allConstants/color_constants.dart';
import 'package:tchat/allConstants/size_constants.dart';
import 'package:tchat/allConstants/text_field_constants.dart';
import 'package:tchat/firebase/database/firestore_database.dart';
import 'package:tchat/models/chat_messages.dart';
import 'package:tchat/models/last_message_model.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/providers/chat_provider.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/utilities/const.dart';
import 'package:tchat/widgets/items/item_message.dart';
import 'package:tchat/widgets/items/item_user.dart';

class ChatScreen extends StatefulWidget {
  final UserModel meAccount;
  final UserModel toUser;
  const ChatScreen({Key? key, required this.meAccount, required this.toUser}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends TChatBaseScreen<ChatScreen> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  File? imageFile;

  bool isShowSticker = false;
  String imageUrl = '';

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  List<ChatMessages> listMessage = <ChatMessages>[];

  List<ChatMessages> list = <ChatMessages>[];
  Stream<QuerySnapshot>? chats;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.toUser.fullName}'.trim()),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.phone),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildListMessage(),
              _buildMessageInput(),
              const SizedBox(height: 5,),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListMessage() {
    return Flexible(child: StreamBuilder<QuerySnapshot>(
      stream: chats,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          listMessage.clear();
          listMessage.addAll(
              ChatMessages.listFromSnapshot(snapshot.data!.docs));
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(4.0),
            itemCount: listMessage.length,
            itemBuilder: (context, index) => ItemMessage(
              item: listMessage[index],
              me: widget.meAccount,
              toUser: widget.toUser,),
          );
        } else {
          return Container();
        }
      },

    ));
  }

  Widget _buildMessageInput() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: Sizes.dimen_4),
            decoration: BoxDecoration(
              color: AppColors.burgundy,
              borderRadius: BorderRadius.circular(Sizes.dimen_30),
            ),
            child: IconButton(
              onPressed: getImage,
              icon: const Icon(
                Icons.camera_alt,
                size: Sizes.dimen_28,
              ),
              color: AppColors.white,
            ),
          ),
          Flexible(
              child: TextField(
                focusNode: focusNode,
                textInputAction: TextInputAction.send,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                controller: textEditingController,
                decoration:
                kTextInputDecoration.copyWith(hintText: 'write here...'),
                onSubmitted: (value) {
                  onSendMessage(textEditingController.text, MessageType.text);
                },
              )),
          Container(
            margin: const EdgeInsets.only(left: Sizes.dimen_4),
            decoration: BoxDecoration(
              color: AppColors.burgundy,
              borderRadius: BorderRadius.circular(Sizes.dimen_30),
            ),
            child: IconButton(
              onPressed: () {
                onSendMessage(textEditingController.text, MessageType.text);
              },
              icon: const Icon(Icons.send_rounded),
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  _init() async {
    await initConfig();
    await _getListMessage();

    _listenerData();
  }

  //timestamp
  _getListMessage() async {
    firebaseDataFunc.getMessageChat(widget.meAccount.id!, widget.toUser.id!)
        .then((value) {
      setState(() {
        chats = value;
      });
    });
  }

  onSendMessage(String content, int type) async {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content
        .trim()
        .isNotEmpty) {
      textEditingController.clear();
      // if(groupChatId.length==0){
      //   setState(() {
      //     groupChatId =account.id+'-'+DateTime.now().millisecondsSinceEpoch.toString();
      //   });
      //   checkSocket();
      // }
      ChatMessages messages = ChatMessages(
        idSender: widget.meAccount.id!,
        nameSender: widget.meAccount.fullName!,
        photoSender: widget.meAccount.photoUrl!,

        idReceiver: widget.toUser.id!,
        nameReceiver: widget.toUser.fullName!,
        photoReceiver: widget.toUser.photoUrl!,
        timestamp: DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
        content: content,
        type: type,
        status: 0,
        // groupId: groupChatId
      );
      var from = FirebaseFirestore.instance
          .collection(FirebaseDataFunc.firebaseMessages)
          .doc(widget.meAccount.id!)
          .collection(widget.toUser.id!)
          .doc(); // end doc can use timestamp
      var to = FirebaseFirestore.instance
          .collection(FirebaseDataFunc.firebaseMessages)
          .doc(widget.toUser.id!)
          .collection(widget.meAccount.id!)
          .doc(); // end doc can use timestamp
      WriteBatch writeBatch = FirebaseFirestore.instance.batch();
      writeBatch.set(from, messages.toJson_());
      writeBatch.set(to, messages.toJson_());
      writeBatch
          .commit()
          .then((value) => () => {print('Create message succree ')})
          .catchError((onError) {
        print(('create message error $onError'));
      });
      //  print('message insert '+messages.toString());
      //   await floorDB.messageDao.insertMessage(messages);
      //   print('toUser.isOnlineChat '+toUser.isOnlineChat.toString());
      //   if(!toUser.isOnlineChat){
      //     senNotificationNewMessage(toUser.id,account.fullName,account.id,content);
      //   }
      //   listScrollController.animateTo(0.0,
      //       duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      // } else {
      //   Fluttertoast.showToast(
      //       msg: 'Nothing to send',
      //       backgroundColor: Colors.black,
      //       textColor: Colors.red);
      // }
    }
  }
   _listenerData() async{
    var userQuery=  firebaseDataFunc.chatListenerData(widget.meAccount.id!, widget.toUser.id!);
    userQuery.snapshots().listen((data) {
      // print("data size: "+data.size.toString());
      //print("data document: "+data.docs.toString());
      LastMessageModel message = LastMessageModel();
      message.uid =account.id;
      data.docs.forEach((change) {
        // print('groupChatId $groupChatId');
        // if(groupChatId.length==0){
        //   if(change.data()[MESSAGE_GROUP_ID]!=null){
        //     if(mounted){
        //       setState(() {
        //         groupChatId =change.data()[MESSAGE_GROUP_ID];
        //       });
        //     }
        //   }
        //   checkSocket();
        // }
        // print('groupChatId: $groupChatId');
        if(widget.meAccount.id!.contains(change.data()[messageIdSender])){// todo: is me
          //  print('message is me');
          message.idReceiver =change.data()[messageIdReceiver];
          message.nameReceiver =change.data()[messageNameReceiver];
          message.photoReceiver =change.data()[messagePhotoReceiver];
        }else{
          //print('message not me');
          message.idReceiver =widget.toUser.id;
          message.nameReceiver =widget.toUser.fullName;
          message.photoReceiver =widget.toUser.photoUrl;
        }
        message.timestamp =change.data()[messageTimestamp];
        message.content =change.data()[messageContent];
        message.type =change.data()[messageType];
        message.status =change.data()[messageStatus];
      });
      updateLastMessageByID(message);
      // if(mounted){
      //   ProviderController(context).setReloadLastMessage(true);
      // }

    });
  }
  getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        // uploadImageFile();
      }
    }
  }
  void uploadImageFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    // UploadTask uploadTask = chatProvider.uploadImageFile(imageFile!, fileName);
    // try {
    //   TaskSnapshot snapshot = await uploadTask;
    //   imageUrl = await snapshot.ref.getDownloadURL();
    //   setState(() {
    //     isLoading = false;
    //     onSendMessage(imageUrl, MessageType.image);
    //   });
    // } on FirebaseException catch (e) {
    //   setState(() {
    //     isLoading = false;
    //   });
    //   Fluttertoast.showToast(msg: e.message ?? e.toString());
    // }
  }
}
