

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key,required this.imageValidation}) : super(key: key);

  final void Function(File? pickedImage) imageValidation;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  pickUserImage() async {
    var picker = ImagePicker();
    var pickedImage = await picker.pickImage(source: ImageSource.camera,
    imageQuality: 10,
    maxWidth: 150,
    );
    setState(() {
      _pickedImage = File(pickedImage!.path);
    });
    widget.imageValidation(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton(
          onPressed: pickUserImage,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.image),
              SizedBox(
                width: 8,
              ),
              Text('Add Image'),
            ],
          ),
        ),
        const SizedBox(height: 8,),
      ],
    );
  }
}
