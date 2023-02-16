import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wateen_energy/models/testenergy.dart';
import 'package:wateen_energy/services/service_url.dart';
import '../utils/user_table.dart';

class NetworkAPI {
  final host = ServiceUrl.baseUrl;
  Map<String, String> commonHeaders = {
    'Content-Type': 'application/json',
    //'application/x-www-form-urlencoded; charset=UTF-8',
    'Accept': 'application/json'
  }; //common header properties for all http requests

  void httpGetRequest(
      String serviceUrl,
      Map<String, dynamic>? headers,
      void Function(bool serverError, Map<String, dynamic>? responseData)
          completionHandler) async {
    var httpHeaders = this.commonHeaders;
    if (headers != null) {
      httpHeaders.addAll(headers as Map<String, String>);
    }

    try {
      final response = await http.get(Uri.parse(this.host + serviceUrl),
          headers: httpHeaders);
      if (response.statusCode == 200) {
        final body = response.body;
        completionHandler(false, json.decode(body));
      } else {
        completionHandler(true, null);
      }
    } catch (e) {
      completionHandler(false, null);
      print(e.toString());
    }
  }

  void httpPostRequest(
      String serviceUrl,
      Map<String, dynamic>? headers,
      Map<String, dynamic> postData,
      void completionHandler(
          bool serverError, Map<String, dynamic>? responseData)) async {
    var httpHeaders = this.commonHeaders;
    if (headers != null) {
      httpHeaders.addAll(headers as Map<String, String>);
    }

    try {
      final response = await http.post(Uri.parse(this.host + serviceUrl),
          body: jsonEncode(postData), headers: httpHeaders);
      if (response.statusCode == 200) {
        final body = response.body;
        final resp = jsonDecode(body);
        print(resp);
        completionHandler(true, resp);
      } else {
        completionHandler(false, jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
      completionHandler(false, null);
    }
  }

  void httpSubmitPostReq(
      String serviceUrl,
      Map<String, dynamic>? headers,
      Map<String, dynamic> postData,
      void completionHandler(
          bool serverError, Map<String, dynamic>? responseData)) async {
    var httpHeaders = this.commonHeaders;
    if (headers != null) {
      httpHeaders.addAll(headers as Map<String, String>);
    }

    try {
      final response = await http.post(Uri.parse(this.host + serviceUrl),
          body: jsonEncode(postData),
          headers: httpHeaders,
          encoding: Encoding.getByName("utf-8"));
      print("paramsB " + jsonEncode(postData));

      String body = "";
      if (response.statusCode == 200) {
        body = response.body;
        print("body " + body);

        bool error = hasError(body);
        final resp = jsonDecode(body);
        print(resp);
        completionHandler(error, resp);
      } else {
        completionHandler(false, jsonDecode(response.body));
      }
    } catch (e) {
      print('Exception - $e');
      completionHandler(false, null);
    }
  }

  void httpPostData(
      String serviceUrl,
      Map<String, dynamic>? headers,
      Map<String, dynamic> postData,
      void completionHandler(
          bool serverError, Map<String, dynamic>? responseData)) async {
    var httpHeaders = this.commonHeaders;
    if (headers != null) {
      httpHeaders.addAll(headers as Map<String, String>);
    }

    try {
      final response = await http.post(Uri.parse(this.host + serviceUrl),
          body: jsonEncode(postData),
          headers: httpHeaders,
          encoding: Encoding.getByName("utf-8"));
      print("paramsB " + jsonEncode(postData));

      String body = "";
      if (response.statusCode == 200) {
        body = response.body;
        print("body " + body);

        final resp = jsonDecode(body);
        print(resp);
        completionHandler(false, resp);
      } else {
        completionHandler(true, jsonDecode(response.body));
      }
    } catch (e) {
      print('Exception - $e');
      completionHandler(false, null);
    }
  }

  void httpIssueTicket(
      String serviceUrl,
      Map<String, dynamic>? headers,
      Map<String, dynamic> postData,
      void completionHandler(
          bool serverError, Map<String, dynamic>? responseData)) async {
    var httpHeaders = this.commonHeaders;
    if (headers != null) {
      httpHeaders.addAll(headers as Map<String, String>);
    }

    try {
      final response = await http.post(Uri.parse(this.host + serviceUrl),
          body: jsonEncode(postData),
          headers: httpHeaders,
          encoding: Encoding.getByName("utf-8"));
      print("paramsB " + jsonEncode(postData));

      String body = "";
      if (response.statusCode == 200) {
        body = response.body;
        print("body " + body);

        bool error = hasError(body);
        final resp = jsonDecode(body);
        print(resp);
        completionHandler(error, resp);
      } else {
        completionHandler(false, jsonDecode(response.body));
      }
    } catch (e) {
      print('Exception - $e');
      completionHandler(false, null);
    }
  }

  void httpCheckBlackList(
      String serviceUrl,
      Map<String, dynamic>? headers,
      Map<String, dynamic> postData,
      void completionHandler(
          bool serverError, Map<String, dynamic>? responseData)) async {
    var httpHeaders = this.commonHeaders;
    if (headers != null) {
      httpHeaders.addAll(headers as Map<String, String>);
    }

    try {
      final response = await http.post(Uri.parse(this.host + serviceUrl),
          body: jsonEncode(postData),
          headers: httpHeaders,
          encoding: Encoding.getByName("utf-8"));
      print("paramsB " + jsonEncode(postData));

      String body = "";
      if (response.statusCode == 200) {
        body = response.body;
        print("body " + body);

        bool error = hasError(body);
        final resp = jsonDecode(body);
        print(resp);
        completionHandler(error, resp);
      } else {
        completionHandler(false, jsonDecode(response.body));
      }
    } catch (e) {
      print('Exception - $e');
      completionHandler(false, null);
    }
  }

  bool hasError(String body) {
    Map<String, dynamic> jsonBody = jsonDecode(body);
    bool error = jsonBody['status'];

    return error;
  }

  Future<List<dynamic>>? httpGetData(String serviceUrl,
      Map<String, String>? headers, Map<String, String>? params) async {
    var httpHeaders = this.commonHeaders;
    if (headers != null) {
      httpHeaders.addAll(headers as Map<String, String>);
    }

    final uri = Uri.parse(this.host + serviceUrl);

    try {
      final response = await http.post(uri, //Uri.parse(this.host + serviceUrl),
          body: jsonEncode(params),
          headers: httpHeaders);
      if (response.statusCode == 200) {
        final body = response.body;
        final jsonResponse = json.decode(response.body);

        return jsonResponse;
      }
      throw Exception('Failed to load');
    } catch (e) {
      print('Exception - $e');
    }

    throw Exception('Failed to load');
  }

  Future<Map<String, dynamic>>? httpGetGraphData(String serviceUrl,
      Map<String, String>? headers, Map<String, dynamic> postData) async {
    var httpHeaders = this.commonHeaders;
    if (headers != null) {
      httpHeaders.addAll(headers as Map<String, String>);
    }
    String url = this.host + serviceUrl;

    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode(postData), headers: httpHeaders);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print("===============Solar==============");

        return jsonResponse;
      }
      throw Exception('Failed to load');
    } catch (e) {
      print('Exception - $e');
    }

    throw Exception('Failed to load');
  }

  Future<Map<String, dynamic>>? httpFetchData(String serviceUrl,
      Map<String, String>? headers) async {
    var httpHeaders = this.commonHeaders;
    if (headers != null) {
      httpHeaders.addAll(headers as Map<String, String>);
    }


    try {
      final response = await http.get(Uri.parse(this.host + serviceUrl),
          headers: httpHeaders);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print("===============GET DATA==============");

        return jsonResponse;
      }
      throw Exception('Failed to load');
    } catch (e) {
      print('Exception - $e');
    }

    throw Exception('Failed to load');
  }


  Future<Map<String, dynamic>>? httpFetchWeatherData(String serviceUrl,
      Map<String, String>? headers) async {
    var httpHeaders = this.commonHeaders;
    if (headers != null) {
      httpHeaders.addAll(headers as Map<String, String>);
    }


    try {
      final response = await http.get(Uri.parse(serviceUrl),
          headers: httpHeaders);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print("===============WEATHER DATA==============");

        return jsonResponse;
      }
      throw Exception('Failed to load');
    } catch (e) {
      print('Exception - $e');
    }

    throw Exception('Failed to load');
  }

}
