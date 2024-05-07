import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:ucourses/core/constants/app_text.dart';
import 'package:ucourses/core/constants/app_text_styles.dart';
import 'package:ucourses/core/shared/widgets/style/custom_appbar.dart';
import 'package:ucourses/core/shared/widgets/style/custom_appbar_actions.dart';
import '../../../student/presentation/cubit/student_list_cubit.dart';

class AdminStudentListScreen extends StatefulWidget {
  const AdminStudentListScreen({super.key});

  @override
  _AdminStudentListScreenState createState() => _AdminStudentListScreenState();
}

class _AdminStudentListScreenState extends State<AdminStudentListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1100),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();

    BlocProvider.of<StudentListCubit>(context).fetchAllStudents();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppTexts.adminUserManagement,
        actions: customAppBarActions(context),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      AppTexts.userList,
                      style: Styles.style16White,
                    ),
                  ),
                ],
              ),
              const Divider(),
              BlocBuilder<StudentListCubit, StudentListState>(
                builder: (context, state) {
                  if (state is StudentListLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is StudentListLoaded) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(
                                label: Text(
                              AppTexts.userName,
                              style: Styles.style15grey,
                            )),
                            DataColumn(
                                label: Text(
                              AppTexts.email,
                              style: Styles.style15grey,
                            )),
                            DataColumn(
                                label: Text(
                              AppTexts.createdAt,
                              style: Styles.style15grey,
                            )),
                          ],
                          rows: state.students.map((student) {
                            return DataRow(
                              cells: [
                                DataCell(_buildAnimatedCell(
                                  context,
                                  Row(
                                    children: [
                                      const Icon(Icons.person,
                                          size: 16, color: Colors.deepOrange),
                                      const SizedBox(width: 8),
                                      Text(student.username,
                                          style: Styles.style16),
                                    ],
                                  ),
                                )),
                                DataCell(_buildAnimatedCell(
                                  context,
                                  Row(
                                    children: [
                                      const Icon(Icons.email,
                                          size: 16, color: Colors.green),SizedBox(width: 8,),
                                      Text(student.email,
                                          style: Styles.style16),
                                    ],
                                  ),
                                )),
                                DataCell(_buildAnimatedCell(
                                  context,
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today,
                                          size: 16, color: Colors.blue),
                                      const SizedBox(width: 8),
                                      Text(
                                          intl.DateFormat.yMMMd()
                                              .format(student.createdAt),
                                          style: Styles.style16),
                                    ],
                                  ),
                                )),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  } else if (state is StudentListEmpty) {
                    return Center(
                      child: _buildAnimatedCell(
                        context,
                        const Text('No students found', style: Styles.style16),
                      ),
                    );
                  } else {
                    return Center(
                      child: _buildAnimatedCell(
                        context,
                        const Text('Something went wrong',
                            style: Styles.style16),
                      ),
                    );
                  }
                },
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedCell(BuildContext context, Widget child) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
