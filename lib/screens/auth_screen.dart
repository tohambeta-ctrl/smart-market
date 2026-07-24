import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../l10n/app_localizations.dart';
import '../main.dart' show authNotifier;
import '../models/models.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/sm_button.dart';

// ── Public enum so GoRouter can reference it ─────────────────────────────────
enum AuthTab { login, signUp }

// ─────────────────────────────────────────────────────────────────────────────
// AuthScreen
// ─────────────────────────────────────────────────────────────────────────────
class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
    this.initialTab = AuthTab.login,
    this.initialRole = UserRole.buyer,
  });

  final AuthTab initialTab;
  final UserRole initialRole;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  late UserRole _role;

  @override
  void initState() {
    super.initState();
    _role = widget.initialRole;
    _tabCtrl = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab == AuthTab.signUp ? 1 : 0,
    );
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  void _onRoleChanged(UserRole role) => setState(() => _role = role);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.primary50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              // ── Back button row ──────────────────────────────────────────
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () =>
                      context.canPop() ? context.pop() : context.go('/'),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 15),
                  label: Text(l.authBackToApp),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.neutral600,
                    textStyle: AppTextStyles.labelMedium,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ── Branding ────────────────────────────────────────────────
              Text(
                l.authTitle,
                style: AppTextStyles.splashTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                l.authTagline,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.neutral600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              // ── Card ─────────────────────────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Tab bar
                    _AuthTabBar(
                      controller: _tabCtrl,
                      l: l,
                      onTabChanged: (_) => setState(() {}),
                    ),

                    // Use IndexedStack instead of TabBarView so height is
                    // driven by content, not a fixed constraint.
                    IndexedStack(
                      index: _tabCtrl.index,
                      children: [
                        _LoginForm(role: _role, onRoleChanged: _onRoleChanged),
                        _SignUpForm(role: _role, onRoleChanged: _onRoleChanged),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // ── Secure payments footer ──────────────────────────────────
              _SecurePaymentsFooter(l: l),
              const SizedBox(height: 20),

              // ── Back to App link ─────────────────────────────────────────
              TextButton(
                onPressed: () =>
                    context.canPop() ? context.pop() : context.go('/'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.neutral400,
                  textStyle: AppTextStyles.labelMedium,
                ),
                child: Text(l.authBackToApp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab bar — LOGIN / SIGN UP with green underline indicator
// ─────────────────────────────────────────────────────────────────────────────
class _AuthTabBar extends StatelessWidget {
  const _AuthTabBar({
    required this.controller,
    required this.l,
    required this.onTabChanged,
  });
  final TabController controller;
  final AppLocalizations l;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      onTap: onTabChanged,
      labelStyle: AppTextStyles.labelLarge.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
      ),
      unselectedLabelStyle: AppTextStyles.labelLarge.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
      ),
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.neutral600,
      indicatorColor: AppColors.primary,
      indicatorWeight: 2.5,
      dividerColor: AppColors.neutral200,
      tabs: [
        Tab(text: l.authTabLogin),
        Tab(text: l.authTabSignUp),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Buyer / Seller toggle pill
// ─────────────────────────────────────────────────────────────────────────────
class _RoleToggle extends StatelessWidget {
  const _RoleToggle({
    required this.role,
    required this.onChanged,
    required this.l,
  });
  final UserRole role;
  final ValueChanged<UserRole> onChanged;
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.neutral200,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          _RolePill(
            label: l.authRoleBuyer,
            selected: role == UserRole.buyer,
            onTap: () => onChanged(UserRole.buyer),
          ),
          _RolePill(
            label: l.authRoleSeller,
            selected: role == UserRole.seller,
            onTap: () => onChanged(UserRole.seller),
          ),
        ],
      ),
    );
  }
}

class _RolePill extends StatelessWidget {
  const _RolePill({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: selected ? AppColors.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                color: selected ? AppColors.primary : AppColors.neutral600,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared text field
// ─────────────────────────────────────────────────────────────────────────────
class _AuthField extends StatefulWidget {
  const _AuthField({
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.isPassword = false,
    this.keyboardType,
  });
  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final TextInputType? keyboardType;

  @override
  State<_AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<_AuthField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword && _obscure,
      keyboardType: widget.keyboardType,
      style: AppTextStyles.bodyMedium,
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: Icon(
          widget.prefixIcon,
          size: 20,
          color: AppColors.neutral400,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 20,
                  color: AppColors.neutral400,
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
              )
            : null,
        filled: true,
        fillColor: AppColors.primary50,
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.neutral400,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// OR CONTINUE WITH divider
// ─────────────────────────────────────────────────────────────────────────────
class _OrDivider extends StatelessWidget {
  const _OrDivider({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.neutral200)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.neutral400,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.neutral200)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Social sign-in buttons row (Google / Facebook)
// ─────────────────────────────────────────────────────────────────────────────
class _SocialButtons extends StatelessWidget {
  const _SocialButtons({required this.l});
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SocialBtn(label: l.authGoogle, icon: _googleIcon),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SocialBtn(label: l.authFacebook, icon: _facebookIcon),
        ),
      ],
    );
  }

  // Inline SVG-style painters for Google & Facebook letter marks
  static Widget get _googleIcon =>
      _LetterIcon(letter: 'G', color: const Color(0xFF4285F4));
  static Widget get _facebookIcon =>
      _LetterIcon(letter: 'f', color: const Color(0xFF1877F2));
}

class _SocialBtn extends StatelessWidget {
  const _SocialBtn({required this.label, required this.icon});
  final String label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: icon,
      label: Text(
        label,
        style: AppTextStyles.labelMedium.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
          color: AppColors.neutral,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.neutral200),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 12),
        backgroundColor: AppColors.surface,
      ),
    );
  }
}

