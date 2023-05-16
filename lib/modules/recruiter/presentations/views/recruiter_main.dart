import 'package:app/modules/candidate/presentations/themes/color.dart';
import 'package:app/modules/recruiter/presentations/views/campaign/campaign_screen.dart';
import 'package:app/modules/recruiter/presentations/views/management/management_screen.dart';
import 'package:app/modules/recruiter/presentations/views/recruitment/recruitment_screen.dart';
import 'package:app/shared/models/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'home/r_home_screen.dart';

class RecruiteMain extends StatefulWidget {
  const RecruiteMain({super.key});

  @override
  State<RecruiteMain> createState() => _RecruiteMainState();
}

class _RecruiteMainState extends State<RecruiteMain>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabView.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  final tabView = [
    const HomeScreen(),
    const CampaignScreen(),
    const ManagementScreen(),
    const RecruitmentScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: tabView),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: (value) => _tabController.index = value,
          items: bottomNavBarRecruiter
              .map((e) => BottomNavigationBarItem(
                  label: e.title,
                  icon: SvgPicture.asset(
                    e.assetsIcon,
                    width: 25,
                    height: 25,
                  )))
              .toList()),
    );
  }
}
