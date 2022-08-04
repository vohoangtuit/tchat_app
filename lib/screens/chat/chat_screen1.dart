
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
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/utilities/const.dart';
import 'package:tchat/widgets/custom_text.dart';
import 'package:tchat/widgets/general_widget.dart';
import 'package:tchat/widgets/items/item_message.dart';

class ChatScreen1 extends StatefulWidget {
  final UserModel meAccount;
  final UserModel toUser;
   const ChatScreen1({Key? key, required this.meAccount, required this.toUser}) : super(key: key);

  @override
  State<ChatScreen1> createState() => _ChatScreen1State();
}

class _ChatScreen1State extends TChatBaseScreen<ChatScreen1> {

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
        titleSpacing:-8.0,
        title: SizedBox(// todo custom title
          height: 54,
          child: InkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWhite(toUser==null?'':toUser!.fullName!),
              ],
            ),
            onTap: (){
             // openScreenWithName(toUser!=null?UserProfileScreen(myProfile: account,user: toUser,):(){
           //   });
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
                        icon:  Image.asset(
                          'assets/icons/phone_white.png',
                          width: 28,
                          height: 22,
                        ),
                        onPressed: () => _audioVideo()),
                    IconButton(
                        icon:  Image.asset(
                          'assets/icons/camera_white.png',
                          width: 28,
                          height: 28,
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
  Widget _listChat() {
    return Flexible(child: StreamBuilder<QuerySnapshot>(
      stream: chats,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          listMessage.clear();
          listMessage.addAll(
              ChatMessages.listFromSnapshot(snapshot.data!.docs));
          return ListView.builder(
           //shrinkWrap: true,
            reverse: true,
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
      child: isLoading! ?  loadingCenter() : Container(),
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
  _init()async{
    setState(() {
      toUser =widget.toUser;
    });
    await _initData();
    await _getProfileUser();
  }
  _getProfileUser()async{
    await firebaseDataFunc.getInfoUserProfile(widget.toUser.id!).then((value) {
      if (value.data() != null) {
        Map<String, dynamic> json = value.data() as  Map<String, dynamic>;
        UserModel userModel = UserModel.fromJson(json);
        setState(() {
          if(mounted){
           toUser = userModel;
          }
        });
      }
    });
  }
  _scrollListener() {
    if (listScrollController.offset >=
        listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the bottom");
      setState(() {
        print("reach the bottom");
        _limit += _limitIncrement;
      });
    }
    if (listScrollController.offset <=
        listScrollController.position.minScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the top");
      setState(() {
        print("reach the top");
      });
    }
  }
  _initData() async {
    print("initData()>>>>>>>>>>>>");
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
   // checkUserOnline();
    _listenerData();
   // sendMeOnline(true);
  }
  _onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }
  _getMessage() async{
    firebaseDataFunc.getMessageChat(widget.meAccount.id!, widget.toUser.id!)
        .then((value) {
      setState(() {
        chats = value;
      });
    });
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
        log('change ${change.toString()}');
        //{idDB: 1, id: 8AC6oXq9WAcGm4pZgKjMtqV09d53, email: nhompro3@gmail.com, userName: null, fullName: Võ Hoàng Duy, birthday: , gender: null, photoUrl: https://lh3.googleusercontent.com/a-/AOh14GgTpwZVaZPpI3aP4liXuR8uSFVkaNVxD6wsFKKN=s96-c, cover: null, statusAccount: null, phone: , createdAt: null, lastUpdated: null, lastLogin: null, deviceToken: null, isLogin: null, address: , isOnline: null, accountType: 2, isOnlineChat: null, allowSearch: null, latitude: null, longitude: null}
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
  _onSendMessage(String content, int type) async {
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
          .then((value) => () => {log('Create message succree ')})
          .catchError((onError) {
        log(('create message error $onError'));
      });
      //  print('message insert '+messages.toString());
        // await floorDB.me.insertMessage(messages);
      //   print('toUser.isOnlineChat '+toUser.isOnlineChat.toString());
      //   if(!toUser.isOnlineChat){
      //     senNotificationNewMessage(toUser.id,account.fullName,account.id,content);
      //   }
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
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
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
