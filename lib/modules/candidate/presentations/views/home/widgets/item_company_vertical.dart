import 'package:app/configs/image_factory.dart';
import 'package:app/configs/route_path.dart';
import 'package:app/modules/candidate/data/models/company_model.dart';
import 'package:app/modules/candidate/data/repositories/company_repositories.dart';
import 'package:app/modules/candidate/domain/providers/provider_recruitment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

class ItemCompanyVertical extends StatefulWidget {
  const ItemCompanyVertical({super.key, required this.company});

  final Company company;

  @override
  State<ItemCompanyVertical> createState() => _ItemCompanyVerticalState();
}

class _ItemCompanyVerticalState extends State<ItemCompanyVertical> {
  int quantityRecruit = 0;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    quantityRecruit = await Modular.get<ProviderRecruitment>()
        .getQuantityRecruitByCompany(widget.company.id);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    context.watch<ProviderRecruitment>();
    return GestureDetector(
      onTap: () {
        Modular.to
            .pushNamed(RoutePath.homeCompany, arguments: [widget.company]);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 200,
        width: size.width / 2,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      image: widget.company.avatar == '' ||
                              widget.company.avatar == null
                          ? const DecorationImage(
                              image: AssetImage(ImageFactory.editCV))
                          : DecorationImage(
                              image: NetworkImage(CompanyRepository.getAvatar(
                                  widget.company.avatar!))),
                      border: Border.all(width: 0.3, color: Colors.grey),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, offset: Offset(1, 1))
                      ]),
                ),
                SvgPicture.asset(
                  ImageFactory.bookmarkoutline,
                  width: 20,
                  height: 20,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: size.width / 9,
              child: Text(
                widget.company.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              widget.company.type == ''
                  ? 'Chưa xác định'
                  : widget.company.type.toString(),
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$quantityRecruit việc làm',
                style: const TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
