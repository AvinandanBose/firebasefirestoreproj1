import 'package:flutter/material.dart';

class UpdateProfilePicture extends StatefulWidget {
  final String nameprof;
  const UpdateProfilePicture({Key? key, required this.nameprof}) : super(key: key);

  @override
  State<UpdateProfilePicture> createState() => _UpdateProfilePictureState();
}

class _UpdateProfilePictureState extends State<UpdateProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Update ${widget.nameprof}\'s pic'),
      ),
    );
  }
}
