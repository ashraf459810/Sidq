import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/core/remote_data_function/http_methods.dart';
import 'package:sidq/features/home/data/models/category_model.dart';


abstract class GetCategoryRemoteData {
  Future<dynamic> getCategoriesRemoteData(int page, int size);
}

class GetCategortyRemteDataImp implements GetCategoryRemoteData {
  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf;

  GetCategortyRemteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future<CategoryModel> getCategoriesRemoteData(int page, int size) async {
    return await networkFunctions.postMethod(
        url: '/Client/Category/FilterDatatable', baseurl: networkInf.baseUrl);
  }
}
