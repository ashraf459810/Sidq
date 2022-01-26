import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/core/remote_data_function/http_methods.dart';
import 'package:sidq/features/news_details/data/models/vote_request_model.dart';
import 'package:sidq/features/news_details/data/models/vote_response_model.dart';


abstract class AddVoteRemoteData {
  Future<dynamic> addVote (String newsId, bool vote);
}



class AddVoteRemoteDataImp implements AddVoteRemoteData {
  final NetworkFunctions networkFunctions;
  final NetworkInf networkInf ;

  AddVoteRemoteDataImp(this.networkFunctions, this.networkInf);

  @override
  Future<dynamic> addVote(String newsId, bool vote) async {
      var response = await networkFunctions.postMethod(body: voteRequestModelToJson( VoteRequestModel(newsId: newsId,isTrue: vote)),
      url: '/Client/Vote/Create', baseurl: networkInf.baseUrl);

      return voteResponseModelFromJson(response);
  }
}

