// ignore_for_file: deprecated_member_use

import 'package:app/configs/font_style_text.dart';
import 'package:app/configs/image_factory.dart';
import 'package:app/configs/route_path.dart';
import 'package:app/modules/candidate/data/models/company_model.dart';
import 'package:app/shared/models/recruitment_model.dart';
import 'package:app/modules/candidate/data/repositories/company_repositories.dart';
import 'package:app/modules/candidate/domain/providers/provider_recruitment.dart';
import 'package:app/modules/candidate/presentations/themes/color.dart';
import 'package:app/modules/candidate/presentations/views/company/widgets/info_recuitment_item.dart';
import 'package:app/modules/candidate/presentations/views/company/widgets/tag_info_widget.dart';
import 'package:app/modules/candidate/presentations/views/home/widgets/item_recruitment.dart';
import 'package:app/modules/candidate/presentations/views/widgets/button_app.dart';
import 'package:app/modules/candidate/presentations/views/widgets/button_outline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailRecruitment extends StatefulWidget {
  const DetailRecruitment(
      {super.key, required this.recruitment, required this.company});

  final Recruitment recruitment;
  final Company company;

  @override
  State<DetailRecruitment> createState() => _DetailRecruitmentState();
}

class _DetailRecruitmentState extends State<DetailRecruitment> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  // true: thong tin | false : Cong ty
  bool isChoose = true;

  List<Recruitment> recruitements = [];

  initData() async {
    recruitements = await Modular.get<ProviderRecruitment>()
        .getListRecruitByCompany(widget.company.id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    context.watch<ProviderRecruitment>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chi tiết việc làm',
          style: textStyleTitleAppBar,
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(right: 10.h, left: 10, bottom: 5),
              decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(width: 1, color: Colors.grey))),
              height: 145.h,
              width: size.width,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 80.h,
                        width: 80.h,
                        decoration: BoxDecoration(
                            image: widget.company.avatar == '' ||
                                    widget.company.avatar == null
                                ? const DecorationImage(
                                    image: AssetImage(ImageFactory.editCV))
                                : DecorationImage(
                                    image: NetworkImage(
                                        CompanyRepository.getAvatar(
                                            widget.company.avatar!)))),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.h),
                        height: 80.h,
                        width: size.width - 100.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: AlignmentDirectional.bottomStart,
                              height: 40.h,
                              width: size.width - 100.h,
                              child: Text(
                                '${widget.recruitment.title!.toUpperCase()} - ${widget.recruitment.address!.toUpperCase()}',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.topStart,
                              height: 40.h,
                              width: size.width - 100.h,
                              child: Text(
                                widget.company.name.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 45.h,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ButtonApp(
                            onPress: () {
                              setState(() {
                                isChoose = !isChoose;
                              });
                            },
                            title: 'Thông tin',
                            paddingvertical: 14,
                            backGroundColor:
                                isChoose ? primaryColor : Colors.white,
                            borderRadius: 100,
                            fontSize: 13,
                            textColor: isChoose
                                ? Colors.white
                                : Colors.black.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          flex: 1,
                          child: ButtonApp(
                            onPress: () {
                              setState(() {
                                isChoose = !isChoose;
                              });
                            },
                            title: 'Công ty',
                            paddingvertical: 14,
                            backGroundColor:
                                isChoose ? Colors.white : primaryColor,
                            borderRadius: 100,
                            fontSize: 13,
                            textColor: isChoose
                                ? Colors.black.withOpacity(0.5)
                                : Colors.white,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            isChoose
                ? buildInfoRecruitment(size)
                : buildInfoCompany(size, recruitements)
          ],
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
                  title: 'Nhắn tin',
                  icon: ImageFactory.chat,
                  borderRadius: 100,
                  widthBorder: 1.5,
                  paddingvertical: 14,
                )),
            SizedBox(
              width: 10.h,
            ),
            Expanded(
                child: ButtonApp(
              onPress: () {
                Modular.to.pushNamed(RoutePath.applyScreen, arguments: [widget.recruitment]);
              },
              title: 'Ứng tuyển ngay',
              borderRadius: 100,
            ))
          ],
        ),
      ),
    );
  }

  Widget buildInfoCompany(Size size, List<Recruitment> recruitments) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      width: size.width,
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.only(
                left: 15.w, right: 15.w, top: 20.h, bottom: 20.h),
            margin: const EdgeInsets.only(bottom: 25, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.company.name.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 185, 247, 193)),
                      height: 35.h,
                      width: 35.h,
                      child: SvgPicture.asset(
                        ImageFactory.locationColor,
                        color: primaryColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Địa chỉ công ty',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: size.width - 110,
                          child: Text(
                            widget.company.address ?? 'Chưa cập nhật',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                            width: size.width - 110,
                            child: const Divider(
                              thickness: 1,
                            )),
                      ],
                    )
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
                //website company
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 185, 247, 193)),
                      height: 35.h,
                      width: 35.h,
                      child: SvgPicture.asset(
                        ImageFactory.earth,
                        color: primaryColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Website công ty:',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: size.width - 110,
                          child: Text(
                            widget.company.contact,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'GIỚI THIỆU CÔNG TY',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.company.info.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Divider(
            thickness: 1,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Text(
              'Việc làm cùng công ty',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
          ),
          SizedBox(
            width: size.width,
            height: 240.0 * recruitements.length,
            child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ItemRecuitment(
                    recruitment: recruitements[index],
                    marginHorizontal: 0,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                itemCount: recruitements.length),
          )
        ],
      ),
    ));
  }

  Widget buildInfoRecruitment(Size size) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: size.width,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.only(
                  left: 15.w, right: 15.w, top: 10.h, bottom: 20.h),
              margin: const EdgeInsets.only(bottom: 25, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thông tin chung',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black.withOpacity(0.7)),
                  ),
                  InfoRecuitmentItem(
                    icon: ImageFactory.piggy,
                    title: 'Mức lương',
                    content: widget.recruitment.salary!,
                  ),
                  InfoRecuitmentItem(
                    icon: ImageFactory.work,
                    title: 'Hình thức làm việc',
                    content: widget.recruitment.workingForm!,
                  ),
                  InfoRecuitmentItem(
                    icon: ImageFactory.threePerson,
                    title: 'Số lượng cần tuyển',
                    content: widget.recruitment.numberOfRecruits.toString(),
                  ),
                  InfoRecuitmentItem(
                    icon: ImageFactory.sex,
                    title: 'Giới tính',
                    content: widget.recruitment.gender!,
                  ),
                  InfoRecuitmentItem(
                    icon: ImageFactory.workExp,
                    title: 'Kinh nghiệm',
                    content: widget.recruitment.experience!,
                  ),
                  InfoRecuitmentItem(
                    icon: ImageFactory.paper,
                    title: 'Chức vụ',
                    content: widget.recruitment.position!,
                  ),
                  InfoRecuitmentItem(
                    icon: ImageFactory.location,
                    title: 'Địa chỉ',
                    content: widget.recruitment.address!,
                  ),
                ],
              ),
            ),
            TagInfoWidget(
                title: 'Mô tả công việc',
                content: widget.recruitment.descriptionWorking!),
            TagInfoWidget(
                title: 'Yêu cầu ứng viên',
                content: widget.recruitment.request!),
            TagInfoWidget(
                title: 'Quyền lợi', content: widget.recruitment.benefit!)
          ],
        ),
      ),
    );
  }
}