class _LetterIcon extends StatelessWidget {
  const _LetterIcon({required this.letter, required this.color});
  final String letter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      letter,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w900,
        color: color,
        height: 1,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Login form
// ─────────────────────────────────────────────────────────────────────────────
class _LoginForm extends StatefulWidget {
  const _LoginForm({required this.role, required this.onRoleChanged});
  final UserRole role;
  final ValueChanged<UserRole> onRoleChanged;

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submit(AppLocalizations l) {
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;

    if (email.isEmpty || pass.isEmpty) {
      _showError(l.authErrorEmptyFields);
      return;
    }
    if (pass.length < 6) {
      _showError(l.authErrorShortPassword);
      return;
    }

    setState(() => _loading = true);

    // Simulate async auth — replace with real API call
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      authNotifier.value = AppUser(
        id: 'u_${DateTime.now().millisecondsSinceEpoch}',
        name: email.split('@').first,
        emailOrPhone: email,
        role: widget.role,
      );
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l.authLoginSuccess),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
      context.pop();
    });
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _RoleToggle(role: widget.role, onChanged: widget.onRoleChanged, l: l),
          const SizedBox(height: 16),
          _AuthField(
            controller: _emailCtrl,
            hint: l.authEmailOrPhone,
            prefixIcon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          _AuthField(
            controller: _passCtrl,
            hint: l.authPassword,
            prefixIcon: Icons.lock_outline,
            isPassword: true,
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                l.authForgotPassword,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SmButton.primary(
            label: l.authLoginButton,
            onPressed: _loading ? null : () => _submit(l),
            loading: _loading,
            expanded: true,
            size: SmButtonSize.large,
          ),
          const SizedBox(height: 20),
          _OrDivider(label: l.authOrContinueWith),
          const SizedBox(height: 16),
          _SocialButtons(l: l),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sign-up form
// ─────────────────────────────────────────────────────────────────────────────
class _SignUpForm extends StatefulWidget {
  const _SignUpForm({required this.role, required this.onRoleChanged});
  final UserRole role;
  final ValueChanged<UserRole> onRoleChanged;

  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit(AppLocalizations l) {
    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;
    final confirm = _confirmCtrl.text;

    if (name.isEmpty || email.isEmpty || pass.isEmpty || confirm.isEmpty) {
      _showError(l.authErrorEmptyFields);
      return;
    }
    if (pass.length < 6) {
      _showError(l.authErrorShortPassword);
      return;
    }
    if (pass != confirm) {
      _showError(l.authErrorPasswordMismatch);
      return;
    }

    setState(() => _loading = true);

    // Simulate async registration — replace with real API call
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      authNotifier.value = AppUser(
        id: 'u_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        emailOrPhone: email,
        role: widget.role,
      );
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l.authSignUpSuccess),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
      context.pop();
    });
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _RoleToggle(role: widget.role, onChanged: widget.onRoleChanged, l: l),
          const SizedBox(height: 16),
          _AuthField(
            controller: _nameCtrl,
            hint: l.authFullName,
            prefixIcon: Icons.person_outline,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 12),
          _AuthField(
            controller: _emailCtrl,
            hint: l.authEmailOrPhone,
            prefixIcon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          _AuthField(
            controller: _passCtrl,
            hint: l.authPassword,
            prefixIcon: Icons.lock_outline,
            isPassword: true,
          ),
          const SizedBox(height: 12),
          _AuthField(
            controller: _confirmCtrl,
            hint: l.authConfirmPassword,
            prefixIcon: Icons.lock_outline,
            isPassword: true,
          ),
          const SizedBox(height: 20),
          SmButton.primary(
            label: l.authSignUpButton,
            onPressed: _loading ? null : () => _submit(l),
            loading: _loading,
            expanded: true,
            size: SmButtonSize.large,
          ),
          const SizedBox(height: 20),
          _OrDivider(label: l.authOrContinueWith),
          const SizedBox(height: 16),
          _SocialButtons(l: l),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Secure payments footer
// ─────────────────────────────────────────────────────────────────────────────
class _SecurePaymentsFooter extends StatelessWidget {
  const _SecurePaymentsFooter({required this.l});
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          l.authSecurePaymentsVia,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.neutral400,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _PaymentChip(label: 'MTN\nMoMo', color: const Color(0xFFFFCC00)),
            const SizedBox(width: 12),
            _PaymentChip(
              label: 'Orange\nMoney',
              color: const Color(0xFFFF6600),
            ),
          ],
        ),
      ],
    );
  }
}

class _PaymentChip extends StatelessWidget {
  const _PaymentChip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: AppTextStyles.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          height: 1.3,
        ),
      ),
    );
  }
}
