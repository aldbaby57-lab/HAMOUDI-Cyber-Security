
import 'package:flutter/material.dart';

void main() {
  runApp(const HamoudiApp());
}

class HamoudiApp extends StatefulWidget {
  const HamoudiApp({super.key});

  @override
  State<HamoudiApp> createState() => _HamoudiAppState();
}

class _HamoudiAppState extends State<HamoudiApp> {
  bool isArabic = true;
  ThemeMode themeMode = ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HAMOUDI CYBER LABS',
      themeMode: themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00BFA5),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00D6B2),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF08131F),
        useMaterial3: true,
      ),
      home: MainScreen(
        isArabic: isArabic,
        onLanguageChanged: (value) => setState(() => isArabic = value),
        themeMode: themeMode,
        onThemeChanged: (value) => setState(() => themeMode = value),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final bool isArabic;
  final ValueChanged<bool> onLanguageChanged;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  const MainScreen({
    super.key,
    required this.isArabic,
    required this.onLanguageChanged,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  String getText(String ar, String en) => widget.isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(isArabic: widget.isArabic),
      ToolsPage(isArabic: widget.isArabic),
      AcademyPage(isArabic: widget.isArabic),
      ProPage(isArabic: widget.isArabic),
      SettingsPage(
        isArabic: widget.isArabic,
        onLanguageChanged: widget.onLanguageChanged,
        themeMode: widget.themeMode,
        onThemeChanged: widget.onThemeChanged,
      ),
    ];

    final labels = widget.isArabic
        ? ['الرئيسية', 'الأدوات', 'الأكاديمية', 'PRO', 'الإعدادات']
        : ['Home', 'Tools', 'Academy', 'PRO', 'Settings'];

    return Directionality(
      textDirection:
          widget.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'HAMOUDI CYBER LABS',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
          centerTitle: true,
        ),
        body: pages[selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() => selectedIndex = index);
          },
          destinations: [
            for (int i = 0; i < labels.length; i++)
              NavigationDestination(
                icon: Icon([
                  Icons.home_rounded,
                  Icons.security_rounded,
                  Icons.school_rounded,
                  Icons.workspace_premium_rounded,
                  Icons.settings_rounded,
                ][i]),
                label: labels[i],
              ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final bool isArabic;
  const HomePage({super.key, required this.isArabic});

  String t(String ar, String en) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              colors: [Color(0xFF063D46), Color(0xFF10243B)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.shield_moon, size: 55, color: Color(0xFF00D6B2)),
              const SizedBox(height: 14),
              Text(
                t('مرحباً بك في عالم الحماية الرقمية',
                    'Welcome to digital protection'),
                style: const TextStyle(
                    fontSize: 21, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 9),
              Text(
                t('حافظ على أمانك وتعلّم كيف تحمي نفسك على الإنترنت.',
                    'Stay safe and learn how to protect yourself online.'),
              ),
              const SizedBox(height: 16),
              const Text(
                'HAMOUDI CYBER LABS',
                style: TextStyle(
                    color: Color(0xFF00D6B2),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Text(t('خدماتك الأمنية', 'Security services'),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        FeatureCard(
          icon: Icons.link,
          title: t('فحص الروابط', 'Link checker'),
          subtitle: t('تحقق مبدئياً من الروابط المشبوهة',
              'Check suspicious links locally'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LinkCheckerPage(isArabic: isArabic),
            ),
          ),
        ),
        FeatureCard(
          icon: Icons.password,
          title: t('أمان كلمات المرور', 'Password safety'),
          subtitle: t('تعرّف على صفات كلمة المرور القوية',
              'Learn what makes a strong password'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PasswordPage(isArabic: isArabic),
            ),
          ),
        ),
        FeatureCard(
          icon: Icons.phishing,
          title: t('التوعية بالتصيّد', 'Phishing awareness'),
          subtitle: t('تعرّف على رسائل الاحتيال الإلكتروني',
              'Learn to recognize phishing'),
          onTap: () => showInfo(context, t(
            'لا تضغط على الروابط غير المتوقعة، ولا تشارك رموز التحقق أو كلمات المرور.',
            'Avoid unexpected links. Never share passwords or verification codes.',
          )),
        ),
        const SizedBox(height: 18),
        Text(
          t('تنبيه أمني', 'Security notice'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(t(
          'نتائج الفحص الأولية إرشادية ولا تضمن اكتشاف جميع التهديدات.',
          'Preliminary checks are informational and cannot detect every threat.',
        )),
      ],
    );
  }
}

class ToolsPage extends StatelessWidget {
  final bool isArabic;
  const ToolsPage({super.key, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    String t(String ar, String en) => isArabic ? ar : en;
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Text(t('أدوات الحماية', 'Security tools'),
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        FeatureCard(
          icon: Icons.travel_explore,
          title: t('فحص الروابط', 'Link checker'),
          subtitle: t('فحص محلي أولي للرابط', 'Basic local URL check'),
          onTap: () => Navigator.push(context, MaterialPageRoute(
            builder: (_) => LinkCheckerPage(isArabic: isArabic),
          )),
        ),
        FeatureCard(
          icon: Icons.lock_outline,
          title: t('تقييم كلمة المرور', 'Password assessment'),
          subtitle: t('تقييم محلي دون إرسال كلمة المرور',
              'Local assessment without sending your password'),
          onTap: () => Navigator.push(context, MaterialPageRoute(
            builder: (_) => PasswordPage(isArabic: isArabic),
          )),
        ),
        FeatureCard(
          icon: Icons.phone_android,
          title: t('إرشادات أمان الهاتف', 'Phone security guide'),
          subtitle: t('خطوات لحماية جهازك', 'Steps to protect your device'),
          onTap: () => showInfo(context, t(
            'حدّث نظام الهاتف، واستخدم قفل الشاشة، وحمّل التطبيقات من المتاجر الرسمية، وراجع الأذونات.',
            'Update your phone, use a screen lock, install apps from official stores, and review permissions.',
          )),
        ),
        FeatureCard(
          icon: Icons.report_gmailerrorred,
          title: t('الإبلاغ عن تهديد', 'Report a threat'),
          subtitle: t('إرشادات التعامل مع التهديدات', 'Threat response guidance'),
          onTap: () => showInfo(context, t(
            'احتفظ بالأدلة ولا تتفاعل مع المرسل المشبوه. هذه النسخة لا ترسل البلاغات إلى خادم بعد.',
            'Keep evidence and do not engage with suspicious senders. Reporting to a server is not enabled yet.',
          )),
        ),
      ],
    );
  }
}

class LinkCheckerPage extends StatefulWidget {
  final bool isArabic;
  const LinkCheckerPage({super.key, required this.isArabic});

  @override
  State<LinkCheckerPage> createState() => _LinkCheckerPageState();
}

class _LinkCheckerPageState extends State<LinkCheckerPage> {
  final controller = TextEditingController();
  String? result;
  bool suspicious = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void checkLink() {
    final input = controller.text.trim();
    final uri = Uri.tryParse(input);
    final valid = uri != null &&
        (uri.scheme == 'https' || uri.scheme == 'http') &&
        uri.host.isNotEmpty;

    final warningWords = [
      'login',
      'verify',
      'password',
      'wallet',
      'free',
      'gift',
      'secure',
      'account',
    ];

    final hasWarning = warningWords.any(
      (word) => input.toLowerCase().contains(word),
    );

    setState(() {
      suspicious = !valid || hasWarning ||
          (uri != null && uri.scheme != 'https');
      result = !valid
          ? (widget.isArabic
              ? 'الرابط غير صالح أو لا يستخدم صيغة HTTP/HTTPS صحيحة.'
              : 'Invalid URL or unsupported URL format.')
          : suspicious
              ? (widget.isArabic
                  ? 'تنبيه: توجد مؤشرات تستحق الحذر. لا تفتح الرابط قبل التحقق منه.'
                  : 'Warning: Some indicators require caution. Verify before opening.')
              : (widget.isArabic
                  ? 'لم تظهر مؤشرات واضحة في الفحص المحلي الأولي. هذا لا يثبت أن الرابط آمن.'
                  : 'No obvious indicators found in this basic local check. This does not prove the link is safe.');
    });
  }

  @override
  Widget build(BuildContext context) {
    final ar = widget.isArabic;
    return Directionality(
      textDirection: ar ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: Text(ar ? 'فحص الروابط' : 'Link checker')),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Icon(Icons.link, size: 60, color: Color(0xFF00BFA5)),
            const SizedBox(height: 15),
            Text(ar ? 'أدخل الرابط للفحص الأولي' : 'Enter a URL for a basic check',
                style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            TextField(
              controller: controller,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                hintText: 'https://example.com',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: checkLink,
              icon: const Icon(Icons.security),
              label: Text(ar ? 'افحص الرابط' : 'Check URL'),
            ),
            if (result != null) ...[
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    result!,
                    style: TextStyle(
                      color: suspicious ? Colors.orange : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 15),
            Text(ar
                ? 'الفحص الحالي محلي ومبدئي فقط، ولا يتصل بخدمات قواعد بيانات التهديدات.'
                : 'This is a basic local check and does not query threat intelligence services.'),
          ],
        ),
      ),
    );
  }
}

class PasswordPage extends StatefulWidget {
  final bool isArabic;
  const PasswordPage({super.key, required this.isArabic});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final controller = TextEditingController();
  String result = '';
  bool hidden = true;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void assess() {
    final password = controller.text;
    int score = 0;
    if (password.length >= 12) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[a-z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[^A-Za-z0-9]'))) score++;

    setState(() {
      result = widget.isArabic
          ? score >= 4
              ? 'جيدة مبدئياً. استخدم كلمة مرور فريدة ولا تشاركها.'
              : 'ضعيفة أو متوسطة. اجعلها أطول وأضف تنوعاً في الأحرف.'
          : score >= 4
              ? 'Looks stronger. Use a unique password and never share it.'
              : 'Weak or moderate. Make it longer and more varied.';
    });
  }

  @override
  Widget build(BuildContext context) {
    final ar = widget.isArabic;
    return Directionality(
      textDirection: ar ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: Text(ar ? 'أمان كلمات المرور' : 'Password safety')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(ar
                  ? 'التقييم يتم على جهازك ولا تُرسل كلمة المرور إلى أي خادم.'
                  : 'Assessment happens on your device. Your password is not sent to a server.'),
              const SizedBox(height: 18),
              TextField(
                controller: controller,
                obscureText: hidden,
                decoration: InputDecoration(
                  labelText: ar ? 'كلمة المرور' : 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => hidden = !hidden),
                    icon: Icon(hidden ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              FilledButton(
                onPressed: assess,
                child: Text(ar ? 'قيّم كلمة المرور' : 'Assess password'),
              ),
              const SizedBox(height: 18),
              Text(result, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class AcademyPage extends StatelessWidget {
  final bool isArabic;
  const AcademyPage({super.key, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    String t(String ar, String en) => isArabic ? ar : en;
    final lessons = [
      [
        t('أساسيات الأمن السيبراني', 'Cybersecurity basics'),
        t('مقدمة عن حماية الأجهزة والبيانات.',
            'An introduction to protecting devices and data.'),
      ],
      [
        t('التصيد الإلكتروني', 'Phishing'),
        t('كيف تتعرف على الرسائل والروابط المزيفة.',
            'How to recognize fake messages and links.'),
      ],
      [
        t('حماية الحسابات', 'Account protection'),
        t('استخدم كلمات مرور فريدة والتحقق بخطوتين.',
            'Use unique passwords and two-step verification.'),
      ],
      [
        t('الخصوصية الرقمية', 'Digital privacy'),
        t('راجع إعدادات الخصوصية وأذونات التطبيقات.',
            'Review privacy settings and app permissions.'),
      ],
    ];

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Text(t('HAMOUDI ACADEMY', 'HAMOUDI ACADEMY'),
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(t('تعلم الأمن السيبراني خطوة بخطوة.',
            'Learn cybersecurity step by step.')),
        const SizedBox(height: 15),
        for (final lesson in lessons)
          FeatureCard(
            icon: Icons.menu_book,
            title: lesson[0],
            subtitle: lesson[1],
            onTap: () => showInfo(context, lesson[1]),
          ),
        const SizedBox(height: 12),
        Text(t('الدروس الحالية توعوية، ولا تصدر شهادات معتمدة.',
            'These lessons are educational and do not issue accredited certificates.')),
      ],
    );
  }
}

class ProPage extends StatelessWidget {
  final bool isArabic;
  const ProPage({super.key, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    String t(String ar, String en) => isArabic ? ar : en;
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Icon(Icons.workspace_premium,
            size: 70, color: Color(0xFF00D6B2)),
        const SizedBox(height: 12),
        const Center(
          child: Text('HAMOUDI PRO',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 18),
        FeatureCard(
          icon: Icons.travel_explore,
          title: t('فحص روابط متقدم', 'Advanced link checking'),
          subtitle: t('عبر خدمات سمعة موثوقة عند ربطها بالخادم.',
              'Through trusted reputation services once connected.'),
        ),
        FeatureCard(
          icon: Icons.smart_toy,
          title: 'HAMOUDI AI',
          subtitle: t('مساعد أمني ذكي عند تفعيل الخدمة.',
              'AI security assistant when the service is enabled.'),
        ),
        FeatureCard(
          icon: Icons.history,
          title: t('سجل الفحوصات والتقارير', 'Scan history and reports'),
          subtitle: t('ميزات تتطلب إعداد الحساب والخادم.',
              'Requires account and backend setup.'),
        ),
        const SizedBox(height: 15),
        PlanCard(
          title: t('اشتراك شهري', 'Monthly plan'),
          price: '\$2.99',
        ),
        PlanCard(
          title: t('اشتراك سنوي', 'Annual plan'),
          price: '\$29.99',
        ),
        const SizedBox(height: 12),
        Text(t(
          'الأسعار المعروضة مقترحة للمشروع. الشراء والتحقق من الاشتراك غير مفعّلين في هذه النسخة.',
          'These are intended prices. Purchasing and subscription verification are not enabled in this version.',
        )),
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  final bool isArabic;
  final ValueChanged<bool> onLanguageChanged;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  const SettingsPage({
    super.key,
    required this.isArabic,
    required this.onLanguageChanged,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    String t(String ar, String en) => isArabic ? ar : en;
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Text(t('الإعدادات', 'Settings'),
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
        SwitchListTile(
          title: Text(t('اللغة العربية', 'Arabic language')),
          subtitle: Text(t('إيقاف التبديل يعرض الإنجليزية',
              'Turn off to use English')),
          value: isArabic,
          onChanged: onLanguageChanged,
        ),
        SwitchListTile(
          title: Text(t('الوضع الداكن', 'Dark mode')),
          value: themeMode == ThemeMode.dark,
          onChanged: (value) => onThemeChanged(
            value ? ThemeMode.dark : ThemeMode.light,
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: Text(t('عن التطبيق', 'About')),
          subtitle: const Text('HAMOUDI CYBER LABS'),
          onTap: () => showInfo(context,
              'HAMOUDI CYBER LABS\nDigital safety and cybersecurity education.'),
        ),
        ListTile(
          leading: const Icon(Icons.support_agent),
          title: Text(t('الدعم الفني', 'Support')),
          onTap: () => showInfo(context, t(
            'قناة الدعم الفني غير مرتبطة بالخادم في هذه النسخة.',
            'Support service is not connected to a backend in this version.',
          )),
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip_outlined),
          title: Text(t('الخصوصية', 'Privacy')),
          onTap: () => showInfo(context, t(
            'لا تدخل كلمات مرورك أو بياناتك السرية في أي مكان غير موثوق.',
            'Never enter passwords or confidential information in untrusted places.',
          )),
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            'HAMOUDI CYBER LABS © 2026',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 11),
      child: ListTile(
        contentPadding: const EdgeInsets.all(13),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF00BFA5).withOpacity(0.15),
          child: Icon(icon, color: const Color(0xFF00BFA5)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(subtitle),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final String title;
  final String price;

  const PlanCard({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.workspace_premium, color: Color(0xFF00BFA5)),
        title: Text(title),
        trailing: Text(
          price,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

void showInfo(BuildContext context, String message) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
