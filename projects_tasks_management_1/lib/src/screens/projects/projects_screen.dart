import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:projects_tasks_management_1/gen/assets.gen.dart';
import 'package:projects_tasks_management_1/gen/colors.gen.dart';
import 'package:projects_tasks_management_1/src/core/constants/sizes.dart';

@RoutePage()
class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
              ),
              child: Column(
                children: [
                  SizedBox(height: AppSizes.projectsScreenTopSpacing.h),
                  _buildTitleAndIcons(l10n, theme),
                  SizedBox(height: AppSizes.projectsScreenTopSpacing.h),
                  Container(
               
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildTitleAndIcons(AppLocalizations l10n, ThemeData theme) {
    return Row(
      children: [
        SizedBox(width: AppSizes.defaultPadding.w),
        Text(
          l10n.projects,
          style: theme.textTheme.headlineMedium,
        ),
        const Spacer(),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Ionicons.search_outline),
                onPressed: () {},
              ),
              IconButton(
                icon: Badge.count(
                  backgroundColor: ColorName.skeyBlue,
                  count: 3,
                  child: const Icon(Ionicons.notifications_outline),
                ),
                onPressed: () {},
              ),
              SizedBox(width: AppSizes.defaultPadding.w),
              InkWell(
                child: CircleAvatar(
                  child: Assets.images.mocks.profilePicture.image(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: AppSizes.defaultPadding.w),
      ],
    );
  }
}
