// ignore_for_file: deprecated_member_use

import 'package:app/configs/image_factory.dart';
import 'package:app/configs/text_app.dart';
import 'package:app/modules/candidate/data/models/profile_model.dart';
import 'package:app/modules/candidate/domain/providers/provider_profile.dart';
import 'package:app/modules/candidate/presentations/themes/color.dart';
import 'package:app/modules/candidate/presentations/views/widgets/button_app.dart';
import 'package:app/modules/candidate/presentations/views/widgets/button_outline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  TextEditingController introController = TextEditingController();

  List<Profile> listProfile = [];
  String isChooseCV = 'jobcv';
  String chooseCV = '';
  late Profile chooseProfile;

  initData() async {
    listProfile = await Modular.get<ProviderProfile>().getListProfile();
    chooseProfile = listProfile[0];
    chooseCV = chooseProfile.name;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    context.watch<ProviderProfile>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ứng tuyển'),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.grey[200],
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Container(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          color: Colors.white,
          height: size.height,
          width: size.width - 30,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(15),
                height: 140,
                width: size.width - 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                        width: isChooseCV == 'jobcv' ? 0.5 : 0.2,
                        color: Colors.grey)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Chọn CV online',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: isChooseCV == 'jobcv'
                                  ? Colors.black
                                  : Colors.grey),
                        ),
                        Expanded(child: Container()),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              color: isChooseCV == 'jobcv'
                                  ? primaryColor.withOpacity(0.2)
                                  : primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            'Khuyên dùng',
                            style: TextStyle(
                                fontSize: 14,
                                color: isChooseCV == 'jobcv'
                                    ? primaryColor
                                    : primaryColor.withOpacity(0.2),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Radio(
                          activeColor: primaryColor,
                          value: 'jobcv',
                          groupValue: isChooseCV,
                          onChanged: (value) {
                            setState(() {
                              isChooseCV = value!;
                            });
                          },
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        if (isChooseCV == 'jobcv') {
                          showModalBottom(context, listProfile);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: size.width - 45,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: isChooseCV == 'jobcv' ? 1 : 0.3,
                                color: Colors.grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width - 150,
                              child: Text(
                                chooseCV,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: isChooseCV == 'jobcv'
                                        ? Colors.black
                                        : Colors.grey,
                                    fontSize: 18),
                              ),
                            ),
                            const Icon(Icons.arrow_drop_down_rounded)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              //
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                padding: const EdgeInsets.all(15),
                height: 120,
                width: size.width - 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                        width: isChooseCV == 'jobcv' ? 0.2 : 0.5,
                        color: Colors.grey)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tải lên từ điện thoại',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: isChooseCV == 'jobcv'
                                  ? Colors.grey
                                  : Colors.black),
                        ),
                        Expanded(child: Container()),
                        Radio(
                          activeColor: primaryColor,
                          value: 'android',
                          groupValue: isChooseCV,
                          onChanged: (value) {
                            setState(() {
                              isChooseCV = value!;
                            });
                          },
                        )
                      ],
                    ),
                    ButtonApp(
                      textColor:
                          isChooseCV == 'jobcv' ? Colors.grey : Colors.white,
                      backGroundColor: isChooseCV == 'jobcv'
                          ? Colors.grey.withOpacity(0.1)
                          : primaryColor,
                      title: 'Tải lên',
                      onPress: () {},
                      borderRadius: 5,
                    )
                  ],
                ),
              ),

              const Text(
                'Thư giới thiệu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.only(top: 15, bottom: 25),
                height: 150,
                width: size.width - 30,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(7)),
                child: TextField(
                  controller: introController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: TextApp.introMyself,
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
                  maxLines: 10,
                ),
              ),

              Row(
                children: [
                  SvgPicture.asset(
                    ImageFactory.warning,
                    width: 20,
                    height: 20,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    'Lưu ý',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ],
              ),

              const SizedBox(
                height: 15,
              ),

              const Text(
                TextApp.warningApply1,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                TextApp.warningApply2,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                TextApp.warningApply3,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),

              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: Colors.black.withOpacity(0.6), width: 1))),
        padding: EdgeInsets.all(10.h),
        height: 65.h,
        width: size.width,
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                flex: 1,
                child: ButtonOutline(
                  onPress: () {},
                  title: 'Quay lại',
                  borderRadius: 100,
                  widthBorder: 1.5,
                  paddingvertical: 14,
                )),
            SizedBox(
              width: 10.h,
            ),
            Expanded(
                child: ButtonApp(
              onPress: () {},
              title: 'Ứng tuyển',
              borderRadius: 100,
            ))
          ],
        ),
      ),
    );
  }

  void showModalBottom(BuildContext context, List<Profile> list) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.separated(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(listProfile[index].name),
              onTap: () {
                chooseProfile = list[index];
                chooseCV = chooseProfile.name;
                setState(() {
                  Navigator.pop(context);
                });
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 1,
            );
          },
        );
      },
    );
  }
}
