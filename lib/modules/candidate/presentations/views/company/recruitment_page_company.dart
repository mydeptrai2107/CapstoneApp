import 'package:app/modules/candidate/data/models/company_model.dart';
import 'package:app/modules/candidate/data/models/recruitment_model.dart';
import 'package:app/modules/candidate/domain/providers/provider_recruitment.dart';
import 'package:app/modules/candidate/presentations/views/company/recruitment_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecruitmentPageCompany extends StatefulWidget {
  const RecruitmentPageCompany({super.key, required this.company});

  final Company company;

  @override
  State<RecruitmentPageCompany> createState() => _RecruitmentPageCompanyState();
}

class _RecruitmentPageCompanyState extends State<RecruitmentPageCompany> {
  List<Recruitment> listRecruitment = [];
  initData() async {
    listRecruitment = await Modular.get<ProviderRecruitment>()
        .getListRecruitByCompany(widget.company.id);
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = context.watch<ProviderRecruitment>();
    return provider.isLoadingGetListRecruit
        ? const CircularProgressIndicator()
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10),
            child: ListView.separated(
              itemCount: listRecruitment.length,
              itemBuilder: (context, index) {
                return RecruitmentItem(
                  recruitment: listRecruitment[index],
                  company: widget.company,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 14,
                );
              },
            ),
          );
  }
}
