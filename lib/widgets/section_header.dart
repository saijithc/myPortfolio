import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class TerminalHeader extends StatelessWidget {
  final String command;

  const TerminalHeader({super.key, required this.command});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Text(
        '\$ $command',
        style: AppTheme.terminalHeader,
      ),
    );
  }
}
