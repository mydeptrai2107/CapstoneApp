// ignore_for_file: deprecated_member_use

import 'package:app/configs/image_factory.dart';
import 'package:app/modules/candidate/data/models/company_model.dart';
import 'package:app/modules/candidate/data/repositories/company_repositories.dart';
import 'package:app/modules/candidate/domain/providers/provider_company.dart';
import 'package:app/modules/candidate/presentations/themes/color.dart';
import 'package:app/modules/candidate/presentations/views/company/widgets/tag_recuitment_item.dart';
import 'package:app/shared/models/recruitment_model.dart';
import 'package:app/shared/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemRecruitApplied extends StatefulWidget {
  const ItemRecruitApplied({super.key, required this.recruitment});

  final Recruitment recruitment;

  @override
  State<ItemRecruitApplied> createState() => _ItemRecruitAppliedState();
}

class _ItemRecruitAppliedState extends State<ItemRecruitApplied> {
  Company company = Company(
      name: '',
      contact: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      id: '');

  initData() async {
    company = await Modular.get<ProviderCompany>()
        .getCompanyById(widget.recruitment.companyId);
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    context.watch<ProviderCompany>();
    return Container(
      width: size.width,
      height: 190.h,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                  image: company.avatar == '' || company.avatar == null
                      ? const DecorationImage(
                          image: AssetImage(ImageFactory.editCV))
                      : DecorationImage(
                          image: NetworkImage(
                              CompanyRepository.getAvatar(company.avatar!))),
                ),
              ),
              SizedBox(
                height: 80,
                width: size.width - 140,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.recruitment.title} - ${widget.recruitment.address}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      company.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  TagRecuitmentItem(
                    icon: ImageFactory.clock,
                    title: Format.formatDateTimeToYYYYmmdd(
                        widget.recruitment.deadline!),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  TagRecuitmentItem(
                    icon: ImageFactory.location,
                    title: widget.recruitment.address!,
                  )
                ],
              ),
              TagRecuitmentItem(
                  title: widget.recruitment.salary!, icon: ImageFactory.dollar)
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageFactory.chat,
                        color: primaryColor, width: 20, height: 20),
                    const Text(
                      '  Gởi tin nhắn',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(5)),
                child: const Center(
                    child: Text(
                  'Xem lại CV',
                  style: TextStyle(fontWeight: FontWeight.w500),
                )),
              ))
            ],
          )
        ],
      ),
    );
  }
}
