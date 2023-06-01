import 'package:app/configs/uri.dart';
import 'package:app/shared/models/recruitment_model.dart';
import 'package:app/shared/utils/rest.dart';

class RecruitmentService {
  Future<Recruitment> createRecruitment(Recruitment recruitment) async {
    final res = await Rest.post('${kBaseUrl}api/recruitment/',
        body: recruitment.toJson());
    final item = Recruitment.fromJson(res);
    return item;
  }

  Future<List<Recruitment>> getRecruitments(String id) async {
    final res = await Rest.get('${kBaseUrl}api/recruitment/$id');
    final list = (res as List).map((e) => Recruitment.fromJson(e)).toList();
    return list;
  }

  Future<List<Recruitment>> getLisCv(String id) async {
    final res = await Rest.get('${kBaseUrl}api/recruitment/$id');
    final list = (res as List).map((e) => Recruitment.fromJson(e)).toList();
    return list;
  }
}
