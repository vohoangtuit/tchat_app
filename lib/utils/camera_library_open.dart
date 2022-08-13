import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraLibraryOpening{
  //final void Function(File file,int type) cameraCallback;
 // CameraLibraryOpening(this.cameraCallback);
  CameraLibraryOpening._();
  static Future cameraOpen(int type,ValueChanged<File> file)async {
    ImagePicker imagePicker = ImagePicker();
    XFile? img = await imagePicker.pickImage(source: ImageSource.camera);
    File? image;
    if (img != null) {
       image = File(img.path);
    //  cameraCallback(image, type);
       file(image);
    }
  }
  static Future libraryOpen(int type,ValueChanged<File> file) async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile? pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    File image = File(pickedFile!.path);
    file(image);

  }
}