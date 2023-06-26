import 'package:app/configs/route_path.dart';
import 'package:app/loading_screen.dart';
import 'package:app/modules/candidate/domain/providers/provider_app.dart';
import 'package:app/modules/candidate/domain/providers/provider_auth.dart';
import 'package:app/modules/candidate/presentations/views/chat/screens/chat_screen.dart';
import 'package:app/modules/recruiter/presentations/views/recruitment/detail_recruitment_screen.dart';
import 'package:app/shared/models/recruitment_model.dart';
import 'package:app/shared/provider/provider_company.dart';
import 'package:app/modules/candidate/domain/providers/provider_profile.dart';
import 'package:app/shared/provider/provider_recruitment.dart';
import 'package:app/modules/candidate/domain/providers/provider_user.dart';
import 'package:app/modules/candidate/presentations/views/company/applied_screen.dart';
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
import 'package:app/modules/recruiter/data/provider/notification_provider.dart';
import 'package:app/modules/candidate/presentations/views/profile/recruitment_saved_screen.dart';
import 'package:app/modules/recruiter/data/provider/recruitment_provider.dart';
import 'package:app/modules/recruiter/presentations/views/account/recruiter_account_screen.dart';
import 'package:app/modules/recruiter/presentations/views/recruitment/add_recruitment.dart';
import 'package:app/modules/recruiter/presentations/views/notification/notification_screen.dart';
import 'package:app/modules/recruiter/presentations/views/recruiter_main.dart';
import 'package:app/shared/presentations/login_register/login.dart';
import 'package:app/shared/presentations/login_register/register.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/recruiter/data/provider/recruiter_provider.dart';
import 'shared/provider/provider_apply.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => ProviderApp()),
        Bind.singleton((i) => ProviderAuth()),
        Bind.singleton((i) => ProviderUser()),
        Bind.singleton((i) => ProviderProfile()),
        Bind.singleton((i) => ProviderCompany()),
        Bind.singleton((i) => ProviderRecruitment()),
        Bind.singleton((i) => ProviderApply()),

        // if role Recruiter
        Bind.singleton((i) => RecruitmentProvider()),
        Bind.singleton((i) => RecruiterProvider()),
        Bind.singleton((i) => NotificationProvider())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
            transition: TransitionType.fadeIn,
            RoutePath.loading,
            child: (context, args) => const LoadingScreen()),
        ChildRoute(
            transition: TransitionType.fadeIn,
            RoutePath.home,
            child: (context, args) => const JobCVHomeScreen()),
        ChildRoute(
            transition: TransitionType.fadeIn,
            RoutePath.login,
            child: (context, args) => const LoginScreen()),
        ChildRoute(
            transition: TransitionType.fadeIn,
            RoutePath.register,
            child: (context, args) => const RegisterScreen()),
        ChildRoute(
            transition: TransitionType.fadeIn,
            RoutePath.welcomeCreateCV,
            child: (context, args) => const WelcomeCreateCV()),
        ChildRoute(
            transition: TransitionType.fadeIn,
            RoutePath.fillFirstInfoCV,
            child: (context, args) => const FillFirstInformationCV()),
        ChildRoute(
            transition: TransitionType.fadeIn,
            RoutePath.createCV,
            child: (context, args) => CreateCVScreen(
                  id: args.data[0],
                  name: args.data[1],
                  idUser: args.data[2],
                  language: args.data[3],
                )),
        ChildRoute(
            transition: TransitionType.fadeIn,
            RoutePath.fillSecondInfoCV,
            child: (context, args) => FillSecondInformationScreen(
                  id: args.data[0],
                  name: args.data[1],
                  idUser: args.data[2],
                )),
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.addWorkingExperience,
          child: (context, args) => const AddWorkingExperienceScreen(),
        ),
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.addEducation,
          child: (context, args) => const AddEducationScreen(),
        ),
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.addSkill,
          child: (context, args) => const AddSkillScreen(),
        ),
        ChildRoute(
          transition: TransitionType.fadeIn,
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
            language: args.data[13],
          ),
        ),
        // Recruiter
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.mainRecruiter,
          child: (context, args) => const RecruiteMain(),
        ),
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.addRecruitment,
          child: (context, args) => AddRecruitmentScreen(
            recruitment: args.data != null ? args.data as Recruitment : null,
          ),
        ),
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.deatilRecruitmentScreen,
          child: (context, args) => const DetailRecruitmentScreen(),
        ),
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.notification,
          child: (context, args) => const NotificationScreen(),
        ),
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.recruiterAccount,
          child: (context, args) => const RecruiterAccountScreen(),
        ),
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.listProfile,
          child: (context, args) => const ListProfileScreen(),
        ),
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.pdfViewer,
          child: (context, args) => PDFViewerScreen(
            name: args.data[0],
            pathCV: args.data[1],
            recruiterSeen: args.data[2],
            id: args.data[3],
          ),
        ),
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.homeCompany,
          child: (context, args) => CompanyHome(company: args.data[0]),
        ),
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.detailRecruitment,
          child: (context, args) => DetailRecruitment(
            recruitment: args.data[0],
            company: args.data[1],
          ),
        ),
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.applyScreen,
          child: (context, args) => ApplyScreen(recruitment: args.data[0]),
        ),
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.listCompanyScreen,
          child: (context, args) => const ListCompanyScreen(),
        ),
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.searchCompanyScreen,
          child: (context, args) => const SearchScreen(),
        ),
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.searchRecruitmentScreen,
          child: (context, args) => const SearchRecruitmentScreen(),
        ),
        // ChildRoute(
        //   RoutePath.verifyEmail,
        //   child: (context, args) => VerifyEmailPage(password: args.data[0]),
        // ),
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.appliedScreen,
          child: (context, args) => const AppliedScreen(),
        ),
        ChildRoute(
          transition: TransitionType.fadeIn,
          RoutePath.recruitmentSavedScreen,
          child: (context, args) =>
              RecruitmentSavedScreen(loadCount: args.data[0]),
        ),
        ChildRoute(
            transition: TransitionType.fadeIn,
            RoutePath.chatScreen,
            child: (context, args) => ChatScreen(
                currentUserId: args.data[0],
                friendId: args.data[1],
                friendName: args.data[2],
                friendImage: args.data[3])),
      ];
}
