import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:valhalla_core/valhalla_core.dart';

/// Firebase Cloud Messaging wrapper.
///
/// Works without Firebase config files: initialisation failures are swallowed
/// so the demo runs before `google-services.json` / `GoogleService-Info.plist`
/// are added. See README "Push notifications".
class PushService {
  PushService._();
  static bool _ready = false;

  static Future<void> init() async {
    try {
      await Firebase.initializeApp();
      _ready = true;
    } catch (e) {
      debugPrint('Firebase not configured, push disabled: $e');
    }
  }

  /// Ask permission (iOS) and store the token for the signed-in user.
  static Future<void> registerForUser(ProfileRepository repo) async {
    if (!_ready) return;
    try {
      final fcm = FirebaseMessaging.instance;
      await fcm.requestPermission();
      final token = await fcm.getToken();
      if (token != null) {
        await repo.registerDeviceToken(token, Platform.isIOS ? 'ios' : 'android');
      }
      fcm.onTokenRefresh.listen((t) => repo.registerDeviceToken(t, Platform.isIOS ? 'ios' : 'android'));
    } catch (e) {
      debugPrint('push registration failed: $e');
    }
  }
}
