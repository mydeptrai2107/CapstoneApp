// ignore_for_file: deprecated_member_use

import 'package:app/configs/image_factory.dart';
import 'package:app/modules/candidate/presentations/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              background: Row()
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) => SizedBox(
                    height: size.height - 200,
                    child: ListView(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Công ty nổi bật',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            SvgPicture.asset(
                              ImageFactory.arrowRight,
                              width: 23,
                              height: 23,
                              color: Colors.grey,
                            )
                          ],
                        )
                      ],
                    ),
                  )))
        ],
      ),
    );
  }
}
