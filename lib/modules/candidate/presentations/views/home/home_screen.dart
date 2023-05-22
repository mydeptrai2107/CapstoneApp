// ignore_for_file: deprecated_member_use

import 'package:app/configs/image_factory.dart';
import 'package:app/configs/route_path.dart';
import 'package:app/modules/candidate/data/models/company_model.dart';
import 'package:app/modules/candidate/domain/providers/provider_company.dart';
import 'package:app/modules/candidate/presentations/themes/color.dart';
import 'package:app/modules/candidate/presentations/views/home/widgets/item_company_vertical.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Company> listCompany = [];
  int numberPaging = 1;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    listCompany =
        await Modular.get<ProviderCompany>().getListCompanyPaging(numberPaging);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = context.watch<ProviderCompany>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Container(
                  height: 30,
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        ImageFactory.search,
                        color: primaryColor,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Bạn muốn tìm việc',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                          Text(
                            'Công ty - Vị trí - Địa điểm',
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                background: Row()),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20000,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  //baner
                  Container(
                    height: 60,
                    width: size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImageFactory.baner1),
                          fit: BoxFit.cover),
                    ),
                  ),

                  // company outstanding
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Công ty nổi bật',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        GestureDetector(
                          onTap: () {
                            Modular.to.pushNamed(RoutePath.listCompanyScreen);
                          },
                          child: SvgPicture.asset(
                            ImageFactory.arrowRight,
                            width: 23,
                            height: 23,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    height: (size.width *
                            (5 / 6) *
                            (listCompany.length / 2 < 1
                                ? 1
                                : listCompany.length / 2)) -
                        (listCompany.length == 8 ? 60 : 0),
                    width: size.width,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listCompany.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: size.width / 2,
                          childAspectRatio: 3 / 5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return ItemCompanyVertical(
                          company: listCompany[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
