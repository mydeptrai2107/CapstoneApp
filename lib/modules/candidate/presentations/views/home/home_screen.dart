// ignore_for_file: deprecated_member_use

import 'package:app/configs/image_factory.dart';
import 'package:app/configs/route_path.dart';
import 'package:app/modules/candidate/data/models/company_model.dart';
import 'package:app/modules/candidate/domain/providers/provider_auth.dart';
import 'package:app/modules/candidate/domain/providers/provider_company.dart';
import 'package:app/modules/candidate/domain/providers/provider_recruitment.dart';
import 'package:app/modules/candidate/presentations/themes/color.dart';
import 'package:app/modules/candidate/presentations/views/company/recruitment_item_home.dart';
import 'package:app/modules/candidate/presentations/views/home/widgets/item_company_vertical.dart';
import 'package:app/shared/models/recruitment_model.dart';
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
  List<Recruitment> listRecruitment = [];
  int numberPaging = 1;
  String avatar = '';
  String nameUser = '';
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    initData();
  }

  void initData() async {
    listCompany =
        await Modular.get<ProviderCompany>().getListCompanyPaging(numberPaging);
    listRecruitment =
        await Modular.get<ProviderRecruitment>().getListRecruitment();

    avatar = await Modular.get<ProviderAuth>().getAvatar();
    nameUser = await Modular.get<ProviderAuth>().getNameUser();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    context.watch<ProviderCompany>();
    context.watch<ProviderRecruitment>();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: GestureDetector(
                    onTap: () {
                      Modular.to.pushNamed(RoutePath.searchRecruitmentScreen);
                    },
                    child: Container(
                      height: 30,
                      width: size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  background: Container(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 15),
                    height: 200,
                    color: Colors.grey[100],
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Hello, ',
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  nameUser,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            const Text(
                              'Tìm Công Việc Tốt Của Bạn',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Container(
                          width: 41,
                          height: 41,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: avatar != ''
                                  ? DecorationImage(
                                      image: NetworkImage(avatar),
                                      fit: BoxFit.fill)
                                  : const DecorationImage(
                                      image: AssetImage(ImageFactory.editCV),
                                      fit: BoxFit.fill)),
                        )
                      ],
                    ),
                  )),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.grey[100],
                height: 20000,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      child: const Text(
                        'Việc làm nổi bật',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      height: 170,
                      child: PageView.builder(
                        padEnds: false,
                        controller: _pageController,
                        itemCount: listRecruitment.length,
                        itemBuilder: (context, index) => RecruitmentItemHome(
                            recruitment: listRecruitment[index]),
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
                            childAspectRatio: 9 / 10,
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
      ),
    );
  }
}
