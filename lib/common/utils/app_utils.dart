import 'dart:convert';

import 'package:dualify_apprenticeship_aficorp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUtils {

  static Future<User?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      return User.fromJson(json.decode(userJson));
    }
    // Fallback user if not found
    return null;
  }

  static Icon buildDayIcon(String type) {
    switch (type) {
      case 'school':
        return const Icon(Icons.school_rounded, size: 28, color: Colors.blueAccent);
      case 'work':
        return const Icon(Icons.business_center_rounded, size: 28, color: Colors.purple);
      case 'off':
        return Icon(Icons.close_rounded, size: 28, color: Colors.grey);
      default:
        return const Icon(Icons.help_outline, size: 28, color: Colors.grey);
    }
  }
  
}
