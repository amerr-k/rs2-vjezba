import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:spsp_mobile/models/search_result.dart';
import 'package:spsp_mobile/models/user_auth_info.dart';
import 'package:spsp_mobile/providers/user_auth_info_provider.dart';
import 'package:spsp_mobile/utils/util.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  static String? _baseUrl;
  String? _endpoint;

  HttpClient client = new HttpClient();
  IOClient? http;

  static String? get baseUrl => _baseUrl;

  String? get endpoint => _endpoint;

  BaseProvider(String endpoint) {
    _baseUrl =
        const String.fromEnvironment("baseUrl", defaultValue: "http://10.0.2.2:7011/");

    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = _baseUrl! + "/";
    }
    _endpoint = endpoint;
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  Future<UserAuthInfo?> login() async {
    var url = "${BaseProvider.baseUrl}${endpoint}/login";
    var uri = Uri.parse(url);
    // Map<String, String> headers = createAuthHeaders();

    String username = Authorization.username ?? "";
    String password = Authorization.password ?? "";

    Map<String, dynamic> loginRequest = {
      'username': username,
      'password': password,
    };
    var headers = {"Content-Type": "application/json"};

    var jsonRequest = jsonEncode(loginRequest);
    var response = await http!.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);

      var userAccountInfo = fromJson(data) as UserAuthInfo;
      Authorization.token = userAccountInfo.token;
      // userAuthInfoProvider.setUserAuthInfo(userAccountInfo as UserAuthInfo);

      return userAccountInfo;
    } else {
      throw Exception("Failed to login: ${response.statusCode}");
    }
  }

  // Map<String, String> createHeaders() {
  //   var contentType = "application/json";
  //   if (userAuthInfoProvider.userAuthInfo != null) {
  //     return {
  //       "Content-Type": contentType,
  //       "Authorization": "Bearer ${userAuthInfoProvider.userAuthInfo!.token}",
  //     };
  //   } else {
  //     var username = Authorization.username ?? "";
  //     var password = Authorization.password ?? "";
  //     var basicAuth = "Basic ${base64Encode(
  //       utf8.encode('$username:$password'),
  //     )}";

  //     return {
  //       "Content-Type": contentType,
  //       "Authorization": basicAuth,
  //     };
  //   }
  // }

  Future<T> getById(String id, [dynamic additionalData]) async {
    var url = Uri.parse("$_baseUrl$_endpoint/$id");

    Map<String, String> headers = createHeaders();

    var response = await http!.get(url, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  //kad opcionalne parametre hoces poslat stavis u viticaste zagrade
  Future<RequestResult<T>> get({dynamic filter}) async {
    var url = "$_baseUrl$_endpoint";

    if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response = await http!.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var jsonData = jsonDecode(response.body);

      var searchResult = RequestResult<T>();

      searchResult.count = jsonData["count"];

      for (var item in jsonData['result']) {
        searchResult.result.add(fromJson(item));
      }

      return searchResult;
    } else {
      throw new Exception("Unknown error");
    }
  }

  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw new Exception("Unauthorized");
    } else {
      throw new Exception("Something bad happened. Please try again.");
    }
  }

  Future<T> create(dynamic request) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request);

    var response = await http!.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var jsonData = jsonDecode(response.body);
      return fromJson(jsonData);
    } else {
      print('RESPONSE BODY');
      print(response.body);
      throw new Exception("Unknown error");
    }
  }

  Future<T> update(int id, [dynamic request]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request);

    var response = await http!.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var jsonData = jsonDecode(response.body);
      return fromJson(jsonData);
    } else {
      throw new Exception("Unknown error");
    }
  }

  Map<String, String> createHeaders() {
    if (Authorization.token != null) {
      return {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Authorization.token}",
      };
    } else {
      var username = Authorization.username ?? "";
      var password = Authorization.password ?? "";
      var basicAuth = "Basic ${base64Encode(
        utf8.encode('$username:$password'),
      )}";

      return {
        "Content-Type": "application/json",
        "Authorization": basicAuth,
      };
    }
  }

  T fromJson(data) {
    throw Exception("Method not implemented");
  }

  String getQueryString(Map params, {String prefix = '&', bool inRecursion = false}) {
    String query = '';
    params.forEach((key, value) {
      if (inRecursion) {
        if (key is int) {
          key = '[$key]';
        } else if (value is List || value is Map) {
          key = '.$key';
        } else {
          key = '.$key';
        }
      }
      if (value is String || value is int || value is double || value is bool) {
        var encoded = value;
        if (value is String) {
          encoded = Uri.encodeComponent(value);
        }
        query += '$prefix$key=$encoded';
      } else if (value is DateTime) {
        query += '$prefix$key=${(value as DateTime).toIso8601String()}';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query += getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    return query;
  }

  bool isValidResponseCode(Response response) {
    if (response.statusCode == 200) {
      if (response.body != "") {
        return true;
      } else {
        return false;
      }
    } else if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 400) {
      throw Exception("Bad request");
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else if (response.statusCode == 403) {
      throw Exception("Forbidden");
    } else if (response.statusCode == 404) {
      throw Exception("Not found");
    } else if (response.statusCode == 500) {
      throw Exception("Internal server error");
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }
}
