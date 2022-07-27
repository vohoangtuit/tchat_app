import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tchat/allConstants/color_constants.dart';
import 'package:tchat/allConstants/size_constants.dart';
import 'package:tchat/allConstants/text_field_constants.dart';
import 'package:tchat/models/chat_messages.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/providers/chat_provider.dart';
import 'package:tchat/screens/TChatScreen.dart';
import 'package:tchat/widgets/items/item_message.dart';

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
  List<ChatMessages> listMessage =<ChatMessages>[];
  Stream? chat;
  List<ChatMessages>? list;
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
            onPressed: () {
            },
            icon: const Icon(Icons.phone),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: Sizes.dimen_8),
          child: Column(
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
  Widget _buildListMessageStream() {
    return Flexible(
      child: listMessage.isNotEmpty
          ? ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: listMessage.length,
          //reverse: true,
          controller: scrollController,
          itemBuilder: (context, index) =>
              ItemMessage(item: listMessage[index],me: widget.meAccount,toUser: widget.toUser,))
          : Center(
        child: Container(),
      ),
    );
  }
  Widget _buildListMessage() {
    return Flexible(
      child: listMessage.isNotEmpty
          ? ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: listMessage.length,
        //  reverse: true,
          controller: scrollController,
          itemBuilder: (context, index) =>
              ItemMessage(item: listMessage[index],me: widget.meAccount,toUser: widget.toUser,))
          : Center(
        child: Container(),
      ),
    );
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
  _init()async{
   await initFireBase();
    _getListMessage();
  }
   _getListMessage()async {
     // await realTimeDatabase.getListChat(widget.meAccount.id!, widget.toUser.id!).then((value) => {
     //   setState((){
     //     listMessage.addAll(value);
     // })
     // });
     // if(listMessage.isNotEmpty){
     //   for (var item in listMessage) {
     //  log(item.content);
     //
     //   }}
    // realTimeDatabase.
      realTimeDatabase.databaseReference.child('Messages/${widget.meAccount.id!}/${widget.toUser.id}').onChildAdded.listen((event) {
       Map<dynamic, dynamic> values = event.snapshot.value as Map<dynamic, dynamic>;
       ChatMessages item =ChatMessages.fromJson(values);
       log('item ${item.content}');
       List<ChatMessages> list =[];
       //list.add(item);
      // listMessage.add(item);
       setState(() {
         listMessage.add(item);
      //   listMessage =List.from(listMessage.reversed);
      });
     // log('listMessage ${listMessage.length}');
     });
  }
  void onSendMessage(String content, int type) {
    if(content.trim().isEmpty){
      return;
    }
    textEditingController.clear();

    realTimeDatabase.sendMessage(widget.meAccount, widget.toUser, content, type);
  }
  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        uploadImageFile();
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
