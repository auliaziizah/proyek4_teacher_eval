import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoleChecker extends StatelessWidget {
  final Widget child;
  final String requiredRole;

  RoleChecker({required this.child, required this.requiredRole});

  Future<bool> _hasAccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String role = prefs.getString('role') ?? 'guru';
    return role == requiredRole;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasAccess(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data == true) {
          return child;
        } else {
          return Scaffold(
            body: Center(
              child: Text('You do not have access to this page.'),
            ),
          );
        }
      },
    );
  }
}
