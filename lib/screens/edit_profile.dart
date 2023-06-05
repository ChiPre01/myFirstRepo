import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoutes/models/user.dart';
import 'package:scoutes/utilis/utilis.dart';
import 'package:scoutes/widgets/text_field_input.dart';

class EditProfileScreen extends StatefulWidget {
  final String uid;
  const EditProfileScreen({super.key, required this.uid});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
 
  TextEditingController fullnameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  Uint8List? _image;
  bool isLoading = false;
  bool _fullnameValid = true;
  bool _bioValid = true;
  User? user;

  @override
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();
    user = User.fromSnap(snap);
    fullnameController.text = user!.fullname;
    bioController.text = user!.bio;
    setState(() {
      isLoading = false;
    });
  }

  updateProfileData() {
    setState(() {
      fullnameController.text.trim().length < 3 ||
              fullnameController.text.isEmpty
          ? _fullnameValid = false
          : _fullnameValid = true;
      bioController.text.trim().length < 3 || bioController.text.isEmpty
          ? _bioValid = false
          : _bioValid = true;
    });
    if (_fullnameValid && _bioValid) {
      FirebaseFirestore.instance.collection('users').doc(widget.uid).update({
        "fullname": fullnameController.text,
        "bio": bioController.text,
      });
     
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Edit Profile",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Go Back',
                style: TextStyle(
                    color: Color.fromARGB(255, 47, 41, 58),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ],
        ),
        body: SafeArea(
          
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: ListView(
            shrinkWrap: true,
            children: [
                CircleAvatar(
                      backgroundImage: NetworkImage(
                        user!.photoUrl,
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                hintText: 'Enter your fullname',
                textInputType: TextInputType.text,
                textEditingController: fullnameController,
                
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
                textEditingController: bioController,
                
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: updateProfileData,
                child: Container(
                  child: Text(
                    'Update Profile',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          4,
                        ),
                      ),
                    ),
                    color: Colors.white
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
