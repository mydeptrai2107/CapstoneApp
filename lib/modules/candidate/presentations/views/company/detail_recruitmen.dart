import 'package:app/configs/font_style_text.dart';
import 'package:app/configs/image_factory.dart';
import 'package:app/modules/candidate/presentations/views/company/widgets/info_recuitment_item.dart';
import 'package:app/modules/candidate/presentations/views/company/widgets/tag_info_widget.dart';
import 'package:app/modules/candidate/presentations/views/widgets/button_app.dart';
import 'package:app/modules/candidate/presentations/views/widgets/button_outline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailRecruitment extends StatefulWidget {
  const DetailRecruitment({super.key});

  @override
  State<DetailRecruitment> createState() => _DetailRecruitmentState();
}

class _DetailRecruitmentState extends State<DetailRecruitment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              height: 140.h,
              width: size.width,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 80.h,
                        width: 80.h,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://dulichhoangnguyen.com/upload/images/dai%20dien%201(1).jpg'),
                                fit: BoxFit.cover)),
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
                              child: const Text(
                                'NHÂN VIÊN GIÁM SÁT KHO VẬN - HCM CITY',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.topStart,
                              height: 40.h,
                              width: size.width - 100.h,
                              child: Text(
                                'CÔNG TY CỔ PHẦN GIAO HÀNG TIẾT KIỆM dasd',
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
                            onPress: () {},
                            title: 'Thông tin',
                            paddingvertical: 14,
                            borderRadius: 100,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          flex: 1,
                          child: ButtonApp(
                            onPress: () {},
                            title: 'Công ty',
                            paddingvertical: 14,
                            backGroundColor:
                                const Color.fromARGB(255, 224, 221, 221),
                            borderRadius: 100,
                            fontSize: 13,
                            textColor: Colors.black.withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: size.width,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 236, 235, 235),
                      padding: EdgeInsets.only(
                          left: 15.w, right: 15.w, top: 10.h, bottom: 20.h),
                      margin: const EdgeInsets.only(bottom: 25),
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
                          const InfoRecuitmentItem(
                            icon: ImageFactory.piggy,
                            title: 'Mức lương',
                            content: 'Thỏa thuận',
                          ),
                          const InfoRecuitmentItem(
                            icon: ImageFactory.work,
                            title: 'Hình thức làm việc',
                            content: 'Toàn thời gian',
                          ),
                          const InfoRecuitmentItem(
                            icon: ImageFactory.threePerson,
                            title: 'Số lượng cần tuyển',
                            content: '14 người',
                          ),
                          const InfoRecuitmentItem(
                            icon: ImageFactory.sex,
                            title: 'Giới tính',
                            content: 'Không yêu cầu',
                          ),
                          const InfoRecuitmentItem(
                            icon: ImageFactory.workExp,
                            title: 'Kinh nghiệm',
                            content: 'Không yêu cầu kinh nghiệm',
                          ),
                          const InfoRecuitmentItem(
                            icon: ImageFactory.paper,
                            title: 'Chức vụ',
                            content: 'Nhân viên',
                          ),
                          const InfoRecuitmentItem(
                            icon: ImageFactory.location,
                            title: 'Địa chỉ',
                            content:
                                '4th Floor, Xuan Can Building, 482/15/2 Trung Nu Vuong, Hai Chau, Da Nang 4th Floor, Xuan Can Building, 482/15/2 Trung Nu Vuong, Hai Chau, Da Nang 4th Floor, Xuan Can Building, 482/15/2 Trung Nu Vuong, Hai Chau, Da Nang 4th Floor, Xuan Can Building, 482/15/2 Trung Nu Vuong, Hai Chau, Da Nang 4th Floor, Xuan Can Building, 482/15/2 Trung Nu Vuong, Hai Chau, Da Nang4th Floor, Xuan Can Building, 482/15/2 Trung Nu Vuong, Hai Chau, Da Nang',
                          ),
                        ],
                      ),
                    ),
                    const TagInfoWidget(
                        title: 'Mô tả công việc',
                        content:
                            'Chịu trách nhiệm vể toàn bộ quy trình vận hành\nKiểm soat chất lượng xử lý hàng hóa thuộc Module phụ trách\nKiểm soát nguồn hàng xuất nhập để đảm bảo chất lượng dịch vụ của công ty\nQuản lý đội ngủ nhân viên phụ kho và tài xế xe tải'),
                    const TagInfoWidget(
                        title: 'Mô tả công việc',
                        content:
                            'Chịu trách nhiệm vể toàn bộ quy trình vận hành\nKiểm soat chất lượng xử lý hàng hóa thuộc Module phụ trách\nKiểm soát nguồn hàng xuất nhập để đảm bảo chất lượng dịch vụ của công ty\nQuản lý đội ngủ nhân viên phụ kho và tài xế xe tải'),
                    const TagInfoWidget(
                        title: 'Mô tả công việc',
                        content:
                            'Chịu trách nhiệm vể toàn bộ quy trình vận hành\nKiểm soat chất lượng xử lý hàng hóa thuộc Module phụ trách\nKiểm soát nguồn hàng xuất nhập để đảm bảo chất lượng dịch vụ của công ty\nQuản lý đội ngủ nhân viên phụ kho và tài xế xe tải')
                  ],
                ),
              ),
            ),
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
                  widthBorder: 3,
                )),
            SizedBox(
              width: 10.h,
            ),
            Expanded(
                child: ButtonApp(
              onPress: () {},
              title: 'Ứng tuyển ngay',
              borderRadius: 100,
            ))
          ],
        ),
      ),
    );
  }
}
