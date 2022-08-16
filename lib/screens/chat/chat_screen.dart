import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tchat/firebase/database/firestore_database.dart';
import 'package:tchat/models/chat_messages.dart';
import 'package:tchat/models/last_message_model.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/models/user_online_model.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/screens/user_friend/user_profile_screen.dart';
import 'package:tchat/constants/const.dart';
import 'package:tchat/widgets/custom_text.dart';
import 'package:tchat/widgets/full_photo.dart';
import 'package:tchat/widgets/general_widget.dart';
import 'package:tchat/widgets/items/item_chatting.dart';
import 'package:tchat/widgets/items/item_message.dart';

class ChatScreen extends StatefulWidget {
  final UserModel meAccount;
   late UserModel toUser;
   ChatScreen({Key? key, required this.meAccount, required this.toUser})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends TChatBaseScreen<ChatScreen> {
  List<ChatMessages> listMessage = <ChatMessages>[];
  int _limit = 20;
  final int _limitIncrement = 20;
  File? imageFile;
  bool isShowSticker = false;
  String? imageUrl;
  bool typing = false;
  String groupChatId = '';
  UserModel? toUser;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  Stream<QuerySnapshot>? chats;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: -8.0,
        title: SizedBox(
          // todo custom title
          height: 54,
          child: InkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    toUser==null?Container():statusOnline(toUser!.isOnlineChat!),
                    spaceWidth(5),
                    textWhiteLarge(toUser == null ? '' : toUser!.fullName!),
                  ],
                ),
              ],
            ),
            onTap: () {
              addScreen(UserProfileScreen(
                myProfile: widget.meAccount,
                user: widget.toUser,
              ));
            },
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 2.0, right: 0.0, bottom: 0.0),
                child: Row(
                  children: [
                    IconButton(
                        icon: Image.asset(
                          'assets/icons/phone_white.png',
                          width: 26,
                          height: 20,
                        ),
                        onPressed: () => _audioVideo()),
                    IconButton(
                        icon: Image.asset(
                          'assets/icons/camera_white.png',
                          width: 25,
                          height: 25,
                        ),
                        onPressed: () => _callVideo()),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              _listChat(),
              (isShowSticker ? _buildSticker() : Container()),
              _buildInput(),
            ],
          ),
          _buildLoading()
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }
  @override
  void onPause() {
    super.onPause();
    _sendMeOnline(false);
  }
  @override
  void onResume() {
    super.onResume();
    _sendMeOnline(true);
  }
  @override
  void dispose() {
    _sendMeOnline(false);
    super.dispose();
  }

  Widget _listChat() {
    return Flexible(
        child: StreamBuilder<QuerySnapshot>(
      stream: chats,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          listMessage.clear();
          listMessage
              .addAll(ChatMessages.listFromSnapshot(snapshot.data!.docs));
          return ListView.builder(
            reverse: true,
            controller: listScrollController,
            padding: const EdgeInsets.all(4.0),
            itemCount: listMessage.length, itemBuilder: (BuildContext context, int index) =>ItemChatting(
              item:  listMessage[index],
              me: widget.meAccount,
              toUser: widget.toUser,
              index: index,
              list:listMessage,
              onClick: (){
                addScreen(FullPhoto(url: listMessage[index].content,));
          }),
            // itemBuilder: (context, index) => ItemMessage(
            //   item: listMessage[index],
            //   me: widget.meAccount,
            //   toUser: widget.toUser,
            // ),
          );
        } else {
          return Container();
        }
      },
    ));
  }

  Widget _buildSticker() {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: greyColor2, width: 0.5)),
          color: Colors.white),
      padding: const EdgeInsets.all(5.0),
      height: 180.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () => _onSendMessage('mimi1', 2),
                child: Image.asset(
                  'assets/images/mimi1.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              InkWell(
                onTap: () => _onSendMessage('mimi2', 2),
                child: Image.asset(
                  'assets/images/mimi2.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              InkWell(
                onTap: () => _onSendMessage('mimi3', 2),
                child: Image.asset(
                  'assets/images/mimi3.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () => _onSendMessage('mimi4', 2),
                child: Image.asset(
                  'assets/images/mimi4.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              InkWell(
                onTap: () => _onSendMessage('mimi5', 2),
                child: Image.asset(
                  'assets/images/mimi5.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              InkWell(
                onTap: () => _onSendMessage('mimi6', 2),
                child: Image.asset(
                  'assets/images/mimi6.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () => _onSendMessage('mimi7', 2),
                child: Image.asset(
                  'assets/images/mimi7.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              InkWell(
                onTap: () => _onSendMessage('mimi8', 2),
                child: Image.asset(
                  'assets/images/mimi8.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              InkWell(
                onTap: () => _onSendMessage('mimi9', 2),
                child: Image.asset(
                  'assets/images/mimi9.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Positioned(
      child: isLoading! ? loadingCenter() : Container(),
    );
  }

  Widget _buildInput() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: greyColor2, width: 0.5)),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: const Icon(Icons.image),
                onPressed: getImage,
                color: primaryColor,
              ),
            ),
          ),
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: const Icon(Icons.face),
                onPressed: getSticker,
                color: primaryColor,
              ),
            ),
          ),

          // Edit text
          Flexible(
            child: TextField(
              onSubmitted: (value) {
                _onSendMessage(textEditingController.text, 0);
              },
              style: TextStyle(color: primaryColor, fontSize: 15.0),
              controller: textEditingController,
              decoration: InputDecoration.collapsed(
                hintText: 'Type your message...',
                hintStyle: TextStyle(color: greyColor),
              ),
              focusNode: focusNode,
            ),
          ),

          // Button send message
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _onSendMessage(textEditingController.text, 0),
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _init() async {
    setState(() {
      toUser = widget.toUser;
    });
    await _initData();
    await _getProfileUser();
    await _checkUserOnline();
  }

  _getProfileUser() async {
    await getProfileFromFirebase(widget.toUser, saveLocal: false).then((value) {
      if (mounted) {
        setState(() {
          widget.toUser =value;
          toUser = value;
        });
      }
    });
  }

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      log("reach the bottom");
      setState(() {
        log("reach the bottom");
        _limit += _limitIncrement;
      });
    }
    if (listScrollController.offset <=
            listScrollController.position.minScrollExtent &&
        !listScrollController.position.outOfRange) {
      log("reach the top");
      setState(() {
        log("reach the top");
      });
    }
  }

  _initData() async {
    focusNode.addListener(_onFocusChange);
    listScrollController.addListener(_scrollListener);

    isShowSticker = false;
    imageUrl = '';
    _getMessage();
    //initSocket();
    // textEditingController.addListener(() {
    //   if (textEditingController.text.isNotEmpty) {
    //     if(socketIO==null)
    //       return;
    //     if (typing) return;
    //     typing = true;
    //     socketIO.sendMessage(SOCKET_TYPING, json.encode({SOCKET_GROUP_CHAT_ID: groupChatId,SOCKET_SENDER_CHAT_ID: account.id}));
    //   } else {
    //     if(socketIO==null)
    //       return;
    //     if (!typing) return;
    //     typing = false;
    //     socketIO.sendMessage(SOCKET_STOP_TYPING, json.encode({SOCKET_GROUP_CHAT_ID: groupChatId,SOCKET_SENDER_CHAT_ID: account.id}));
    //   }
    // });

    _listenerData();
    _sendMeOnline(true);
  }

  _onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  _getMessage() async {
    firebaseService
        .getMessageChat(widget.meAccount.id!, widget.toUser.id!)
        .then((value) {
      setState(() {
        chats = value;
      });
    });
  }

  _checkUserOnline() async {
    var check = FirebaseFirestore.instance
        .collection(FirebaseService.firebaseMessages)
        .doc(widget.meAccount.id)
        .collection(widget.toUser.id!)
        .doc(UserOnLineModel.userOnLineIsOnline);
    check.snapshots().listen((data) {
      if (data.data() != null) {
        Map<String, dynamic>? json = data.data();
        UserOnLineModel userOnLineModel = UserOnLineModel.fromJson(json!);
        // print('userOnLineModel '+userOnLineModel.toString());
        if (mounted) {
          setState(() {
            toUser!.isOnlineChat = userOnLineModel.isOnline;
          });
        }
       //  log('1: ${toUser!.id} : ${toUser!.isOnlineChat}');
      } else {
        userBloc.createUserOnline(widget.meAccount.id!, toUser!, false);
      }
    });
  }

  _listenerData() async {
    var userQuery = firebaseService.chatListenerData(
        widget.meAccount.id!, widget.toUser.id!);
    userQuery.snapshots().listen((data) {
      LastMessageModel message = LastMessageModel();
      //message.uid =account.id;
      message.uid = widget.meAccount.id;
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
        //log('change ${change.toString()}');
        if (widget.meAccount.id!
            .contains(change.data()[Const.messageIdSender])) {
          // todo: is me
          //  print('message is me');
          message.idReceiver = change.data()[Const.messageIdReceiver];
          message.nameReceiver = change.data()[Const.messageNameReceiver];
          message.photoReceiver = change.data()[Const.messagePhotoReceiver];
        } else {
          //print('message not me');
          message.idReceiver = widget.toUser.id;
          message.nameReceiver = widget.toUser.fullName;
          message.photoReceiver = widget.toUser.photoUrl;
        }
        message.timestamp = change.data()[Const.messageTimestamp];
        message.content = change.data()[Const.messageContent];
        message.type = change.data()[Const.messageType];
        message.status = change.data()[Const.messageStatus];
      });

      if (message.idReceiver != null) {
        messageBloc.updateLastMessageByID(message);
      } else {
        // log('message null');
      }
    });
  }

  _sendMeOnline(bool online) {
    userBloc.createUserOnline(toUser!.id!, widget.meAccount, online);
  }

  _onSendMessage(String content, int type) async {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim().isNotEmpty) {
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
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        type: type,
        status: 0,
        // groupId: groupChatId
      );
      var from = FirebaseFirestore.instance
          .collection(FirebaseService.firebaseMessages)
          .doc(widget.meAccount.id!)
          .collection(widget.toUser.id!)
          .doc(); // end doc can use timestamp
      var to = FirebaseFirestore.instance
          .collection(FirebaseService.firebaseMessages)
          .doc(widget.toUser.id!)
          .collection(widget.meAccount.id!)
          .doc(); // end doc can use timestamp
      WriteBatch writeBatch = FirebaseFirestore.instance.batch();
      writeBatch.set(from, messages.toJson_());
      writeBatch.set(to, messages.toJson_());
      writeBatch
          .commit()
          .then((value) => () => {log('Create message succree ')})
          .catchError((onError) {
        log(('create message error $onError'));
      });
      //  print('message insert '+messages.toString());
      // await floorDB.me.insertMessage(messages);

      log('2: ${toUser!.id} : ${toUser!.isOnlineChat}');
      if (!toUser!.isOnlineChat!) {
        firebaseService.senNotificationNewMessage(widget.toUser.id!,
            widget.meAccount.fullName!, widget.meAccount.id!, content);
      }
      listScrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      // } else {
      //   Fluttertoast.showToast(
      //       msg: 'Nothing to send',
      //       backgroundColor: Colors.black,
      //       textColor: Colors.red);
      // }
    }
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    // PickedFile pickedFile;
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    imageFile = File(pickedFile!.path);
    if (imageFile != null) {
      setState(() {
        isLoading = true;
      });
      _uploadFile();
    }
  }

  Future _uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(imageFile!);
    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        isLoading = false;
        _onSendMessage(imageUrl!, 1);
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }

  void getSticker() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }

  _callVideo() async {
    log('call video');
  }

  _audioVideo() {
    log('audio call');
  }
}
