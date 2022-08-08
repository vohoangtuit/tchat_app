import 'package:flutter/material.dart';

class ProfileTimeLine extends StatefulWidget {
  const ProfileTimeLine({Key? key}) : super(key: key);

  @override
  State<ProfileTimeLine> createState() => _ProfileTimeLineState();
}

class _ProfileTimeLineState extends State<ProfileTimeLine> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('TimeLine'),
    );
  }
}
