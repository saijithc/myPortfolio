import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';
import '../view_models/portfolio_view_model.dart';

class TerminalInput extends StatefulWidget {
  const TerminalInput({super.key});

  @override
  State<TerminalInput> createState() => _TerminalInputState();
}

class _TerminalInputState extends State<TerminalInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _executeCommand(String cmd) {
    if (cmd.trim().isEmpty) return;
    final viewModel = context.read<PortfolioViewModel>();
    final response = viewModel.processCommand(cmd.trim());
    _controller.clear();

    if (mounted && response.isNotEmpty) {
      _focusNode.requestFocus();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response,
            style: GoogleFonts.jetBrainsMono(
              color: AppTheme.neonGreen,
              fontSize: 13,
            ),
          ),
          backgroundColor: const Color(0xFF1A1A1A),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.only(bottom: 80, left: 20, right: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: AppTheme.neonGreen.withValues(alpha: 0.3)),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 450;
    final viewModel = context.watch<PortfolioViewModel>();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 10 : 16,
        vertical: isMobile ? 6 : 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(color: AppTheme.neonGreen.withValues(alpha: 0.25)),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.neonGreen.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            'guest@saijithc:~',
            style: GoogleFonts.jetBrainsMono(
              fontSize: isMobile ? 11 : 13,
              color: AppTheme.neonGreen,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            ' \$ ',
            style: GoogleFonts.jetBrainsMono(
              fontSize: isMobile ? 11 : 13,
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              style: GoogleFonts.jetBrainsMono(
                fontSize: isMobile ? 11 : 13,
                color: AppTheme.textPrimary,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                border: InputBorder.none,
                hintText: viewModel.lastCommandFeedback.isEmpty
                    ? 'type "help" for commands'
                    : '',
                hintStyle: GoogleFonts.jetBrainsMono(
                  fontSize: isMobile ? 11 : 13,
                  color: AppTheme.textTertiary.withValues(alpha: 0.4),
                ),
              ),
              onSubmitted: _executeCommand,
              cursorColor: AppTheme.neonGreen,
            ),
          ),
          if (_controller.text.isNotEmpty)
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _executeCommand(_controller.text),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Icon(
                    Icons.arrow_circle_right,
                    color: AppTheme.neonGreen,
                    size: isMobile ? 16 : 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
