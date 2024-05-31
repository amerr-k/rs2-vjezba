import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:spsp_desktop/models/search_result.dart';
import 'package:spsp_desktop/utils/util.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  static String? _baseUrl;
  String _endpoint = "";

  // static String? get baseUrl => _baseUrl;
  get baseUrl => _baseUrl;
  String? get endpoint => _endpoint;

  // HttpClient client = HttpClient();
  IOClient? http;

  BaseProvider(String endpoint) {
    _endpoint = endpoint;
    _baseUrl = const String.fromEnvironment(
      "baseUrl",
      defaultValue: "http://localhost:7011/",
    );
    http = IOClient();
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

  T fromJson(data) {
    throw Exception("Method not implemented");
  }

  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw new Exception("Unauthorized");
    } else {
      print('RESPONSE BODY');
      print(response.body);
      throw new Exception("Something bad happened. Please try again.");
    }
  }

  Map<String, String> createHeaders() {
    String username = Authorization.username ?? "";
    String password = Authorization.password ?? "";

    String basicAuth = "Basic ${base64Encode(
      utf8.encode('$username:$password'),
    )}";

    var headers = {"Content-Type": "application/json", "Authorization": basicAuth};

    return headers;
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
}
