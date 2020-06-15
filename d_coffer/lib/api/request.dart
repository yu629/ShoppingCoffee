import 'package:d_coffer/api/base.dart';
import 'package:d_coffer/api/req_shop.dart';
import 'package:d_coffer/api/req_user.dart';
import 'package:d_coffer/api/req_verification_code.dart';
import 'package:dio/dio.dart';



class Request {
  Dio _dio;

  Request() {
    _dio = initDio();
  }

  ReqUser get user => ReqUser(_dio);

  ReqVerificationCode get verificationCode => ReqVerificationCode(_dio);

  ReqShop get shop => ReqShop(_dio);

  // ReqDiscounts get discounts => ReqDiscounts(_dio);
}