import 'package:app/configs/route_path.dart';
import 'package:app/modules/candidate/domain/providers/provider_app.dart';
import 'package:app/modules/candidate/domain/providers/provider_auth.dart';
import 'package:app/modules/candidate/domain/providers/provider_company.dart';
import 'package:app/modules/candidate/domain/providers/provider_profile.dart';
import 'package:app/modules/candidate/domain/providers/provider_recruitment.dart';
import 'package:app/modules/candidate/domain/providers/provider_user.dart';
import 'package:app/modules/candidate/presentations/views/company/apply_screen.dart';
import 'package:app/modules/candidate/presentations/views/company/detail_recruitment.dart';
import 'package:app/modules/candidate/presentations/views/company/home_company.dart';

import 'package:app/modules/candidate/presentations/views/cv_profile/add_education_screen.dart';
import 'package:app/modules/candidate/presentations/views/cv_profile/add_skill_screen.dart';
import 'package:app/modules/candidate/presentations/views/cv_profile/add_working_experience_screen.dart';
import 'package:app/modules/candidate/presentations/views/cv_profile/create_cv_screen.dart';
import 'package:app/modules/candidate/presentations/views/cv_profile/fill_first_information_cv.dart';
import 'package:app/modules/candidate/presentations/views/cv_profile/fill_second_information_cv.dart';
import 'package:app/modules/candidate/presentations/views/cv_profile/list_profile_screen.dart';
import 'package:app/modules/candidate/presentations/views/cv_profile/pdf/preview_cv_screen.dart';
import 'package:app/modules/candidate/presentations/views/cv_profile/pdf_viewer_screen.dart';
import 'package:app/modules/candidate/presentations/views/cv_profile/welcome_create_cv.dart';
import 'package:app/modules/candidate/presentations/views/home/list_company_screen.dart';
import 'package:app/modules/candidate/presentations/views/home/search_company_screen.dart';
import 'package:app/modules/candidate/presentations/views/home/search_recruitment_screen.dart';
import 'package:app/modules/candidate/presentations/views/jobcv_home_screen.dart';
import 'package:app/modules/candidate/presentations/views/login_register/login.dart';
import 'package:app/modules/candidate/presentations/views/login_register/register.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => ProviderApp()),
        Bind.singleton((i) => ProviderAuth()),
        Bind.singleton((i) => ProviderUser()),
        Bind.singleton((i) => ProviderProfile()),
        Bind.singleton((i) => ProviderCompany()),
        Bind.singleton((i) => ProviderRecruitment())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(RoutePath.home,
            child: (context, args) => const JobCVHomeScreen()),
        ChildRoute(RoutePath.login,
            child: (context, args) => const LoginScreen()),
        ChildRoute(RoutePath.register,
            child: (context, args) => const RegisterScreen()),
        ChildRoute(RoutePath.welcomeCreateCV,
            child: (context, args) => const WelcomeCreateCV()),
        ChildRoute(RoutePath.fillFirstInfoCV,
            child: (context, args) => const FillFirstInformationCV()),
        ChildRoute(RoutePath.createCV,
            child: (context, args) => CreateCVScreen(
                  id: args.data[0],
                  name: args.data[1],
                )),
        ChildRoute(RoutePath.fillSecondInfoCV,
            child: (context, args) => FillSecondInformationScreen(
                  id: args.data[0],
                  name: args.data[1],
                )),
        ChildRoute(
          RoutePath.addWorkingExperience,
          child: (context, args) => const AddWorkingExperienceScreen(),
        ),
        ChildRoute(
          RoutePath.addEducation,
          child: (context, args) => const AddEducationScreen(),
        ),
        ChildRoute(
          RoutePath.addSkill,
          child: (context, args) => const AddSkillScreen(),
        ),
        ChildRoute(
          RoutePath.previewCV,
          child: (context, args) => PreviewCVScreen(
            name: args.data[0],
            position: args.data[1],
            birthday: args.data[2],
            email: args.data[3],
            phoneNumber: args.data[4],
            link: args.data[5],
            git: args.data[6],
            address: args.data[7],
            careerGoals: args.data[8],
            experienceModel: args.data[9],
            schoolModell: args.data[10],
            idCV: args.data[11],
            nameCV: args.data[12],
          ),
        ),
        ChildRoute(
          RoutePath.listProfile,
          child: (context, args) => const ListProfileScreen(),
        ),
        ChildRoute(
          RoutePath.pdfViewer,
          child: (context, args) => PDFViewerScreen(
            name: args.data[0],
            pathCV: args.data[1],
          ),
        ),
        ChildRoute(
          RoutePath.homeCompany,
          child: (context, args) => CompanyHome(company: args.data[0]),
        ),
        ChildRoute(
          RoutePath.detailRecruitment,
          child: (context, args) => DetailRecruitment(
            recruitment: args.data[0],
            company: args.data[1],
          ),
        ),
        ChildRoute(
          RoutePath.applyScreen,
          child: (context, args) => const ApplyScreen(),
        ),
        ChildRoute(
          RoutePath.listCompanyScreen,
          child: (context, args) => const ListCompanyScreen(),
        ),
        ChildRoute(
          RoutePath.searchCompanyScreen,
          child: (context, args) => const SearchScreen(),
        ),
        ChildRoute(
          RoutePath.searchRecruitmentScreen,
          child: (context, args) => const SearchRecruitmentScreen(),
        )
      ];
}
