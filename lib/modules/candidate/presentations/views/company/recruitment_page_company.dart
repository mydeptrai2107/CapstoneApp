import 'package:app/configs/image_factory.dart';
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
    final provider = context.watch<ProviderRecruitment>();
    return provider.isLoadingGetListRecruit
        ? const CircularProgressIndicator()
        : listRecruitment.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ImageFactory.box),
                            fit: BoxFit.fill)),
                  ),
                  const Text(
                    'Danh sách tin tuyển dụng trống',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )
                ],
              )
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
