import 'package:app/configs/route_path.dart';
import 'package:app/data/models/province.dart';
import 'package:app/data/repositories/repository_map_vn.dart';
import 'package:app/domain/providers/provider_app.dart';
import 'package:app/domain/use_case/get_province.dart';
import 'package:app/presentations/themes/color.dart';
import 'package:app/presentations/views/cv_profile/widgets/experience_item.dart';
import 'package:app/presentations/views/cv_profile/widgets/school_item.dart';
import 'package:app/presentations/views/cv_profile/widgets/skill_item.dart';
import 'package:app/presentations/views/widgets/button_app.dart';
import 'package:app/presentations/views/widgets/button_outline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FillSecondInformationScreen extends StatefulWidget {
  const FillSecondInformationScreen({super.key});

  @override
  State<FillSecondInformationScreen> createState() =>
      _FillSecondInformationScreenState();
}

class _FillSecondInformationScreenState
    extends State<FillSecondInformationScreen> {
  List<String> gender = ['Nam', 'Nữ'];
  String selectGender = 'Nam';
  GetProvince getProvince = GetProvince(reporitpryMap: ReporitoryMap());
  List<Province> listProvince = [];
  final TextEditingController _provinceController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _gitController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();

  final _myBox = Hive.box('info');

  @override
  void initState() {
    super.initState();
    getData();
    _nameController.text = _myBox.get('name') ?? '';
    _positionController.text = _myBox.get('position') ?? '';
    _emailController.text = _myBox.get('email') ?? '';
    _phoneNumberController.text = _myBox.get('phoneNumber') ?? '';
    _addressController.text = _myBox.get('address') ?? '';
    _linkController.text = _myBox.get('link') ?? '';
    _gitController.text = _myBox.get('git') ?? '';
    _infoController.text = _myBox.get('info') ?? '';
  }

  getData() async {
    listProvince = await getProvince.get();
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _linkController.dispose();
    _gitController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = context.watch<ProviderApp>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin chung'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thông tin cá nhân',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: 20.w, bottom: 15.h, top: 15.h),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.amber[50]),
                      ),
                      const Text(
                        'Chạm 2 lần để chỉnh sửa ảnh',
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),

                  const Divider(
                    thickness: 1,
                  ),

                  //full name
                  const Text(
                    'Họ và tên',
                    style: TextStyle(fontSize: 14),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.only(top: 5, bottom: 15),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _nameController.text.isEmpty
                                ? Colors.red
                                : Colors.grey,
                            width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: _nameController,
                      cursorColor: _nameController.text.isEmpty
                          ? Colors.red
                          : Colors.grey,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  //position to apply
                  const Text(
                    'Vị trí làm việc mong muốn',
                    style: TextStyle(fontSize: 14),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.only(top: 5, bottom: 15),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _nameController.text.isEmpty
                                ? Colors.red
                                : Colors.grey,
                            width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: _positionController,
                      cursorColor: _positionController.text.isEmpty
                          ? Colors.red
                          : Colors.grey,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  //email
                  const Text(
                    'email',
                    style: TextStyle(fontSize: 14),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.only(top: 5, bottom: 15),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _emailController.text.isEmpty
                                ? Colors.red
                                : Colors.grey,
                            width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: _emailController,
                      cursorColor: _nameController.text.isEmpty
                          ? Colors.red
                          : Colors.grey,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  //Phone
                  const Text(
                    'Số điện thoại',
                    style: TextStyle(fontSize: 14),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.only(top: 5, bottom: 15),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _phoneNumberController.text.isEmpty
                                ? Colors.red
                                : Colors.grey,
                            width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: _phoneNumberController,
                      cursorColor: _phoneNumberController.text.isEmpty
                          ? Colors.red
                          : Colors.grey,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  //gender
                  const Text(
                    'Giới tính',
                    style: TextStyle(fontSize: 14),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.only(top: 5, bottom: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          isExpanded: true,
                          value: selectGender,
                          items: gender
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: const TextStyle(fontSize: 14),
                                  )))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectGender = value!.toString();
                            });
                          }),
                    ),
                  ),

                  //select province
                  const Text(
                    'Tỉnh',
                    style: TextStyle(fontSize: 14),
                  ),
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.only(top: 5, bottom: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: _provinceController.text.isEmpty
                                    ? Colors.red
                                    : Colors.grey,
                                width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          controller: _provinceController,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400)),
                        ),
                      ),
                      Opacity(
                        opacity: 0,
                        child: SizedBox(
                          height: 60,
                          width: size.width,
                          child: DropdownButton(
                            isExpanded: true,
                            items: listProvince
                                .map<DropdownMenuItem>((e) => DropdownMenuItem(
                                      value: e.name,
                                      child: Text(
                                        e.name,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) async {
                              setState(() {
                                _provinceController.text = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  //address
                  const Text(
                    'Địa chỉ',
                    style: TextStyle(fontSize: 14),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.only(top: 5, bottom: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: _addressController,
                      cursorColor: Colors.red,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  //Liên kết
                  const Text(
                    'Liên kết',
                    style: TextStyle(fontSize: 14),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.only(top: 5, bottom: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: _linkController,
                      cursorColor: Colors.red,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  //Github
                  const Text(
                    'Github',
                    style: TextStyle(fontSize: 14),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.only(top: 5, bottom: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: _gitController,
                      cursorColor: Colors.red,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //introduction
            Container(
              height: 20.h,
              color: const Color.fromARGB(255, 211, 208, 208),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thông tin cá nhân',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.only(top: 15),
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: _infoController,
                      maxLines: 10,
                      cursorColor: Colors.red,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'nhập để thêm phần giới thiệu',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //working Experience
            Container(
              height: 20.h,
              color: const Color.fromARGB(255, 211, 208, 208),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kinh nghiệm làm việc',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  for (int i = 0; i < provider.listExperience.length; i++)
                    ExperienceItem(experience: provider.listExperience[i]),
                  GestureDetector(
                    onTap: () {
                      Modular.to.pushNamed(RoutePath.addWorkingExperience);
                    },
                    child: Container(
                        width: size.width,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        margin: const EdgeInsets.only(top: 15, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            'Add New ✚',
                            style: TextStyle(color: primaryColor),
                          ),
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.only(top: 15),
                    height: 150,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      maxLines: 10,
                      cursorColor: Colors.red,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'Kinh nghiệm khác',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //skill
            Container(
              height: 20.h,
              color: const Color.fromARGB(255, 211, 208, 208),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kỹ năng',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  for (int i = 0; i < provider.listSkill.length; i++)
                    SkillItem(skillModel: provider.listSkill[i]),
                  GestureDetector(
                    onTap: () {
                      Modular.to.pushNamed(RoutePath.addSkill);
                    },
                    child: Container(
                        width: size.width,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        margin: const EdgeInsets.only(top: 15, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            'Add New ✚',
                            style: TextStyle(color: primaryColor),
                          ),
                        )),
                  ),
                ],
              ),
            ),

            //education
            Container(
              height: 20.h,
              color: const Color.fromARGB(255, 211, 208, 208),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Giáo dục',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  for (int i = 0; i < provider.listSchool.length; i++)
                    SchoolItem(schoolModel: provider.listSchool[i]),
                  GestureDetector(
                    onTap: () {
                      Modular.to.pushNamed(RoutePath.addEducation);
                    },
                    child: Container(
                        width: size.width,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        margin: const EdgeInsets.only(top: 15, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            'Add New ✚',
                            style: TextStyle(color: primaryColor),
                          ),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: Colors.black.withOpacity(0.6), width: 1))),
        height: 130,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonApp(
                onPress: () {
                  saveCV();
                },
                title: 'Lưu CV',
                paddingvertical: 15,
              ),
              ButtonOutline(
                onPress: () {
                  print(_myBox.get('name'));
                },
                title: 'Xem trước',
                paddingvertical: 15,
              )
            ],
          ),
        ),
      ),
    );
  }

  saveCV() {
    _myBox.put('name', _nameController.text);
    _myBox.put('position', _positionController.text);
    _myBox.put('email', _emailController.text);
    _myBox.put('phoneNumber', _phoneNumberController.text);
    _myBox.put('address', _addressController.text);
    _myBox.put('link', _linkController.text);
    _myBox.put('git', _gitController.text);
    _myBox.put('info', _infoController.text);
  }
}