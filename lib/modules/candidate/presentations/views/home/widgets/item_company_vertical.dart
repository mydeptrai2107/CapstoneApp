import 'package:app/configs/image_factory.dart';
import 'package:app/configs/route_path.dart';
import 'package:app/modules/candidate/data/models/company_model.dart';
import 'package:app/modules/candidate/data/repositories/company_repositories.dart';
import 'package:app/modules/candidate/domain/providers/provider_recruitment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 300,
        width: size.width / 2,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.width / 5,
                  width: size.width / 5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      image: widget.company.avatar == ''
                          ? const DecorationImage(
                              image: AssetImage(ImageFactory.editCV))
                          : DecorationImage(
                              image: NetworkImage(
                                  CompanyRepository.getAvatar(widget.company.avatar!))),
                      border: Border.all(width: 0.3, color: Colors.grey),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, offset: Offset(1, 1))
                      ]),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.company.name,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
