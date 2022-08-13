import 'package:flutter/material.dart';
import 'package:tchat/general/base_dialog.dart';
import 'package:tchat/constants/const.dart';
import 'package:tchat/widgets/custom_text.dart';
import 'package:tchat/widgets/general_widget.dart';


class DialogSelectPictures extends BaseDialog{
  final void Function(int type, int choose) callback;
  final int type;
  DialogSelectPictures({Key? key, required this.type,required this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    this.context =context;
    dialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: initUI(),
    );
    return dialog!;
  }
  Widget initUI(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10,top:10,right: 10,bottom: 0),
          child:Column(
            children: [
              Text(type==Const.pictureTypeAvatar?'Avatar':'Cover',style: textGraysSmall(),),
             spaceHeight(10),

              const Divider(height: 0.5,),
              InkWell (
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center ,
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height:45,child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(type==Const.pictureTypeAvatar?'View profile picture':'View full cover',style: textBlackMedium(),),
                      ],
                    )),
                  ],
                ),
                onTap: (){
                  callback(type,Const.choosePictureViewPicture);
                  dismiss();
                },
              ),
              const Divider(height: 0.5,),
              InkWell (
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height:45, child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Take Photo',style: textBlackMedium(),),
                        ],
                      )),
                    ],
                  ),
                onTap: (){
                    callback(type,Const.choosePictureCamera);
                    dismiss();
                },
              ),
              const Divider(height: 0.5,),
              InkWell (child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height:45, child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Text('Choose From Photos',style: textBlackMedium(),),
                    ],
                  )),
                ],
              ),
                onTap: (){
                  callback(type,Const.choosePictureLibrary);
                  dismiss();
                },
              ),
              const Divider(height: 0.5,),
            ],
          )
        ),
      ],
    );

  }
}