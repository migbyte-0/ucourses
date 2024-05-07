import 'package:flutter/material.dart';
import 'package:ucourses/core/constants/constants_exports.dart';
import 'package:ucourses/features/admin/presentation/screens/admin_login_screen.dart';
import '../features/student/presentation/screens/student_login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          labelStyle: Styles.style18,
          controller: _tabController,
          tabs: const [
            Tab(text: AppTexts.user),
            Tab(text: AppTexts.admin),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          StudentLoginScreen(),
          AdminLoginScreen(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
