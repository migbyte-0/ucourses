import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ucourses/core/constants/app_colors.dart';
import 'package:ucourses/core/constants/app_text.dart';
import 'package:ucourses/core/constants/app_text_styles.dart';
import 'package:ucourses/core/constants/constants_exports.dart';
import 'package:ucourses/core/shared/widgets/decorators/gradient_container_widget.dart';
import 'package:ucourses/core/util/form_validator.dart';
import '../../../../core/shared/widgets/style/custom_input_field.dart';
import '../../../../init/widgets/logo_shadow.dart';
import '../cubit/admin_auth_cubit.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocListener<AdminAuthCubit, AdminAuthState>(
          listener: (context, state) {
            if (state == AdminAuthState.authenticated) {
              _saveLoginState();
              Navigator.pushReplacementNamed(context, '/admin_courses');
            } else if (state == AdminAuthState.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppTexts.authFailed)),
              );
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  maxRadius: 55,
                  child: Image.asset('lib/assets/images/icons/app-logo.png'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  margin: const EdgeInsets.only(
                      top: 30, right: 100, left: 100, bottom: 60),
                  elevation: 15,
                  child: Form(
                    key: _formKey,
                    child: GradientContainer(
                      myHeight: 300,
                      myContainerBorderRadius: BorderRadius.circular(20),
                      firstGradientColor: AppColors.primaryColor,
                      secondGradientColor: AppColors.thirdColor,
                      myChild: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 40, top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomInputField(
                              controller: emailController,
                              labelText: AppTexts.email,
                              validator: FormValidator.validateEmail,
                              prefixIcon: Icons.email,
                              suffixIconData: Icons.clear,
                              onClearButtonPressed: () =>
                                  emailController.clear(),
                            ),
                            const SizedBox(height: 16),
                            CustomInputField(
                              controller: passwordController,
                              labelText: AppTexts.password,
                              validator: FormValidator.validatePassword,
                              prefixIcon: Icons.lock,
                              obscureText: !_isPasswordVisible,
                              suffixIconData: _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              onClearButtonPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                    });
                                  },
                                ),
                                Text(
                                  AppTexts.rememberMe,
                                  style: Styles.style16White,
                                ),
                              ],
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_rememberMe) {
                                    _saveCredentials();
                                  }
                                  context
                                      .read<AdminAuthCubit>()
                                      .authenticateAdmin(
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                      );
                                }
                              },
                              icon: const Icon(Icons.login),
                              label: Text(
                                AppTexts.login,
                                style: Styles.style17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', passwordController.text);
  }

  void _saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogged', true);
  }

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  void _loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailController.text = prefs.getString('email') ?? "";
      passwordController.text = prefs.getString('password') ?? "";
      _rememberMe = prefs.getBool('isLogged') ?? false;
    });
  }
}
