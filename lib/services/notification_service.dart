import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:news_admin/configs/constants.dart';
import 'package:news_admin/models/article.dart';
import '../configs/fcm_config.dart';
import '../models/notification_model.dart';
import 'package:http/http.dart' as http;
import '../services/app_service.dart';

class NotificationService {
  // new
  Future sendCustomNotificationByTopic(NotificationModel notification) async {
    final String accessToken = await _getAccessToken();
    final String body = AppService.getNormalText(notification.description);
    final String projectId = serviceCreds['project_id'];

    var notificationBody = {
      "message": {
        "notification": {
          'title': notification.title,
          'body': body,
        },
        'data': <String, String>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done',
          'notification_type': 'custom',
          'description': notification.description,
        },
        "topic": notification.topic,
      }
    };

    try {
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/v1/projects/$projectId/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(notificationBody),
      );
      if (response.statusCode == 200) {
        debugPrint('Notification sent successfully');
      } else {
        debugPrint('Failed to send notification: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error sending notification: $e');
    }
  }

  // Post Notifications
  Future sendPostNotificationToAll(Article article) async {
    final String body = article.summary ?? article.description;
    final String accessToken = await _getAccessToken();
    final String projectId = serviceCreds['project_id'];

    var notificationBody = {
      "message": {
        "notification": {
          'title': article.title,
          'body': body,
        },
        'data': <String, String>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done',
          'article_id': article.id,
          'image_url': article.thumbnailUrl ?? '',
          'notification_type': 'post',
          'content_type': article.contentType,
          'description': article.description,
        },
        "topic": notificationTopicForAll,
      }
    };

    try {
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/v1/projects/$projectId/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(notificationBody),
      );
      if (response.statusCode == 200) {
        debugPrint('Notification sent successfully');
      } else {
        debugPrint('Failed to send notification: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error sending notification: $e');
    }

    // await http.post(
    //   Uri.parse('https://fcm.googleapis.com/fcm/send'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json',
    //     'Authorization': 'key=${AppConfig.firebaseServerKey}',
    //   },
    //   body: jsonEncode(
    //     <String, dynamic>{
    //       'notification': <String, dynamic>{
    //         'body': body,
    //         'title': article.title,
    //         'sound': 'default',
    //       },
    //       'priority': 'normal',
    //       'data': <String, dynamic>{
    //         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    //         'id': '1',
    //         'status': 'done',
    //         'article_id': article.id,
    //         'image_url': article.thumbnailUrl,
    //         'notification_type': 'post',
    //         'content_type': article.contentType,
    //         'description': article.description,
    //       },
    //       'to': "/topics/$notificationTopicForAll",
    //     },
    //   ),
    // );
  }

  // Custom Notifications
  // Future sendCustomNotificationByTopic(NotificationModel notification) async {
  //   final String body = AppService.getNormalText(notification.description);
  //   await http.post(
  //     Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       'Authorization': 'key=${AppConfig.firebaseServerKey}',
  //     },
  //     body: jsonEncode(
  //       <String, dynamic>{
  //         'notification': <String, dynamic>{
  //           'body': body,
  //           'title': notification.title,
  //           'sound': 'default',
  //         },
  //         'priority': 'normal',
  //         'data': <String, dynamic>{
  //           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //           'id': '1',
  //           'status': 'done',
  //           'notification_type': 'custom',
  //           'description': notification.description
  //         },
  //         'to': "/topics/${notification.topic}",
  //       },
  //     ),
  //   );
  // }

  Future<String> _getAccessToken() async {
    final accountCredentials = ServiceAccountCredentials.fromJson(serviceCreds);

    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final authClient = await clientViaServiceAccount(accountCredentials, scopes);

    final credentials = authClient.credentials;
    return credentials.accessToken.data;
  }
}
