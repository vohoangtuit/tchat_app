import 'package:flutter/material.dart';
import 'package:tchat/utilities/const.dart';
import 'package:tchat/widgets/custom_text.dart';

class ToolBarMain extends StatefulWidget {
 final int position;
 final ValueChanged onClick;
  const ToolBarMain({Key? key, required this.position,required this.onClick}) : super(key: key);

 @override
  State<ToolBarMain> createState() => _ToolBarMainState();
}

class _ToolBarMainState extends State<ToolBarMain> {
  int search=1;
  int add =2;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,

      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15.0,top: 0.0,right: 10.0,bottom: 0.0),
            child: GestureDetector(child: Image.asset('assets/icons/ic_search.png',width: 20,height: 20,),
              onTap: (){
              },
            ),
          ),
          Expanded(
            child: SizedBox.expand(// todo: using SizedBox.expand to full width
              child: FlatButton(
                child: Align(
                    alignment: Alignment.centerLeft,
                //    child: Text('Search ...',style: textHeaderBar(),)),
                    child: textWhite('Search')),
                onPressed: (){
                  widget.onClick(mainClickSearch);
                },
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(left: 8.0,top: 0.0,right: 10.0,bottom: 0.0),
            child: Row(
              children: [
                widget.position==0 ?GestureDetector(child: Image.asset('assets/icons/ic_plus.png',width: 22,height: 22,),onTap: (){// todo icon tab 1
                  setState(() {
                    widget.onClick(mainClickAddTabMessage);
                  });

                },):widget.position==1?GestureDetector(child: Image.asset('assets/icons/ic_add_user.png',width: 20,height: 20,),onTap: (){// todo icon tab 2
                  setState(() {
                    widget.onClick(mainClickAddContact);
                  });

                },):widget.position==2?GestureDetector(child: Image.asset('assets/icons/ic_plus.png',width: 20,height: 20,),onTap: (){// todo icon tab 3
                  setState(() {
                    widget.onClick(mainClickAddGroup);
                  });

                },):GestureDetector(child: Image.asset('assets/icons/ic_settings.png',width: 20,height: 20,),onTap: (){// todo icon tab 5
                  setState(() {
                    widget.onClick(mainClickSettingTabMore);
                  });

                },),
                // widget.position==3?Row(// todo icon tab 4
                //   children: [
                //     GestureDetector(child: Image.asset('assets/icons/ic_edit.png',width: 20,height: 20,),onTap: (){
                //       setState(() {
                //         widget.onClick(mainClickAddTimeLine);
                //       });
                //     },),
                //     const SizedBox(width: 20,),
                //     GestureDetector(child: Image.asset('assets/icons/ic_notification.png',width: 20,height: 20,),onTap: (){
                //       setState(() {
                //         widget.onClick(mainClickNotificationTabTimeLine);
                //       });
                //     },),
                //   ],
                // ):
              ],
            ) ,
          ),
        ],
      ),
    );
  }
}
