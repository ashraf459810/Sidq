import 'dart:developer';

import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/core/remote_data_function/http_methods.dart';
import 'package:sidq/features/home/data/models/category_model.dart';
import 'package:sidq/features/home/data/models/search_params_model.dart';

abstract class GetCategoryRemoteData {
  Future<dynamic> getCategoriesRemoteData(int page, int size);
}

class GetCategortyRemteDataImp implements GetCategoryRemoteData {
  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf;

  GetCategortyRemteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future<CategoryModel> getCategoriesRemoteData(int page, int size) async {
    log('here from remote data');
    var response =  await networkFunctions.postMethod(
      body: 
         searchParamsModelToJson( SearchParamsModel(pageNumber: 0,pageLength: 1000,searchQuery: "",orderDescending: true))
      ,
        url: '/Client/Category/FilterDatatable', baseurl: networkInf.baseUrl);

        return categoryModelFromJson(response);
  }
}
