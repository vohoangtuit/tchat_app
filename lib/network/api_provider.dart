
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tchat/network/base/response_model.dart';

part 'api_provider.g.dart';

@RestApi(baseUrl: '')
abstract class ApiProvider {
  factory ApiProvider(Dio dio, {String? baseUrl}) {
    return _ApiProvider(dio, baseUrl: baseUrl);
  }
  // todo: user
  @POST('PostSignIn') // todo old
  @FormUrlEncoded()
  Future<ResponseModel> postSignIn(@Field() String email,@Field() String password) ;


}

