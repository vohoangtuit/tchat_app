import 'package:flutter/material.dart';

class ProfilePhotos extends StatefulWidget {
  const ProfilePhotos({Key? key}) : super(key: key);

  @override
  State<ProfilePhotos> createState() => _ProfilePhotosState();
}

class _ProfilePhotosState extends State<ProfilePhotos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Photos'),
    );
  }
}
