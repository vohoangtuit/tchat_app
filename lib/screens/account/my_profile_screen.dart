import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tchat/dialogs/dialog_controller.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/constants/const.dart';
import 'package:tchat/utils/utils.dart';
import 'package:tchat/widgets/cached_network_image.dart';
import 'package:tchat/widgets/custom_text.dart';
import 'package:tchat/widgets/general_widget.dart';
import 'package:tchat/widgets/sliver_appbar_delegate.dart';

class MyProfileScreen extends StatefulWidget {
  final ValueChanged<bool>reload;
   UserModel profile;
   MyProfileScreen({Key? key, required this.profile, required this.reload}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends TChatBaseScreen<MyProfileScreen> {
  final _scrollController = ScrollController();
  bool lastStatus = true;
  File?avatarImageFile;
  File? coverImageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DefaultTabController(
            length: 2,
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context_, bool innerBoxIsScrolled) {
                context =context_;
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 225.0,
                    floating: true,
                    pinned: true,
                    primary: true,
                    snap: true,
                    backgroundColor: Colors.white,
                    iconTheme: IconThemeData(
                      color: isShrink
                          ? Colors.black
                          : Colors.white, //change your color here
                    ),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.favorite,
                              color: isShrink ? Colors.black : Colors.white),
                          onPressed: () {
                            print('my favorite');
                          }),
                      IconButton(
                          icon: Icon(Icons.more_horiz,
                              color: isShrink ? Colors.black : Colors.white),
                          onPressed: () {
                           // openScreenWithName(UpdateAccountScreen(account));
                          })
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: false,
                      titlePadding: const EdgeInsets.only(
                          left: 50, top: 0.0, right: 0.0, bottom: 10.0),
                      title: Container(
                        // height: 225,
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              child:
                              SizedBox(
                                width: 36,height: 36,
                                // child:  CircleAvatar(radius: 30.0, backgroundImage: message.photoReceiver.isEmpty ? AssetImage(PATH_AVATAR_NOT_AVAILABLE):NetworkImage(message.photoReceiver), backgroundColor: Colors.transparent,),
                                child: widget.profile.photoUrl!.isEmpty?const CircleAvatar(radius: 30.0,backgroundImage:AssetImage(Const.pathAvatarNotAvailable)):Material(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(45.0)),
                                  clipBehavior: Clip.hardEdge,
                                  //child: cachedImage(widget.message.photoReceiver!,45.0,45.0),
                                  child: cachedAvatar(context,widget.profile.photoUrl!,36),
                                ),
                              ),
                              onTap: () {
                               // DialogController(context).showDialogRequestUpdatePicture(dialog, pictureTypeAvatar, viewDialogPicture);
                                DialogController(context).showDialogRequestUpdatePicture(baseDialog,  Const.pictureTypeAvatar, (type, chooseFrom) => {
                                  viewDialogPicture(type,chooseFrom,(){
                                    _reload();
                                  })
                                });
                              },
                            ),
                          spaceWidth(10),
                            textCenter(widget.profile.fullName!),
                          ],
                        ),
                      ),
                      background: InkWell(
                        onTap: (){
                          DialogController(context).showDialogRequestUpdatePicture(baseDialog,  Const.pictureTypeCover, (type, chooseFrom) => {
                            viewDialogPicture(type,chooseFrom,(){
                              _reload();
                            })
                          });
                        },
                       // child: Utils.isNotEmpty(widget.profile.cover)??true ?Image.network(widget.profile.cover!, fit: BoxFit.cover,)
                        child: Utils.isNotEmpty(widget.profile.cover)??true ? cachedImage(context, widget.profile.cover!, BoxFit.cover,)
                        :Image.asset(
                          Const.pathCoverNotAvailable,
                          fit: BoxFit.cover,
                        )
                        ,
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    // todo using to keep when scroll to top
                    delegate: SliverAppBarDelegate(
                      TabBar(
                        labelColor: Colors.black87,
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.wysiwyg),
                                SizedBox(width: 10,),
                                Text("Logs"),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.photo),
                                SizedBox(width: 10,),
                                Text("Photos"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    textRed('data'),
                  ],
                ),
              ),
            ),
          ),
          isLoading! ? loadingCenter() : Container(),
        ],
      ),
    );
  }
  @override
  void initState() {

    super.initState();
    initData();

    _scrollController.addListener(_scrollListener);
  }
  initData() async {


  }
  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }
  _reload()async{
    await getAccountDB().then((value) => {
      if(mounted){
        setState((){
          widget.profile =value;
        }),
      },
    });
    widget.reload(true);
  }
}
