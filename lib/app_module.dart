import 'package:app/configs/route_path.dart';
import 'package:app/domain/providers/provider_app.dart';
import 'package:app/presentations/views/cv_profile/add_education_screen.dart';
import 'package:app/presentations/views/cv_profile/add_skill_screen.dart';
import 'package:app/presentations/views/cv_profile/add_working_experience_screen.dart';
import 'package:app/presentations/views/cv_profile/create_cv_screen.dart';
import 'package:app/presentations/views/cv_profile/fill_first_information_cv.dart';
import 'package:app/presentations/views/cv_profile/fill_second_information_cv.dart';
import 'package:app/presentations/views/cv_profile/pdf/preview_cv_screen.dart';
import 'package:app/presentations/views/cv_profile/welcome_create_cv.dart';
import 'package:app/presentations/views/jobcv_home_screen.dart';
import 'package:app/presentations/views/login_register/login.dart';
import 'package:app/presentations/views/login_register/register.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [Bind.singleton((i) => ProviderApp())];

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
        ChildRoute(RoutePath.pdfPage,
            child: (context, args) => const CreateCVScreen()),
        ChildRoute(RoutePath.fillSecondInfoCV,
            child: (context, args) => const FillSecondInformationScreen()),
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
          ),
        )
      ];
}
