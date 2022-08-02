import 'package:flutter/material.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/screens/account/my_profile_screen.dart';
import 'package:tchat/utilities/const.dart';
import 'package:tchat/widgets/custom_row_setting.dart';
import 'package:tchat/widgets/general_widget.dart';

import '../../widgets/custom_text.dart';

class TabProfileScreen extends StatefulWidget {
  final UserModel profile;
  const TabProfileScreen({Key? key, required this.profile}) : super(key: key);

  @override
  State<TabProfileScreen> createState() => _TabProfileScreenState();
}

class _TabProfileScreenState extends TChatBaseScreen<TabProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return _viewContent();
  }
  @override
  void initState() {
    super.initState();

    _getData();
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
                width: 45,
                height: 45,
                child: widget.profile.photoUrl!.isEmpty?const CircleAvatar(radius: 30.0,backgroundImage:AssetImage(pathAvatarNotAvailable)):Material(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(45.0)),
                  clipBehavior: Clip.hardEdge,
                  child: cachedImage(widget.profile.photoUrl!,45.0,45.0),
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
        addScreen(const MyProfileScreen());
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
          },
          title: 'Update Account',
          icon: 'assets/icons/ic_edit_blue.png',
        ),
        CustomRowSetting(
          onPressed: () {
           // openScreenWithName(SuggestFriendsScreen(account));
          },
          title: 'Suggest Friends',
          icon: 'assets/icons/ic_friends_light_blue.png',
        ),
        CustomRowSetting(
          onPressed: () {
            // floorDB.messageDao.deleteAllMessage();
            // floorDB.lastMessageDao.deleteAllLastMessage();
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
  _getData()async{
    initConfig();
    await getAccountFromFloorDB();
  }

}
