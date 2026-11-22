
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGate extends StatelessWidget {
  final Widget home;
  final bool isArabic;

  const AuthGate({
    super.key,
    required this.home,
    this.isArabic = true,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return home;
        }

        return AuthPage(isArabic: isArabic);
      },
    );
  }
}

class AuthPage extends StatefulWidget {
  final bool isArabic;

  const AuthPage({super.key, required this.isArabic});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLogin = true;
  bool loading = false;
  bool hidePassword = true;

  String t(String ar, String en) =>
      widget.isArabic ? ar : en;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> submit() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showMessage(t(
        'أدخل البريد الإلكتروني وكلمة المرور',
        'Enter your email and password',
      ));
      return;
    }

    if (password.length < 6) {
      showMessage(t(
        'كلمة المرور يجب أن تكون 6 أحرف على الأقل',
        'Password must be at least 6 characters',
      ));
      return;
    }

    setState(() => loading = true);

    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'user-not-found':
        case 'invalid-credential':
          message = t(
            'البريد الإلكتروني أو كلمة المرور غير صحيحة',
            'Incorrect email or password',
          );
          break;
        case 'email-already-in-use':
          message = t(
            'هذا البريد مسجل بالفعل',
            'This email is already registered',
          );
          break;
        case 'weak-password':
          message = t(
            'كلمة المرور ضعيفة',
            'Password is too weak',
          );
          break;
        case 'invalid-email':
          message = t(
            'البريد الإلكتروني غير صالح',
            'Invalid email address',
          );
          break;
        case 'network-request-failed':
          message = t(
            'تحقق من اتصال الإنترنت',
            'Check your internet connection',
          );
          break;
        default:
          message = t(
            'حدث خطأ: ${e.message ?? e.code}',
            'Error: ${e.message ?? e.code}',
          );
      }

      showMessage(message);
    } catch (e) {
      showMessage(t('حدث خطأ غير متوقع', 'Unexpected error'));
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  Future<void> resetPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      showMessage(t(
        'أدخل بريدك الإلكتروني أولاً',
        'Enter your email first',
      ));
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );

      showMessage(t(
        'تم إرسال رابط استعادة كلمة المرور إلى بريدك',
        'Password reset link sent to your email',
      ));
    } on FirebaseAuthException catch (e) {
      showMessage(e.message ?? e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ar = widget.isArabic;

    return Directionality(
      textDirection: ar ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Column(
                  children: [
                    const Icon(
                      Icons.shield_rounded,
                      size: 85,
                      color: Color(0xFF00D6B2),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'HAMOUDI CYBER LABS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      t(
                        'حسابك الآمن يبدأ من هنا',
                        'Your secure account starts here',
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      isLogin
                          ? t('تسجيل الدخول', 'Sign in')
                          : t('إنشاء حساب جديد', 'Create account'),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 22),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: t(
                          'البريد الإلكتروني',
                          'Email address',
                        ),
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        labelText: t('كلمة المرور', 'Password'),
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    if (isLogin)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: loading ? null : resetPassword,
                          child: Text(
                            t(
                              'نسيت كلمة المرور؟',
                              'Forgot password?',
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        onPressed: loading ? null : submit,
                        child: loading
                            ? const CircularProgressIndicator()
                            : Text(
                                isLogin
                                    ? t('دخول', 'Sign in')
                                    : t('إنشاء الحساب', 'Create account'),
                                style: const TextStyle(fontSize: 17),
                              ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextButton(
                      onPressed: loading
                          ? null
                          : () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                      child: Text(
                        isLogin
                            ? t(
                                'ليس لديك حساب؟ أنشئ حساباً',
                                'No account? Create one',
                              )
                            : t(
                                'لديك حساب بالفعل؟ سجل الدخول',
                                'Already have an account? Sign in',
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'HAMOUDI CYBER LABS © 2026',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
