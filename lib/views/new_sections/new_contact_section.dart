import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../view_models/portfolio_view_model.dart';
import '../../widgets/section_header.dart';

class NewContactSection extends StatelessWidget {
  const NewContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bp = ResponsiveBreakpoints.of(context);
    final isMobile = bp.isMobile;
    final isTablet = bp.isTablet;
    final double horizontalPad = isMobile ? 16.0 : (isTablet ? 40.0 : 64.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPad,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TerminalHeader(command: 'sudo mail -s "hi"'),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: isMobile
                ? Column(children: [const _ContactForm()])
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [const Expanded(flex: 2, child: _ContactForm())],
                  ),
          ),
        ],
      ),
    );
  }
}

class _ContactForm extends StatelessWidget {
  const _ContactForm();

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioViewModel>(
      builder: (context, vm, child) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: AppTheme.surfaceCard(radius: 12),
          child: Form(
            key: vm.contactFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Field(controller: vm.nameController, validator: vm.validateName, label: 'USER_NAME', hint: 'guest_user_01'),
                const SizedBox(height: 20),
                _Field(controller: vm.emailController, validator: vm.validateEmail, label: 'USER_EMAIL', hint: 'user@remote.host', keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 20),
                _Field(controller: vm.messageController, validator: vm.validateMessage, label: 'PACKET_PAYLOAD', hint: 'Enter message text...', maxLines: 4),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: vm.isSubmittingContact ? null : vm.submitContactForm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(color: AppTheme.primaryContainer.withValues(alpha: 0.4), blurRadius: 20)],
                      ),
                      child: Center(
                        child: vm.isSubmittingContact
                            ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.send, size: 16, color: Color(0xFF521800)),
                                  const SizedBox(width: 8),
                                  Text('SEND_TRANSMISSION', style: AppTheme.codeMedium.copyWith(color: AppTheme.onPrimaryContainer, fontWeight: FontWeight.w700, fontSize: 13)),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final int maxLines;

  const _Field({required this.controller, required this.validator, required this.label, required this.hint, this.keyboardType, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: AppTheme.codeMedium.copyWith(color: AppTheme.onSurface, fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: AppTheme.codeMedium.copyWith(fontSize: 11, color: AppTheme.onSurfaceVariant),
        hintStyle: AppTheme.codeMedium.copyWith(fontSize: 11, color: AppTheme.outline),
        filled: true,
        fillColor: AppTheme.surfaceContainerLowest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.primaryContainer.withValues(alpha: 0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.primaryContainer.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.primaryContainer, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}

