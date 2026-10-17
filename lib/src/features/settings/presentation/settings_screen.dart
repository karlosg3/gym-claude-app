import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_claude/src/core/domain/app_accent_color.dart';
import 'package:gym_claude/src/core/domain/weight_unit.dart';
import 'package:gym_claude/src/design_system/design_system.dart';
import 'package:gym_claude/src/features/settings/presentation/settings_providers.dart';
import 'package:gym_claude/src/l10n/l10n.dart';
import 'package:gym_claude/src/routing/routes.dart';

/// Pantalla completa de Ajustes de la aplicación.
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late final TextEditingController _nameController;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _nameController.dispose();
    super.dispose();
  }

  void _onNameChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      ref.read(settingsControllerProvider.notifier).updateUserName(value);
    });
  }

  Future<void> _selectReminderTime(
    BuildContext context,
    int currentMinutes,
  ) async {
    final initialTime = TimeOfDay(
      hour: currentMinutes ~/ 60,
      minute: currentMinutes % 60,
    );
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: context.gcColors.accent,
              surface: context.gcColors.surface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final minutes = picked.hour * 60 + picked.minute;
      await ref
          .read(settingsControllerProvider.notifier)
          .updateReminderMinutes(minutes);
    }
  }

  Future<void> _confirmWipeData(BuildContext context) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: context.gcColors.surface,
          title: Text(l10n.settingsWipeConfirmTitle),
          content: Text(
            l10n.settingsWipeConfirmMessage,
            style: context.gcText.body.copyWith(
              color: context.gcColors.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(
                l10n.settingsWipeCancelAction,
                style: TextStyle(color: context.gcColors.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(
                l10n.settingsWipeConfirmAction,
                style: TextStyle(color: context.gcColors.danger),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      await ref.read(settingsControllerProvider.notifier).wipeAllData();
      if (mounted) {
        _nameController.text = '';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.gcColors;
    final textStyles = context.gcText;
    final settingsAsync = ref.watch(settingsProvider);

    return GcScaffold(
      title: l10n.navSettings,
      leading: IconSquareButton(
        icon: GcIcons.back,
        semanticLabel: l10n.actionBack,
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          }
        },
      ),
      body: AsyncValueView(
        value: settingsAsync,
        data: (settings) {
          if (_nameController.text != settings.userName &&
              _debounceTimer?.isActive != true) {
            _nameController.text = settings.userName;
          }

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: GcSpacing.screenHorizontal,
              vertical: GcSpacing.md,
            ),
            children: [
              // PERFIL
              GcCard(
                padding: const EdgeInsets.all(GcSpacing.lg),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 29,
                      backgroundColor: colors.accent,
                      child: Text(
                        settings.userInitial,
                        style: textStyles.headline.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: GcSpacing.md + 2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.settingsNameLabel.toUpperCase(),
                            style: textStyles.overline.copyWith(
                              color: colors.textMuted,
                            ),
                          ),
                          const SizedBox(height: GcSpacing.xs),
                          TextField(
                            controller: _nameController,
                            onChanged: _onNameChanged,
                            style: textStyles.bodyStrong.copyWith(
                              color: colors.textPrimary,
                            ),
                            decoration: InputDecoration(
                              hintText: l10n.settingsNamePlaceholder,
                              hintStyle: textStyles.bodyStrong.copyWith(
                                color: colors.textFaint,
                              ),
                              filled: true,
                              fillColor: colors.surfaceSunken,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: GcSpacing.md,
                                vertical: GcSpacing.sm + 3,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(GcRadii.md),
                                borderSide: BorderSide(color: colors.border),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(GcRadii.md),
                                borderSide: BorderSide(color: colors.border),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(GcRadii.md),
                                borderSide: BorderSide(color: colors.accent),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // APARIENCIA
              Padding(
                padding: const EdgeInsets.only(
                  top: GcSpacing.xl + 2,
                  left: GcSpacing.xs,
                  bottom: GcSpacing.sm,
                ),
                child: Text(
                  l10n.settingsSectionAppearance.toUpperCase(),
                  style: textStyles.overline.copyWith(color: colors.textMuted),
                ),
              ),
              GcCard(
                padding: const EdgeInsets.all(GcSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.settingsThemeColorTitle,
                      style: textStyles.body.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: GcSpacing.xs / 2),
                    Text(
                      l10n.settingsThemeColorSubtitle,
                      style: textStyles.caption.copyWith(
                        color: colors.textMuted,
                      ),
                    ),
                    const SizedBox(height: GcSpacing.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: AppAccentColor.values.map((colorOption) {
                        final isSelected = settings.themeColor == colorOption;
                        final scale = AppAccentColors.of(colorOption);
                        final label = _getColorName(l10n, colorOption);

                        return _AccentColorOptionButton(
                          label: label,
                          color: scale.accent,
                          isSelected: isSelected,
                          onTap: () {
                            ref
                                .read(settingsControllerProvider.notifier)
                                .updateThemeColor(colorOption);
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // ENTRENAMIENTO
              Padding(
                padding: const EdgeInsets.only(
                  top: GcSpacing.xl + 2,
                  left: GcSpacing.xs,
                  bottom: GcSpacing.sm,
                ),
                child: Text(
                  l10n.settingsSectionTraining.toUpperCase(),
                  style: textStyles.overline.copyWith(color: colors.textMuted),
                ),
              ),
              GcCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: GcSpacing.lg,
                        vertical: GcSpacing.md + 1,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.settingsWeeklyGoalTitle,
                                  style: textStyles.body.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: colors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: GcSpacing.xs / 2),
                                Text(
                                  l10n.settingsWeeklyGoalSubtitle,
                                  style: textStyles.caption.copyWith(
                                    color: colors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GcStepper(
                            value: settings.weeklyGoal,
                            onChanged: (val) {
                              ref
                                  .read(settingsControllerProvider.notifier)
                                  .updateWeeklyGoal(val);
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFF2A2620),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: GcSpacing.lg,
                        vertical: GcSpacing.md + 1,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.settingsDefaultUnitTitle,
                                  style: textStyles.body.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: colors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: GcSpacing.xs / 2),
                                Text(
                                  l10n.settingsDefaultUnitSubtitle,
                                  style: textStyles.caption.copyWith(
                                    color: colors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SegmentedControl<WeightUnit>(
                            options: const [
                              SegmentedOption(
                                value: WeightUnit.kg,
                                label: 'kg',
                              ),
                              SegmentedOption(
                                value: WeightUnit.lb,
                                label: 'lb',
                              ),
                            ],
                            selectedValue: settings.defaultUnit,
                            onChanged: (unit) {
                              ref
                                  .read(settingsControllerProvider.notifier)
                                  .updateDefaultUnit(unit);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // NOTIFICACIONES
              Padding(
                padding: const EdgeInsets.only(
                  top: GcSpacing.xl + 2,
                  left: GcSpacing.xs,
                  bottom: GcSpacing.sm,
                ),
                child: Text(
                  l10n.settingsSectionNotifications.toUpperCase(),
                  style: textStyles.overline.copyWith(color: colors.textMuted),
                ),
              ),
              GcCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    GcSwitchRow(
                      title: l10n.settingsWorkoutReminderTitle,
                      subtitle: l10n.settingsWorkoutReminderSubtitle,
                      value: settings.workoutReminderEnabled,
                      showTopDivider: false,
                      onChanged: (val) {
                        ref
                            .read(settingsControllerProvider.notifier)
                            .toggleWorkoutReminder(val);
                      },
                    ),
                    if (settings.workoutReminderEnabled)
                      InkWell(
                        onTap: () => _selectReminderTime(
                          context,
                          settings.reminderMinutes,
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Color(0xFF2A2620)),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: GcSpacing.lg,
                            vertical: GcSpacing.md + 1,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  l10n.settingsReminderTimeTitle,
                                  style: textStyles.body.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: colors.textPrimary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: GcSpacing.sm),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: GcSpacing.md - 2,
                                  vertical: GcSpacing.sm,
                                ),
                                decoration: BoxDecoration(
                                  color: colors.surfaceSunken,
                                  borderRadius:
                                      BorderRadius.circular(GcRadii.sm + 2),
                                  border: Border.all(color: colors.border),
                                ),
                                child: Text(
                                  settings.reminderTimeFormatted,
                                  style: textStyles.bodyStrong.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: colors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    GcSwitchRow(
                      title: l10n.settingsStreakRiskTitle,
                      subtitle: l10n.settingsStreakRiskSubtitle,
                      value: settings.streakRiskEnabled,
                      onChanged: (val) {
                        ref
                            .read(settingsControllerProvider.notifier)
                            .toggleStreakRisk(val);
                      },
                    ),
                    GcSwitchRow(
                      title: l10n.settingsRecordsTitle,
                      subtitle: l10n.settingsRecordsSubtitle,
                      value: settings.recordsEnabled,
                      onChanged: (val) {
                        ref
                            .read(settingsControllerProvider.notifier)
                            .toggleRecords(val);
                      },
                    ),
                  ],
                ),
              ),

              // DATOS
              Padding(
                padding: const EdgeInsets.only(
                  top: GcSpacing.xl + 2,
                  left: GcSpacing.xs,
                  bottom: GcSpacing.sm,
                ),
                child: Text(
                  l10n.settingsSectionData.toUpperCase(),
                  style: textStyles.overline.copyWith(color: colors.textMuted),
                ),
              ),
              GcCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => context.pushExport(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: GcSpacing.lg,
                          vertical: GcSpacing.md + 2,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.navExport,
                                    style: textStyles.body.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: GcSpacing.xs / 2),
                                  Text(
                                    l10n.settingsExportSubtitle,
                                    style: textStyles.caption.copyWith(
                                      color: colors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              GcIcons.chevronRight,
                              size: GcIcons.sizeSm + 2,
                              color: colors.textDisabled,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFF2A2620),
                    ),
                    InkWell(
                      onTap: () => _confirmWipeData(context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: GcSpacing.lg,
                          vertical: GcSpacing.md + 2,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            l10n.settingsWipeDataButton,
                            style: textStyles.body.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colors.error,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // PIE DE PÁGINA
              const SizedBox(height: GcSpacing.xxl),
              Text(
                '${l10n.settingsFooterAppVersion}\n${l10n.settingsFooterPrivacy}',
                textAlign: TextAlign.center,
                style: textStyles.caption.copyWith(
                  color: colors.textDisabled,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: GcSpacing.xl),
            ],
          );
        },
      ),
    );
  }
}

String _getColorName(AppLocalizations l10n, AppAccentColor color) {
  return switch (color) {
    AppAccentColor.orange => l10n.colorOrange,
    AppAccentColor.blue => l10n.colorBlue,
    AppAccentColor.green => l10n.colorGreen,
    AppAccentColor.purple => l10n.colorPurple,
    AppAccentColor.red => l10n.colorRed,
  };
}

class _AccentColorOptionButton extends StatelessWidget {
  const _AccentColorOptionButton({
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.gcColors;
    final textStyles = context.gcText;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(GcRadii.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GcSpacing.xs,
            vertical: GcSpacing.xs,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: colors.background,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: isSelected ? color : colors.borderStrong,
                        width: isSelected ? 2.0 : 1.5,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: color.withValues(alpha: 0.35),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Icon(
                        GcIcons.exercises,
                        size: 24,
                        color: color,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colors.surface,
                            width: 1.5,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.check,
                            size: 11,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: GcSpacing.xs + 2),
              Text(
                label,
                style: textStyles.caption.copyWith(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? colors.textPrimary : colors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
