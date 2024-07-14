import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'Fabtabs.dart';

class ProfilePictureController extends GetxController {
  Rx<File?> image = Rx<File?>(null);

  void setImage(File? newImage) {
    image.value = newImage;
  }

  File? get getImage => image.value;
}

class Sidemenu extends StatefulWidget {
  const Sidemenu({Key? key}) : super(key: key);

  @override
  State<Sidemenu> createState() => _SidemenuState();
}

class _SidemenuState extends State<Sidemenu> {
  bool isDarkMode = Get.isDarkMode;
  final ProfilePictureController _profilePictureController =
  Get.put(ProfilePictureController());

  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File selectedImage = File(pickedFile.path);
      _profilePictureController.setImage(selectedImage);
    } else {
      print('No image selected.');
    }
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File selectedImage = File(pickedFile.path);
      _profilePictureController.setImage(selectedImage);
    } else {
      print('No image selected.');
    }
  }

  void toggleThemeMode() {
    Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: isDarkMode ? Colors.grey[900]! : Colors.orange,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Obx(() => UserAccountsDrawerHeader(
            accountName: const Text('Bruno Ray'),
            accountEmail: const Text('brunoray@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: _profilePictureController.getImage != null
                  ? FileImage(_profilePictureController.getImage!)
                  : AssetImage('assets/jj.jpg'),
              child: GestureDetector(
                onTap: () {
                  // Open dialog to choose image source
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Select Image"),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              GestureDetector(
                                child: Text("Select from gallery"),
                                onTap: () {
                                  getImageFromGallery();
                                  Navigator.of(context).pop();
                                },
                              ),
                              Padding(padding: EdgeInsets.all(8.0)),
                              GestureDetector(
                                child: Text("Take a picture"),
                                onTap: () {
                                  getImageFromCamera();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: ClipOval(child: Icon(Icons.camera_alt)),
              ),
            ),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800]! : Colors.blueAccent,
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          )),
          ListTile(
            leading: Icon(Icons.login,
                color: isDarkMode ? Colors.white : Colors.black),
            title: Text("Sign in",
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Fabtabs(selectedIndex: 0)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person,
                color: isDarkMode ? Colors.white : Colors.black),
            title: Text("Sign up",
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Fabtabs(selectedIndex: 1)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate,
                color: isDarkMode ? Colors.white : Colors.black),
            title: Text("Calculator",
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Fabtabs(selectedIndex: 2)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.color_lens,
                color: isDarkMode ? Colors.white : Colors.black),
            title: Text("Switch Theme",
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
            onTap: toggleThemeMode,
          ),
        ],
      ),
    );
  }
}
