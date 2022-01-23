import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/core/remote_data_function/http_methods.dart';
import 'package:sidq/features/news_details/data/models/news_details.dart';


abstract class NewsDetailsRemoteData {

  Future<dynamic> getNewsDetailsRemoteData ( String newsId);
}



class NewsDetaulsRemoteDataImp implements NewsDetailsRemoteData{

  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf;

  NewsDetaulsRemoteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future<dynamic> getNewsDetailsRemoteData(String newsId) async {

    var response= await networkFunctions.getMethod(url: '/Client/News/GetById?Id=$newsId', baseurl: networkInf.baseUrl);

    return newsDetailsFromJson(response);
   
  }
}