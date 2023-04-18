import 'package:app/data/models/province.dart';
import 'package:app/data/repositories/repository_map_vn.dart';

class GetProvince {
  final ReporitoryMap reporitpryMap;
  GetProvince({required this.reporitpryMap});

  Future<List<Province>> get() async {
    return await reporitpryMap.getProvince();
  }
}
