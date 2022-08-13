import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tchat/dialogs/dialog_controller.dart';
import 'package:tchat/models/friends_model.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/screens/chat/chat_screen.dart';
import 'package:tchat/screens/tabs/profile/profile_photos.dart';
import 'package:tchat/screens/tabs/profile/profile_timeline.dart';
import 'package:tchat/constants/const.dart';
import 'package:tchat/utils/utils.dart';
import 'package:tchat/widgets/custom_button_with_title.dart';
import 'package:tchat/widgets/custom_text.dart';
import 'package:tchat/widgets/general_widget.dart';

class UserProfileScreen extends StatefulWidget {
 final UserModel myProfile;
 final UserModel user;

  const UserProfileScreen({Key? key, required this.myProfile, required this.user}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends TChatBaseScreen<UserProfileScreen> {
  final ScrollController _scrollController=ScrollController();
  bool lastStatus = true;

  // bool isFriend = false;
  int statusRequest = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DefaultTabController(
            length: 2,
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context_, bool innerBoxIsScrolled) {
                context = context_;
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
                            print('more');
                            //   openScreen(UpdateAccountScreen(userModel));
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
                              child:  SizedBox(
                                width: 36.0,
                                height: 36.0,
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:  widget.user.photoUrl!.isEmpty ?const AssetImage(Const.pathAvatarNotAvailable)as ImageProvider: NetworkImage(widget.user.photoUrl!),

                                ),
                              ),
                              onTap: () {
                                DialogController(context)
                                    .showDialogViewSingleImage(
                                    baseDialog, widget.user.photoUrl!);
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.user.fullName!,
                              textAlign: TextAlign.center,
                              style: isShrink
                                  ? textBlackMedium()
                                  : textWhiteMedium(),
                            ),
                          ],
                        ),
                      ),
                      // ignore: null_aware_in_condition
                      background: Utils.isNotEmpty(widget.user.cover!)??false
                          ? InkWell(
                        child: Image.asset(
                          Const.pathCoverNotAvailable,
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          //DialogController(context).ShowDialogViewSingleImage(dialog, userModel.cover);
                        },
                      )
                          : InkWell(
                          child:
                          //CachedNetworkImageProvider(userModel.cover),
                          Image.network(
                            widget.user.cover!,
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            DialogController(context)
                                .showDialogViewSingleImage(
                                baseDialog, widget.user.cover!);
                          }),
                    ),
                  ),

                ];
              },
              body: Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        //isFriend ? Container() : viewAddFriend(),
                        statusRequest == FriendModel.friendNotRequest
                            ? _viewAddFriend()
                            : statusRequest == FriendModel.friendSendRequest
                            ? _viewAddFriend()
                            : statusRequest == FriendModel.friendWaitingConfirm
                            ? _viewAcceptFriend()
                            : Container(),
                        statusRequest == FriendModel.friendSuccess
                            ? viewTabBarActivity()
                            : Container(),
                      ],
                    ),
                    statusRequest == FriendModel.friendWaitingConfirm
                        ? _viewButtonChat()
                        : statusRequest == FriendModel.friendSuccess
                        ? _viewButtonChat()
                        : Container(),
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
    _scrollController.addListener(_scrollListener);
    // _tabController = new TabController(length: 2, vsync: this);
    _checkIsFriend();
  }
  Widget _viewAddFriend() {
    return Container(
      color: Colors.grey[50],
      child: Padding(
        padding:
        const EdgeInsets.only(left: 30, top: 20, right: 30, bottom: 10),
        child: Column(
          children: [
            Text(
              'Make friend with ${widget.user.fullName} and have cool and unforgettable conversations together!',
              style: textBlackMedium(),
              textAlign: TextAlign.center,
            ),
            spaceHeight(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButtonWithTitle(
                  title: 'MESSAGE',
                  colorButton: Colors.blue[100],
                  colorText: Colors.blue,
                  sizeText: 13.0,
                  onPressed: () {
                    addScreen(ChatScreen(meAccount: widget.myProfile, toUser: widget.user));
                  },
                ),
                CustomButtonWithTitle(
                  title: statusRequest == FriendModel.friendNotRequest ? 'ADD FRIEND' : 'UNDO REQUEST',
                  colorButton: statusRequest == FriendModel.friendNotRequest ? Colors.blue : Colors.blue[50],
                  colorText: statusRequest == FriendModel.friendNotRequest ? Colors.white : Colors.black45, sizeText: 13.0,
                  onPressed: () {
                    if (statusRequest == FriendModel.friendNotRequest) {
                      _requestAddFriend();
                    } else if (statusRequest == FriendModel.friendSendRequest) {
                      _undoRequest();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _viewAcceptFriend() {
    return Container(
      color: Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.only(left: 30, top: 20, right: 30, bottom: 10),
        child: Column(
          children: [
            Text(
              'Wants to be friends',
              style: textBlackMedium(),
              textAlign: TextAlign.center,
            ),
            spaceHeight(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButtonWithTitle(
                  title: 'DECLINE',
                  colorButton: Colors.blue[100],
                  colorText: Colors.black,
                  sizeText: 13.0,
                  onPressed: () {
                    // declineFriend();
                    _undoRequest();
                  },
                ),
                CustomButtonWithTitle(
                  title: 'ACCEPT',
                  colorButton: Colors.blue,
                  colorText: Colors.white,
                  sizeText: 13.0,
                  onPressed: () {
                    _acceptFriend();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _viewButtonChat() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 10),
        child: ButtonTheme(
          child: RaisedButton(
            onPressed: () {
             // openScreenWithName(ChatScreen(user));
              addScreen(ChatScreen(meAccount: widget.myProfile, toUser: widget.user));
            },
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius:  BorderRadius.circular(30.0)),
            child: SizedBox(
              width: 60,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.message,
                    color: Colors.blue,
                    size: 20,
                  ),
                  //  SizedBox(width: 8.0,),
                  Text(
                    'Chat',
                    style: textBlackNormal(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget viewTabBarActivity() {
    return Expanded(
      child: Column(
        children: [
          TabBar(
            indicatorColor: Colors.blueGrey,
            indicatorWeight: 1,
            //indicatorSize: TabBarIndicatorSize.label,
            //   isScrollable: true,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey[350],
            tabs: listTab(),
          ),
          const Expanded(
            child: TabBarView(
              children: <Widget>[ProfileTimeLine(), ProfilePhotos()],
            ),
          )
        ],
      ),
    );
  }

  List<Tab> listTab() {
    return <Tab>[
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.wysiwyg),
            SizedBox(
              width: 8.0,
            ),
            Text("Logs"),
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.photo),
            SizedBox(
              width: 8.0,
            ),
            Text("Photos"),
          ],
        ),
      ),
    ];
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
  _checkIsFriend() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot variable =
    await firebaseService.checkUserIsFriend(widget.myProfile.id!, widget.user.id!);
    if (variable.data() != null) {
      //  print('variable ' + variable.data()['statusRequest'].toString());
      Map<String, dynamic> json = variable.data() as  Map<String, dynamic>;
      setState(() {
        statusRequest = json[FriendModel.friendStatusRequest];
        isLoading = false;
      });
    } else {
      setState(() {
        statusRequest = FriendModel.friendNotRequest;
        isLoading = false;
      });
      //   print('222222');
    }
  }
  _requestAddFriend() async {
    // https://stackoverflow.com/questions/46618601/how-to-create-update-multiple-documents-at-once-in-firestore?noredirect=1&lq=1
    setState(() {
      isLoading = true;
    });
    var timeRequest =DateTime.now().millisecondsSinceEpoch.toString();
    FriendModel fromRequest = FriendModel(
        id: widget.user.id,
        fullName: widget.user.fullName,
        photoURL: widget.user.photoUrl,
        timeRequest: timeRequest,
        statusRequest: FriendModel.friendSendRequest);
    FriendModel toRequest = FriendModel(
        id: widget.myProfile.id,
        fullName: widget.myProfile.fullName,
        photoURL: widget.myProfile.photoUrl,
        timeRequest: timeRequest,
        statusRequest: FriendModel.friendWaitingConfirm);

    await firebaseService.requestAddFriend(widget.myProfile,widget.user,fromRequest,toRequest).then((value){
      setState(() {
        log('request success');
        statusRequest = FriendModel.friendSendRequest;
        isLoading = false;

      });
      firebaseService.sentNotificationRequestAddFriend(widget.user.id!,widget.myProfile.fullName!,widget.myProfile.id!);
    });

  }

  _undoRequest() async {
    await firebaseService.removeFriend(widget.myProfile.id!, widget.user.id!).then((value){
      if(mounted){
        setState(() {
          print('ok:222222222:');
          isLoading =false;
          statusRequest = FriendModel.friendNotRequest;
          ///ProviderController(context).setReloadContacts(true);
        });
      }
    });
  }

  _acceptFriend() async{
    // https://stackoverflow.com/questions/46618601/how-to-create-update-multiple-documents-at-once-in-firestore?noredirect=1&lq=1
    setState(() {
      isLoading = true;
    });
    await firebaseService.acceptFriend(widget.myProfile.id!, widget.user.id!).then((value){
      setState(() {
        print('ok:::::::::::::');
        isLoading =false;
        statusRequest = FriendModel.friendSuccess;
       // ProviderController(context).setReloadContacts(true);
      });
    });
  }

}
