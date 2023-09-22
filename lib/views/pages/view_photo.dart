import 'package:flutter/material.dart';
import 'package:follow_dp/constants/constants.dart';

class ViewPhoto extends StatefulWidget {
  const ViewPhoto({super.key});

  @override
  State<ViewPhoto> createState() => _ViewPhotoState();
}

class _ViewPhotoState extends State<ViewPhoto> {
  var photoUrl;

  @override
  void initState() {
    // TODO: implement initState
    photoUrl = firebaseAuth.currentUser!.photoURL;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image(
          image: NetworkImage(photoUrl),
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
        ),
      ),
    );
  }
}
