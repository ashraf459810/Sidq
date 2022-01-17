import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/core/remote_data_function/http_methods.dart';
import 'package:sidq/features/navigation_bar/data/models/search_params_model.dart';

abstract class GetNewsRemoteData {
  Future<dynamic> getMixedNews(SearchParamsModel searchParamsModel);
}

class GetMixedNewsRemoteDataImp implements GetNewsRemoteData {
  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf;

  GetMixedNewsRemoteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future getMixedNews(SearchParamsModel searchParamsModel) async {
    return await networkFunctions.postMethod(
        url: '/api/Client/News/FilterDatatable', baseurl: networkInf.baseUrl);
  }
}