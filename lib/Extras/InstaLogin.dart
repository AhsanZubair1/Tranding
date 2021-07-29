import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;


Future<Token> getToken(String appId, String appSecret, BuildContext context) async {
  Stream<String> onCode = await _server();

  print(00000);
  String url =
      "https://api.instagram.com/oauth/authorize?client_id=$appId&redirect_uri=https://tradewatchb.conveyor.cloud/auth/&response_type=code";
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  flutterWebviewPlugin.launch(url,
    rect: new Rect.fromLTWH(
      0.0,
      MediaQuery.of(context).size.height -300,
      MediaQuery.of(context).size.width,
      300.0,
    ),
  );
  print(1);
  // flutterWebviewPlugin.close();

  final String code = await onCode.first;

  print(1111);
  final http.Response response = await http.post(
      Uri.parse("https://api.instagram.com/oauth/access_token"),
      body: {"client_id": appId, "redirect_uri": "https://tradewatchb.conveyor.cloud/auth/", "client_secret": appSecret,
        "code": code, "grant_type": "authorization_code"});
  flutterWebviewPlugin.close();
  return new Token.fromMap(jsonDecode(response.body));
}

Future<Stream<String>> _server() async {
  final StreamController<String> onCode = new StreamController();
  HttpServer server =
  await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 8585);
  server.listen((HttpRequest request) async {
    String code = request.uri.queryParameters["code"] ?? "";
    request.response
      ..statusCode = 200
      ..headers.set("Content-Type", ContentType.HTML.mimeType)
      ..write("<html><h1>You can now close this window</h1></html>");
    await request.response.close();
    await server.close(force: true);
    onCode.add(code);
    await onCode.close();
  });
  return onCode.stream;
}

class Token {
  late String access;
  late String id;
  late String username;
  late String full_name;
  late String profile_picture;

  Token.fromMap(Map json){
    access = json['access_token'];
    id = json['user']['id'];
    username = json['user']['username'];
    full_name = json['user']['full_name'];
    profile_picture = json['user']['profile_picture'];
  }
}