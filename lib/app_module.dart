import 'package:app/configs/route_path.dart';
import 'package:app/presentations/views/company/detail_recruitmen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => const [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(RoutePath.home,
            child: (context, args) => const DetailRecruitment())
      ];
}
