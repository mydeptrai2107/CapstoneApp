import 'package:app/configs/route_path.dart';
import 'package:app/presentations/views/cv_profile/create_cv_screen.dart';
import 'package:app/presentations/views/cv_profile/fill_first_information_cv.dart';
import 'package:app/presentations/views/cv_profile/fill_second_information_cv.dart';
import 'package:app/presentations/views/cv_profile/welcome_create_cv.dart';
import 'package:app/presentations/views/login_register/login.dart';
import 'package:app/presentations/views/login_register/register.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => const [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(RoutePath.home,
            child: (context, args) => const WelcomeCreateCV()),
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
      ];
}
