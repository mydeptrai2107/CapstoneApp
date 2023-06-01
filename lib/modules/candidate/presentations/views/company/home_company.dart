// ignore_for_file: deprecated_member_use

import 'package:app/configs/image_factory.dart';
import 'package:app/modules/candidate/data/models/company_model.dart';
import 'package:app/modules/candidate/data/repositories/company_repositories.dart';
import 'package:app/modules/candidate/presentations/themes/color.dart';
import 'package:app/modules/candidate/presentations/views/company/intro_company.dart';
import 'package:app/modules/candidate/presentations/views/company/recruitment_page_company.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CompanyHome extends StatefulWidget {
  const CompanyHome({super.key, required this.company});

  final Company company;

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Công ty'),
          centerTitle: true,
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 1 / 4,
                width: size.width,
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: widget.company.avatar == '' || widget.company.avatar == null
                            ? Image.asset(
                                ImageFactory.editCV,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                CompanyRepository.getAvatar(
                                    widget.company.avatar!),
                                fit: BoxFit.cover,
                              )),
                    Positioned.fill(
                        child: Container(
                      color: Colors.black.withOpacity(0.5),
                    )),
                    Positioned(
                        top: size.height * 1 / 4 - 70,
                        left: 15.w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  image: widget.company.avatar == ''  || widget.company.avatar == null
                                      ? const DecorationImage(
                                          image:
                                              AssetImage(ImageFactory.editCV))
                                      : DecorationImage(
                                          image: NetworkImage(
                                              CompanyRepository.getAvatar(
                                                  widget.company.avatar!)))),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width - 100,
                                    child: Text(
                                      widget.company.name.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        ImageFactory.people,
                                        width: 15,
                                        height: 15,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      const Text(
                                        '10000+ nhân viên',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              const TabBar(
                tabs: [
                  Tab(
                    text: 'GIỚI THIỆU',
                  ),
                  Tab(
                    text: 'TUYỂN DỤNG',
                  ),
                  Tab(
                    text: 'ĐÁNH GIÁ',
                  )
                ],
                indicatorColor: primaryColor,
                labelColor: primaryColor,
              ),
              Expanded(
                child: TabBarView(children: [
                  IntroCompany(
                    company: widget.company,
                  ),
                  RecruitmentPageCompany(
                    company: widget.company,
                  ),
                  const Center(
                    child: Text('11123'),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
