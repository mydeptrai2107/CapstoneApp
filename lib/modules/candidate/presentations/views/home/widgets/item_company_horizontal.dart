import 'package:app/configs/image_factory.dart';
import 'package:app/configs/route_path.dart';
import 'package:app/modules/candidate/data/models/company_model.dart';
import 'package:app/modules/candidate/data/repositories/company_repositories.dart';
import 'package:app/modules/candidate/domain/providers/provider_recruitment.dart';
import 'package:app/modules/candidate/presentations/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ItemCompanyHorizontal extends StatefulWidget {
  const ItemCompanyHorizontal({super.key, required this.company});
  final Company company;

  @override
  State<ItemCompanyHorizontal> createState() => _ItemCompanyHorizontalState();
}

class _ItemCompanyHorizontalState extends State<ItemCompanyHorizontal> {
  int quantityRecruitment = 0;
  initData() async {
    quantityRecruitment = await Modular.get<ProviderRecruitment>()
        .getQuantityRecruitByCompany(widget.company.id);
  }

  @override
  void initState() {
    initData();
    super.initState();
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
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          width: size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          height: 170,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15),
                height: size.width / 6,
                width: size.width / 6,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width - 100 - size.width / 6,
                    child: Text(
                      widget.company.name,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: size.width - 100 - size.width / 6,
                    child: Text(
                      widget.company.type == ''
                          ? 'Chưa cập nhật'
                          : widget.company.type.toString(),
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$quantityRecruitment việc làm',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: size.width - 100 - size.width / 6,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: primaryColor),
                        borderRadius: BorderRadius.circular(100)),
                    child: const Center(
                      child: Text(
                        '+ Theo dõi',
                        style: TextStyle(fontSize: 13, color: primaryColor),
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
