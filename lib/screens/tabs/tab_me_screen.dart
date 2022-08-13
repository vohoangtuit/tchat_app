import 'package:flutter/material.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/screens/account/my_profile_screen.dart';
import 'package:tchat/screens/account/update_account_screen.dart';
import 'package:tchat/screens/friends/suggest_friends_screen.dart';
import 'package:tchat/constants/const.dart';
import 'package:tchat/widgets/cached_network_image.dart';
import 'package:tchat/widgets/custom_row_setting.dart';
import 'package:tchat/widgets/general_widget.dart';

import '../../widgets/custom_text.dart';

class TabMeScreen extends StatefulWidget {
   UserModel profile;
   TabMeScreen({Key? key, required this.profile}) : super(key: key);

  @override
  State<TabMeScreen> createState() => _TabMeScreenState();
}

class _TabMeScreenState extends TChatBaseScreen<TabMeScreen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _viewContent();
  }
  @override
  void initState() {
    super.initState();
    _init();
  }

  Widget _viewContent(){
    return SingleChildScrollView(
      child: Column(
        children: [
          _viewProfile(),
          spaceHeight(20),
          _listOptionUI()
        ],
      ),
    );
  }
  Widget _viewProfile() {
    return GestureDetector(
      child: Container(
        color: Colors.white,
        child: Container(
          margin:
          const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
          child: Row(
            children: [
              SizedBox(
                width: 45,height: 45,
                // child:  CircleAvatar(radius: 30.0, backgroundImage: message.photoReceiver.isEmpty ? AssetImage(PATH_AVATAR_NOT_AVAILABLE):NetworkImage(message.photoReceiver), backgroundColor: Colors.transparent,),
                child: widget.profile.photoUrl!.isEmpty?const CircleAvatar(radius: 30.0,backgroundImage:AssetImage(Const.pathAvatarNotAvailable)):Material(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(45.0)),
                  clipBehavior: Clip.hardEdge,
                  //child: cachedImage(widget.message.photoReceiver!,45.0,45.0),
                  child: cachedAvatar(context,widget.profile.photoUrl!,45.0),
                ),
              ),
              spaceWidth(20),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.profile.fullName!,
                        style: textBlackMedium(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                     spaceHeight(5),
                      Text(
                        'My Profile',
                        style: textGraysSmall(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        addScreen( MyProfileScreen(profile: widget.profile, reload: (isUpdate) {
          if(isUpdate){
            _getDataLocal();
          }
        },));
      },
    );
  }
  Widget _listOptionUI() {
    return Column(
      children: [
        CustomRowSetting(
          onPressed: () {
            // Navigator.pushNamed(context, TAG_UPDATE_ACCOUNT,
            //     arguments: account);
            addScreen(UpdateAccountScreen(account:widget.profile,reload: (isUpdate){
              if(isUpdate){
                _getDataLocal();
              }
            },));
          },
          title: 'Update Account',
          icon: 'assets/icons/ic_edit_blue.png',
        ),
        CustomRowSetting(
          onPressed: () {
            addScreen(SuggestFriendsScreen(profile: widget.profile,));
          },
          title: 'Suggest Friends',
          icon: 'assets/icons/ic_friends_light_blue.png',
        ),
        CustomRowSetting(
          onPressed: () {
            // floorDB.messageDao.deleteAllMessage();
            messageBloc.deleteAllLastMessage();
           // userBloc.
            // // todo handle clear on firebase
            // ProviderController(context).setReloadLastMessage(true);
          },
          title: 'Clear Data Chat',
          icon: 'assets/icons/ic_remove_red.png',
        ),
        CustomRowSetting(
          onPressed: () {
           // checkAccountForLogout();
            logOut();
          },
          title: 'Logout',
          icon: 'assets/icons/ic_logout.png',
        ),
      ],
    );
  }
  _init(){
    _getDataFireBase();
  }
  _getDataFireBase()async{
    getProfileFromFirebase(widget.profile.id!,saveLocal: true).then((value){
      log(value.toString());
      if(mounted){
        setState(() {
          widget.profile =value;
          userBloc.updateUserLocalDB(value);
        });
      }
      log('pro ${widget.profile.photoUrl}');
    });
  }
  _getDataLocal()async{
   await getAccountDB().then((value){
      if(mounted){
        setState(() {
          widget.profile =value;
        });
      }
    });
    log(' avatar ${widget.profile.photoUrl}');
    log(' cover ${widget.profile.cover}');
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  void onResume() {
    super.onResume();
    log('resume');
  }

}
