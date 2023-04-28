import 'package:app/app_module.dart';
import 'package:app/data/models/hive_models/experience_model.dart';
import 'package:app/data/models/hive_models/experience_model.g.dart';
import 'package:app/data/models/hive_models/school_model.dart';
import 'package:app/data/models/hive_models/school_model.g.dart';
import 'package:app/data/models/hive_models/skill_model.dart';
import 'package:app/data/models/hive_models/skill_model.g.dart';
import 'package:app/firebase_options.dart';
import 'package:app/presentations/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExperienceModelAdapter());
    Hive.registerAdapter(SchoolModelAdapter());
    Hive.registerAdapter(SkillModelAdapter());

    await Hive.openBox<ExperienceModel>('Experience');
    await Hive.openBox('info');
    await Hive.openBox<SchoolModel>('school');
    await Hive.openBox<SkillModel>('skill');

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(ModularApp(module: AppModule(), child: const App()));
  });
}
