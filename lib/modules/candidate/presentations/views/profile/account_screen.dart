import 'dart:io';

import 'package:app/configs/image_factory.dart';
import 'package:app/modules/candidate/data/models/hive_models/user_model_hive.dart';
import 'package:app/modules/candidate/domain/providers/provider_user.dart';
import 'package:app/modules/candidate/presentations/views/widgets/button_app.dart';
import 'package:app/modules/candidate/presentations/views/widgets/compulsory_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AccountScreen extends StatefulWidget {
  AccountScreen({super.key, required this.avatar});

  String? avatar;
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _user = Hive.box<UserModel>('user');

  File? imageFile;
  final picker = ImagePicker();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  _imgFromCamera() async {
    await picker
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _imgFromGallery() async {
    await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Image Cropper",
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        imageFile = File(croppedFile.path);
      });
      // reload();
    }
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                      child: Column(
                        children: const [
                          Icon(
                            Icons.image,
                            size: 60.0,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            "Gallery",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.pop(context);
                      },
                    )),
                    Expanded(
                        child: InkWell(
                      child: SizedBox(
                        child: Column(
                          children: const [
                            Icon(
                              Icons.camera_alt,
                              size: 60.0,
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              "Camera",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.pop(context);
                      },
                    ))
                  ],
                )),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    firstNameController.text = _user.get('userLogin')!.firstName;
    lastNameController.text = _user.get('userLogin')!.lastName;
    phoneController.text = _user.get('userLogin')!.phone;
    genderController.text = _user.get('userLogin')!.gender;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = context.watch<ProviderUser>();
    return Scaffold(
        body: SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          SizedBox(
            width: size.width,
            height: 200,
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    child: Container(
                      height: 120,
                      width: size.width,
                      decoration: const BoxDecoration(color: Colors.black),
                    )),
                Positioned(
                    top: 60,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.all(15),
                      height: 120,
                      width: size.width - 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showImagePicker(context);
                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 2, color: Colors.red),
                                  image: imageFile != null
                                      ? DecorationImage(
                                          image: FileImage(imageFile!))
                                      : widget.avatar != null
                                          ? DecorationImage(
                                              image:
                                                  NetworkImage(widget.avatar!))
                                          : const DecorationImage(
                                              image: AssetImage(
                                                  ImageFactory.editCV))),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '${_user.get('userLogin')!.firstName.toUpperCase()} ${_user.get('userLogin')!.lastName.toUpperCase()}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Mã ứng viên: ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    _user.get('userLogin')!.id.substring(0, 7),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const CompulsoryText(title: 'Tên'),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.only(bottom: 20, top: 7),
                  height: 50,
                  width: size.width - 30,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 208, 229, 247),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    controller: lastNameController,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),

                //first name
                const CompulsoryText(title: 'Họ'),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.only(bottom: 20, top: 7),
                  height: 50,
                  width: size.width - 30,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 208, 229, 247),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    controller: firstNameController,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),

                //phoneNumber
                const CompulsoryText(title: 'Số điện thoại'),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.only(bottom: 20, top: 7),
                  height: 50,
                  width: size.width - 30,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 208, 229, 247),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),

                //gender
                const CompulsoryText(title: 'Giới tính'),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.only(bottom: 20, top: 7),
                  height: 50,
                  width: size.width - 30,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 208, 229, 247),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    controller: genderController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ButtonApp(
              paddingvertical: 15,
              borderRadius: 10,
              title: 'Lưu',
              onPress: () {
                provider.updateUser(
                    firsName: firstNameController.text,
                    lastName: lastNameController.text,
                    phone: phoneController.text,
                    gender: genderController.text,
                    id: _user.values.toList()[0].id,
                    avatar: imageFile);
              },
            ),
          )
        ],
      ),
    ));
  }
}
