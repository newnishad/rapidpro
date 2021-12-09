library rapidpro;

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RapidPro {
  final String server;
  final String channel;
  final String urn;
  final String name;
  final String fcmToken;
  final String workspaceToken;
  String contact = "";
  RapidPro({
    @required this.server,
    @required this.channel,
    @required this.urn,
    @required this.fcmToken,
    this.name = "",
    @required this.workspaceToken,
  });

  register({
    @required onSuccess(String uuid),
    @required onError(Exception error),
  }) async {
    await http.post("https://$server/c/fcm/$channel/register", body: {
      "urn": urn,
      "fcm_token": fcmToken,
      "name": name
    }).then((value) async {
      print(value.body);
      var data = await jsonDecode(value.body);
      contact = await data['contact_uuid'];
      return onSuccess(data['contact_uuid']);
    }).catchError((e) => onError(e));
  }

  startFlow({
    @required String flow,
    @required onSuccess(response),
    @required onError(error),
  }) async {
    if (contact == "") {
      return onError("Caught error: You didn't register yet");
    }
    await http
        .post(
          "https://$server/api/v2/flow_starts.json",
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Token $workspaceToken",
          },
          body: jsonEncode(
            {
              "flow": flow,
              "contacts": [contact]
            },
          ),
        )
        .then(
          (value) => onSuccess(value.body),
        )
        .catchError(
          (e) => onError(e),
        );
  }

  sendMessage({
    @required String message,
    @required onSuccess(value),
    @required onError(Exception value),
  }) async {
    if (contact == "") {
      return Future.error("You didn't register yet");
    }

    await http.post("https://$server/c/fcm/$channel/receive", headers: {
      "Authorization": "Token $workspaceToken",
    }, body: {
      "from": urn,
      "fcm_token": fcmToken,
      "msg": message
    }).then((value) {
      onSuccess(value.body);
    }).catchError((e) {
      onError(e);
    });
  }
}
