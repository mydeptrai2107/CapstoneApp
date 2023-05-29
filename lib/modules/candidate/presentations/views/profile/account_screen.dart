// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:app/configs/image_factory.dart';
import 'package:app/configs/route_path.dart';
import 'package:app/configs/text_app.dart';
import 'package:app/modules/candidate/data/models/hive_models/experience_model.dart';
import 'package:app/modules/candidate/data/models/hive_models/school_model.dart';
import 'package:app/modules/candidate/data/models/hive_models/skill_model.dart';
import 'package:app/modules/candidate/data/models/profile_model.dart';
import 'package:app/modules/candidate/data/models/user_model.dart';
import 'package:app/modules/candidate/domain/providers/provider_app.dart';
import 'package:app/modules/candidate/domain/providers/provider_auth.dart';
import 'package:app/modules/candidate/domain/providers/provider_profile.dart';
import 'package:app/modules/candidate/domain/providers/provider_user.dart';
import 'package:app/modules/candidate/presentations/themes/color.dart';
import 'package:app/modules/candidate/presentations/views/cv_profile/pdf/item_profile_widget.dart';
import 'package:app/modules/candidate/presentations/views/profile/widgets/item_profile.dart';
import 'package:app/modules/candidate/presentations/views/widgets/button_app.dart';
import 'package:app/modules/candidate/presentations/views/widgets/button_outline.dart';
import 'package:app/shared/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AccountScreen extends StatefulWidget {
  AccountScreen({super.key, required this.user, required this.avatar});

  User user;
  String? avatar;
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File? imageFile;
  final picker = ImagePicker();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  final _schoolBox = Hive.box<SchoolModel>('School');
  final _experienceBox = Hive.box<ExperienceModel>('Experience');
  final _skillBox = Hive.box<SkillModel>('skill');
  String nameUser = '';
  String phoneNumber = '';
  bool male = true;

  List<Profile> listProvider = [];
  final _box = Hive.box('info');

  void initData() async {
    listProvider = await Modular.get<ProviderProfile>().getListProfile();
    nameUser = '${widget.user.firstName} ${widget.user.lastName}';
    phoneNumber = widget.user.phone.toString();
    male = widget.user.gender.toString().toLowerCase() == 'male';
  }

  @override
  void initState() {
    super.initState();
    initData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    context.watch<ProviderUser>();
    final provider = context.watch<ProviderProfile>();
    final providerApp = context.watch<ProviderApp>();

    context.watch<ProviderAuth>();

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: ListView(
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
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              primaryColor,
                              primaryColor.withOpacity(0.1),
                            ],
                          ),
                        ),
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
                              child: Stack(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 2, color: Colors.red),
                                        image: imageFile != null
                                            ? DecorationImage(
                                                image: FileImage(imageFile!))
                                            : widget.avatar != null
                                                ? DecorationImage(
                                                    image: NetworkImage(
                                                        widget.avatar!))
                                                : const DecorationImage(
                                                    image: AssetImage(
                                                        ImageFactory.editCV))),
                                  ),
                                  Positioned(
                                      top: 50,
                                      left: 50,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 1, color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: SvgPicture.asset(
                                            ImageFactory.camera,
                                            height: 20,
                                            width: 20),
                                      ))
                                ],
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
                                  nameUser,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
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
                                      widget.user.userId.substring(0, 7),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      editName(
                          context,
                          '${widget.user.firstName} ${widget.user.lastName}',
                          widget.user.userId);
                    },
                    child: ItemProfile(
                        icon: ImageFactory.person,
                        title: 'Họ và Tên',
                        content: nameUser),
                  ),
                  GestureDetector(
                    onTap: () {
                      editPhoneNumber(context, phoneNumber, widget.user.userId);
                    },
                    child: ItemProfile(
                        icon: ImageFactory.call,
                        title: 'Số điện thoại',
                        content: phoneNumber),
                  ),
                  GestureDetector(
                    onTap: () {
                      chooseGender(context, widget.user.userId);
                    },
                    child: ItemProfile(
                        icon: ImageFactory.sex,
                        title: 'Giới tính',
                        content: male ? 'nam' : 'nữ'),
                  ),
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.remove('accessToken');
                      await prefs.remove('refreshToken');
                      await _box.delete('name');
                      await _box.delete('position');
                      await _box.delete('email');
                      await _box.delete('phoneNumber');
                      await _box.delete('address');
                      await _box.delete('link');
                      await _box.delete('git');
                      await _box.delete('info');
                      await _box.delete('province');
                      for (int i = 0;
                          i < providerApp.listExperience.length;
                          i++) {
                        await _experienceBox.deleteAt(i);
                      }
                      for (int j = 0; j < providerApp.listSchool.length; j++) {
                        await _schoolBox.deleteAt(j);
                      }
                      for (int z = 0; z < providerApp.listSkill.length; z++) {
                        await _skillBox.deleteAt(z);
                      }
                      Modular.to.navigate(RoutePath.login);
                    },
                    child: const ItemProfile(
                        icon: ImageFactory.logout,
                        title: 'Đăng xuất',
                        content: 'Phiên bản ứng dụng: 0.0.1'),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                'CV của bạn',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
              ),
            ),
            !provider.isLoading
                ? const Center(
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator()))
                : Container(
                    padding: const EdgeInsets.only(left: 15),
                    height: 165.0 * listProvider.length,
                    width: size.width,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listProvider.length,
                      itemBuilder: (context, index) {
                        return ItemProfileWidget(
                          name: listProvider[index].name,
                          id: listProvider[index].id,
                          pathCV: listProvider[index].pathCv,
                          reLoadList: () async {
                            listProvider = await provider.getListProfile();
                          },
                          updateAt: listProvider[index].updatedAt,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 15,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

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
        Modular.get<ProviderUser>()
            .updateAvatar(id: widget.user.userId, avatar: imageFile);
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

  void editName(BuildContext context, String name, String id) {
    TextEditingController nameController = TextEditingController(text: name);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Họ tên của bạn',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(TextApp.inputName),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nhập họ tên của bạn'),
                ),
              ),
              Expanded(child: Container()),
              ButtonApp(
                title: 'Lưu thay đổi',
                onPress: () async {
                  try {
                    await Modular.get<ProviderUser>().updateUserAttribute(
                        key: 'first_name',
                        value: Format.getFirstNameByName(nameController.text),
                        id: id);
                    await Modular.get<ProviderUser>().updateUserAttribute(
                        key: 'last_name',
                        value: Format.getLastNameByName(nameController.text),
                        id: id);
                    nameUser = nameController.text;
                    setState(() {});
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.warning),
                          Expanded(
                              child: Text(jsonDecode(e.toString())['message']))
                        ],
                      ),
                    ));
                  }
                  Modular.to.pop();
                },
                borderRadius: 5,
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonOutline(
                title: 'Hủy',
                onPress: () {
                  Modular.to.pop();
                },
                borderRadius: 5,
              )
            ],
          ),
        );
      },
    );
  }

  void editPhoneNumber(BuildContext context, String phone, String id) {
    TextEditingController phoneController = TextEditingController(text: phone);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Số điện thoại của bạn',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(TextApp.inputName),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nhập số điện thoại của bạn'),
                ),
              ),
              Expanded(child: Container()),
              ButtonApp(
                title: 'Lưu thay đổi',
                onPress: () async {
                  try {
                    await Modular.get<ProviderUser>().updateUserAttribute(
                        key: 'phone',
                        value: Format.getFirstNameByName(phoneController.text),
                        id: id);
                    phoneNumber = phoneController.text;
                    setState(() {});
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.warning),
                          Expanded(
                              child: Text(jsonDecode(e.toString())['message']))
                        ],
                      ),
                    ));
                  }
                  Modular.to.pop();
                },
                borderRadius: 5,
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonOutline(
                title: 'Hủy',
                onPress: () {
                  Modular.to.pop();
                },
                borderRadius: 5,
              )
            ],
          ),
        );
      },
    );
  }

  void chooseGender(BuildContext context, String id) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Giới tính của bạn',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(TextApp.inputName),
              GestureDetector(
                onTap: () async {
                  if (!male) {
                    await Modular.get<ProviderUser>().updateUserAttribute(
                        key: 'gender', value: 'male', id: id);
                    setState(() {
                      male = !male;
                      Modular.to.pop();
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Nam'),
                      if (male)
                        SvgPicture.asset(
                          ImageFactory.checkmark,
                          width: 20,
                          height: 20,
                        )
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              GestureDetector(
                onTap: () async {
                  if (male) {
                    await Modular.get<ProviderUser>().updateUserAttribute(
                        key: 'gender', value: 'female', id: id);
                    setState(() {
                      male = !male;
                    });
                    Modular.to.pop();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Nữ'),
                      if (!male)
                        SvgPicture.asset(ImageFactory.checkmark,
                            width: 20, height: 20)
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
              ButtonOutline(
                title: 'Hủy',
                onPress: () {
                  Modular.to.pop();
                },
                borderRadius: 5,
              )
            ],
          ),
        );
      },
    );
  }
}
