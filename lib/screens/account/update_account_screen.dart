import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tchat/constants/const.dart';
import 'package:tchat/dialogs/dialog_controller.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/widgets/base_button.dart';
import 'package:tchat/widgets/cached_network_image.dart';
import 'package:tchat/widgets/general_widget.dart';

import '../../utils/format_datetime.dart';


class UpdateAccountScreen extends StatefulWidget {
   UserModel account;
   final ValueChanged<bool>reload;
   UpdateAccountScreen({Key? key, required this.account,required this.reload}) : super(key: key);

  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends TChatBaseScreen<UpdateAccountScreen> {
  var controllerFullName = TextEditingController();

  File? avatarImageFile;

  DateTime selectedDate = DateTime.now();
  DateTime currentDate = DateTime.now();

  final FocusNode focusNodeFullName = FocusNode();
  final FocusNode focusNodeAboutMe = FocusNode();
  int _genderValue = 0;
  String birthday ='';
  String oldAvatar='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithTitle(context,'Profile Information'),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  information(),
                  Container(
                    margin: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                    child: BaseButton(title: 'Update',onPressed: (){
                      _handleUpdateData();
                    },),
                  ),
                ],
              ),
            ),
            // Loading
            isLoading!
                ? loadingCenter()
                : Container(),
          ],
        ),
    );
  }
  @override
  void initState() {
    super.initState();
    initData();

  }
  Widget information() {
    return Column(
      children: [
        const Divider(height: 1),
        Container(
          margin:const EdgeInsets.only(top: 14),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                const Divider(height: 1),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                             // DialogController(context).showDialogRequestUpdatePicture(baseDialog, Const.pictureTypeAvatar, viewDialogPicture );
                              DialogController(context).showDialogRequestUpdatePicture(baseDialog,  Const.pictureTypeAvatar, (type, chooseFrom) => {
                                viewDialogPicture(type,chooseFrom,(){
                                  _reload();
                                })
                              });
                            },
                            child: Stack(
                              children: <Widget>[
                                (avatarImageFile == null) ? (widget.account.photoUrl != '' ? Material(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(45.0)),
                                  clipBehavior: Clip.hardEdge,
                                  //child: cachedImage(widget.account.photoUrl!,70.0,70.0),
                                  child: cachedAvatar(context,widget.account.photoUrl!,70.0),
                                ) : avatarNotAvailable(70.0)) : loadFileMaterial(avatarImageFile!,70.0,70.0),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  width: 70,
                                  height: 70,
                                  child: Material(
                                    borderRadius: const BorderRadius.all(Radius.circular(25.0),),
                                    clipBehavior: Clip.hardEdge,
                                    shadowColor: Colors.black,
                                    child: Container(
                                      color: Colors.white,
                                      height: 20,width: 20,
                                      child: Icon(Icons.camera_alt, color: primaryColor.withOpacity(0.5),size: 15,),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 35,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          decoration: inputDecoration('Full Name'),
                                          controller: controllerFullName,
                                          onChanged: (value) {
                                            widget.account.fullName = value;
                                          },
                                          focusNode: focusNodeFullName,
                                        ),
                                      ),
                                      spaceWidth(5),
                                      iconEditInfo(),
                                    ],
                                  ),
                                ),

                                const Divider(),
                                SizedBox(
                                  height: 35,
                                  child: Row(
                                    children: [
                                      Radio(
                                        value: 1,
                                        groupValue: _genderValue,

                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        onChanged: (int? value) {
                                          setState(() {
                                            _genderValue =value!;
                                            widget.account.gender=value;
                                          });
                                      },
                                       // onChanged: _handleRadioValueChange(1),

                                      ),
                                      const Text('Male'),
                                      Radio(
                                        value: 0,
                                        groupValue: _genderValue, onChanged: (int? value) {
                                          setState(() {
                                            _genderValue =value!;
                                            widget.account.gender=value;
                                          });
                                      },
                                        //onChanged: _handleRadioValueChange(0),

                                      ),
                                      const Text('Female'),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                SizedBox(
                                  height: 35,
                                  child: GestureDetector(
                                    onTap: (){
                                      _selectDate(context);
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(child: Text(birthday)),
                                        iconEditInfo(),
                                      ],),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 0.5,
        ),
      ],
    );
  }
  initData() async {
   // log('sas ${widget.account.gender}');
    setState(() {
      controllerFullName.text =widget.account.fullName!;
    });
    if(widget.account.gender!=null){
      setState(() {
        _genderValue =widget.account.gender!;
      });
    }
    // else{
    //   setState(() {
    //     widget.account.gender=_genderValue;
    //   });
    // }
  }
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1960),
      lastDate: currentDate,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthday =FormatDateTime.stringDay_DD_MM_YYYY_FromDateime(selectedDate);
        widget.account.birthday =FormatDateTime().covertTimestampToMilliseconds(selectedDate);
      });
    }
  }
   _handleUpdateData()async {
    if(controllerFullName.text.isEmpty){
      return;
    }
    widget.account.fullName =controllerFullName.text;
    focusNodeFullName.unfocus();
    focusNodeAboutMe.unfocus();
    setState(() {
      isLoading = true;
    });
    await  updateUserAccount(widget.account);
    widget.reload(true);
    setState(() {
      isLoading = false;
    });
  }
  _reload()async{
    await getAccountDB().then((value) => {
      if(mounted){
        setState((){
          widget.account =value;
        })
      },
    widget.reload(true)
    });
  }
}
