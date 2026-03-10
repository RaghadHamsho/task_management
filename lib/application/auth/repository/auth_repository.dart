import '../../../core/data/local_data/shared_pref.dart';
import '../../../core/data/new_remote/network_service.dart';
import '../../../core/data/new_remote/response_model.dart';

import '../../../core/values/constant.dart';

abstract class AuthRepo {
  Future login({required String domainName, required String password});

  Future signUp({
    required String domainName,
    required String password,
    required String email,
  });

  Future logout({String? deviceToken});
}

class AuthRepoImpl implements AuthRepo {
  NetworkService networkService;

  AuthRepoImpl(this.networkService);

  @override
  Future login({required String domainName, required String password}) async {
    bool doLogin = false;

    ResponseModel responseModel = await networkService.sendRequest(
      'api/auth/login',
      method: HttpMethod.post,
      bodyType: BodyType.json,
      body: {"username": domainName, "password": password},
    );

    if (responseModel.status == 'OK') {
      await setValue(USERNAME, domainName);
      await setValue(PASSWORD, password);
      doLogin = true;
    }
    return doLogin;
  }

  @override
  Future signUp({
    required String domainName,
    required String password,
    required String email,
  }) async {
    bool doSignUp = false;

    ResponseModel responseModel = await networkService.sendRequest(
      'api/auth/register',
      method: HttpMethod.post,
      bodyType: BodyType.json,
      body: {"username": domainName, "password": password, "email": email},
    );

    if (responseModel.status == 'OK') {
      await setValue(USERNAME, domainName);
      await setValue(PASSWORD, password);
      doSignUp = true;
    }

    return doSignUp;
  }

  @override
  Future logout({String? deviceToken}) async {
    bool doLogout = false;

    ResponseModel responseModel = await networkService.sendRequest(
      'api/auth/logout',
      method: HttpMethod.post,
      bodyType: BodyType.json,
      body: {"deviceToken": deviceToken},
    );

    if (responseModel.status == 'OK') {
      doLogout = true;
    }

    return doLogout;
  }
}
