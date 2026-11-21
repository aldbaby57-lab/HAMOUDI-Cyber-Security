import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

void main() => runApp(const HamoudiApp());

const Color navy = Color(0xFF041329);
const Color panel = Color(0xFF0B2342);
const Color blue = Color(0xFF078BFF);

class HamoudiApp extends StatefulWidget {
  const HamoudiApp({super.key});

  @override
  State<HamoudiApp> createState() => _HamoudiAppState();
}

class _HamoudiAppState extends State<HamoudiApp> {
  ThemeMode themeMode = ThemeMode.dark;
  bool english = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HAMOUDI CYBER LABS',
      themeMode: themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: blue),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF3F6FA),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: blue,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: navy,
        appBarTheme: const AppBarTheme(backgroundColor: navy),
        cardTheme: CardThemeData(
          color: panel,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        useMaterial3: true,
      ),
      home: Directionality(
        textDirection: english ? TextDirection.ltr : TextDirection.rtl,
        child: MainShell(
          english: english,
          onLanguageChanged: (value) => setState(() => english = value),
          themeMode: themeMode,
          onThemeChanged: (value) => setState(() => themeMode = value),
        ),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  final bool english;
  final ValueChanged<bool> onLanguageChanged;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  const MainShell({
    super.key,
    required this.english,
    required this.onLanguageChanged,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  String t(String ar, String en) => widget.english ? en : ar;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(english: widget.english, onSelect: (i) => setState(() => index = i)),
      ToolsPage(english: widget.english),
      AcademyPage(english: widget.english),
      ProPage(english: widget.english),
      SettingsPage(
        english: widget.english,
        onLanguageChanged: widget.onLanguageChanged,
        themeMode: widget.themeMode,
        onThemeChanged: widget.onThemeChanged,
      ),
    ];

    return Scaffold(
      body: SafeArea(child: pages[index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home_outlined), label: t('الرئيسية', 'Home')),
          NavigationDestination(icon: const Icon(Icons.security), label: t('الأدوات', 'Tools')),
          NavigationDestination(icon: const Icon(Icons.school_outlined), label: t('الأكاديمية', 'Academy')),
          NavigationDestination(icon: const Icon(Icons.workspace_premium), label: t('PRO', 'PRO')),
          NavigationDestination(icon: const Icon(Icons.settings_outlined), label: t('الإعدادات', 'Settings')),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final bool english;
  final ValueChanged<int> onSelect;
  const HomePage({super.key, required this.english, required this.onSelect});

  String t(String ar, String en) => english ? en : ar;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SizedBox(height: 12),
        const Icon(Icons.shield_moon, color: blue, size: 72),
        const SizedBox(height: 10),
        Text('HAMOUDI CYBER LABS',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        Text(t('حماية ووعي وأمان رقمي', 'Digital safety, awareness and protection'),
            textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 22),
        const _InfoCard(
          icon: Icons.verified_user,
          title: 'Stay Cyber Safe',
          subtitle: 'تعلّم، افحص، واتخذ قرارات رقمية أكثر أمانًا.',
        ),
        const SizedBox(height: 18),
        Text(t('ابدأ من هنا', 'Get started'), style: Theme.of(context).textTheme.titleLarge),
        _FeatureTile(
          icon: Icons.link,
          title: t('فحص الروابط', 'Link checker'),
          subtitle: t('تحقق مبدئي من مؤشرات الخطر', 'Check for common warning signs'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LinkCheckerPage(english: english))),
        ),
        _FeatureTile(
          icon: Icons.password,
          title: t('قوة كلمة المرور', 'Password strength'),
          subtitle: t('تقييم محلي دون إرسال كلمة المرور', 'Local evaluation; password is not uploaded'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PasswordPage(english: english))),
        ),
        _FeatureTile(
          icon: Icons.phone_android,
          title: t('أمان الهاتف', 'Device security'),
          subtitle: t('قائمة خطوات عملية لحماية جهازك', 'A practical device-safety checklist'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DevicePage(english: english))),
        ),
        _FeatureTile(
          icon: Icons.school,
          title: t('أكاديمية HAMOUDI', 'HAMOUDI Academy'),
          subtitle: t('دروس قصيرة واختبارات توعوية', 'Short lessons and awareness quizzes'),
          onTap: () => onSelect(2),
        ),
      ],
    );
  }
}

class ToolsPage extends StatelessWidget {
  final bool english;
  const ToolsPage({super.key, required this.english});
  String t(String ar, String en) => english ? en : ar;

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(t('الأدوات الأمنية', 'Security tools'), style: Theme.of(context).textTheme.headlineSmall),
          _FeatureTile(
            icon: Icons.link,
            title: t('فحص الروابط', 'Link checker'),
            subtitle: t('فحص مبدئي داخل الجهاز', 'Basic on-device inspection'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LinkCheckerPage(english: english))),
          ),
          _FeatureTile(
            icon: Icons.password,
            title: t('قوة كلمات المرور', 'Password strength'),
            subtitle: t('لا تحفظ ولا ترسل كلمة المرور', 'Never stores or sends your password'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PasswordPage(english: english))),
          ),
          _FeatureTile(
            icon: Icons.phone_android,
            title: t('فحص إرشادي للهاتف', 'Device safety guide'),
            subtitle: t('إرشادات فقط؛ لا يدّعي فحص ملفات النظام', 'Guidance only; no system-file scanning claim'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DevicePage(english: english))),
          ),
          _FeatureTile(
            icon: Icons.image_outlined,
            title: t('مشاركة صورة', 'Share an image'),
            subtitle: t('اختر صورة وشاركها بموافقتك', 'Choose an image and share it yourself'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PhotoSharePage(english: english))),
          ),
          _FeatureTile(
            icon: Icons.smart_toy_outlined,
            title: 'HAMOUDI AI',
            subtitle: t('واجهة تجريبية؛ تحتاج ربط خدمة آمنة بالخادم', 'Demo screen; requires a secure backend integration'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AiInfoPage(english: english))),
          ),
        ],
      );
}

class LinkCheckerPage extends StatefulWidget {
  final bool english;
  const LinkCheckerPage({super.key, required this.english});
  @override
  State<LinkCheckerPage> createState() => _LinkCheckerPageState();
}

class _LinkCheckerPageState extends State<LinkCheckerPage> {
  final controller = TextEditingController();
  String result = '';
  Color resultColor = Colors.orange;
  final List<String> warnings = [];

  String t(String ar, String en) => widget.english ? en : ar;

  void check() {
    warnings.clear();
    final raw = controller.text.trim();
    final normalized = raw.contains('://') ? raw : 'https://$raw';
    final uri = Uri.tryParse(normalized);

    if (raw.isEmpty || uri == null || uri.host.isEmpty || !uri.hasAuthority) {
      setState(() {
        result = t('أدخل رابطًا صحيحًا.', 'Enter a valid URL.');
        resultColor = Colors.redAccent;
      });
      return;
    }

    final host = uri.host.toLowerCase();
    if (uri.scheme != 'https') warnings.add(t('الرابط لا يستخدم HTTPS.', 'The URL does not use HTTPS.'));
    if (uri.userInfo.isNotEmpty) warnings.add(t('العنوان يحتوي على بيانات مستخدم.', 'The address contains user-info fields.'));
    if (host.startsWith('xn--') || host.contains('.xn--')) {
      warnings.add(t('اسم النطاق يحتوي على ترميز دولي؛ تحقق من تهجئته.', 'The domain uses internationalized encoding; verify its spelling.'));
    }
    if (RegExp(r'^\d{1,3}(\.\d{1,3}){3}$').hasMatch(host)) {
      warnings.add(t('الرابط يستخدم عنوان IP مباشرة.', 'The URL uses a direct IP address.'));
    }
    if (host.split('.').length > 4) warnings.add(t('اسم النطاق يحتوي على نطاقات فرعية كثيرة.', 'The domain has many subdomains.'));
    if (host.contains('@')) warnings.add(t('تأكد من اسم النطاق الحقيقي.', 'Double-check the actual domain name.'));

    setState(() {
      result = warnings.isEmpty
          ? t('لم تظهر مؤشرات شائعة في هذا الفحص المبدئي.', 'No common warning signs were found in this basic check.')
          : t('ظهرت مؤشرات تستحق الانتباه:', 'Warning signs were found:');
      resultColor = warnings.isEmpty ? Colors.green : Colors.orange;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(t('فحص الروابط', 'Link checker'))),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            TextField(
              controller: controller,
              textDirection: TextDirection.ltr,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                labelText: t('أدخل الرابط', 'Enter URL'),
                hintText: 'https://example.com',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            FilledButton.icon(onPressed: check, icon: const Icon(Icons.search), label: Text(t('افحص الآن', 'Check now'))),
            if (result.isNotEmpty) ...[
              const SizedBox(height: 18),
              _InfoCard(icon: Icons.info_outline, title: result, subtitle: warnings.join('\n')),
              if (warnings.isNotEmpty)
                ...warnings.map((w) => ListTile(leading: const Icon(Icons.warning_amber, color: Colors.orange), title: Text(w))),
            ],
            const SizedBox(height: 14),
            _InfoCard(
              icon: Icons.shield_outlined,
              title: t('تنبيه مهم', 'Important note'),
              subtitle: t(
                'هذا فحص محلي مبدئي لشكل الرابط فقط. لا يتصل بقاعدة بيانات تهديدات ولا يضمن أن الموقع آمن. لا تفتح الروابط المشبوهة.',
                'This is a basic local URL check only. It does not query a threat-intelligence database or guarantee safety. Do not open suspicious links.',
              ),
            ),
          ],
        ),
      );
}

class PasswordPage extends StatefulWidget {
  final bool english;
  const PasswordPage({super.key, required this.english});
  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final controller = TextEditingController();
  bool obscure = true;
  String result = '';
  Color resultColor = Colors.orange;
  List<String> tips = [];
  String t(String ar, String en) => widget.english ? en : ar;

  void evaluate() {
    final value = controller.text;
    tips = [];
    if (value.isEmpty) {
      setState(() => result = t('أدخل كلمة مرور تجريبية.', 'Enter a sample password.'));
      return;
    }
    int score = 0;
    if (value.length >= 12) score++;
    if (value.length >= 16) score++;
    if (RegExp(r'[a-z]').hasMatch(value)) score++;
    if (RegExp(r'[A-Z]').hasMatch(value)) score++;
    if (RegExp(r'[0-9]').hasMatch(value)) score++;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(value)) score++;
    if (value.length < 12) tips.add(t('استخدم 12 حرفًا أو أكثر.', 'Use at least 12 characters.'));
    if (!RegExp(r'[a-z]').hasMatch(value)) tips.add(t('أضف أحرفًا صغيرة.', 'Add lowercase letters.'));
    if (!RegExp(r'[A-Z]').hasMatch(value)) tips.add(t('أضف أحرفًا كبيرة.', 'Add uppercase letters.'));
    if (!RegExp(r'[0-9]').hasMatch(value)) tips.add(t('أضف أرقامًا.', 'Add numbers.'));
    if (!RegExp(r'[^A-Za-z0-9]').hasMatch(value)) tips.add(t('أضف رموزًا خاصة.', 'Add special characters.'));
    setState(() {
      result = score <= 2 ? t('ضعيفة', 'Weak') : score <= 4 ? t('متوسطة', 'Moderate') : t('قوية مبدئيًا', 'Potentially strong');
      resultColor = score <= 2 ? Colors.redAccent : score <= 4 ? Colors.orange : Colors.green;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(t('قوة كلمة المرور', 'Password strength'))),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            TextField(
              controller: controller,
              obscureText: obscure,
              decoration: InputDecoration(
                labelText: t('كلمة مرور تجريبية', 'Sample password'),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => obscure = !obscure),
                ),
              ),
            ),
            const SizedBox(height: 14),
            FilledButton(onPressed: evaluate, child: Text(t('قيّم القوة', 'Evaluate strength'))),
            if (result.isNotEmpty) ...[
              const SizedBox(height: 18),
              Text('${t('النتيجة:', 'Result:')} $result',
                  style: TextStyle(color: resultColor, fontSize: 20, fontWeight: FontWeight.bold)),
              ...tips.map((tip) => ListTile(leading: const Icon(Icons.lightbulb_outline), title: Text(tip))),
            ],
            _InfoCard(
              icon: Icons.lock_outline,
              title: t('خصوصيتك', 'Your privacy'),
              subtitle: t(
                'التقييم يتم داخل التطبيق ولا تُرسل كلمة المرور إلى الخادم. لا تستخدم كلمة مرورك الحقيقية في أي أداة اختبار.',
                'Evaluation happens locally; the password is not sent to a server. Do not enter your real password into test tools.',
              ),
            ),
          ],
        ),
      );
}

class DevicePage extends StatefulWidget {
  final bool english;
  const DevicePage({super.key, required this.english});
  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  final checked = <bool>[false, false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    final items = widget.english
        ? ['Install system updates', 'Use a screen lock', 'Enable two-factor authentication', 'Review app permissions', 'Install apps from trusted stores', 'Back up important data']
        : ['حدّث نظام الهاتف باستمرار', 'استخدم قفل شاشة قويًا', 'فعّل المصادقة الثنائية', 'راجع أذونات التطبيقات', 'نزّل التطبيقات من المتاجر الموثوقة', 'احتفظ بنسخة احتياطية'];
    final done = checked.where((v) => v).length;
    return Scaffold(
      appBar: AppBar(title: Text(widget.english ? 'Device security' : 'أمان الهاتف')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(widget.english ? '$done / ${items.length} completed' : '$done من ${items.length} خطوات مكتملة',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: done / items.length),
          const SizedBox(height: 12),
          ...List.generate(items.length, (i) => CheckboxListTile(
                value: checked[i],
                onChanged: (v) => setState(() => checked[i] = v ?? false),
                title: Text(items[i]),
              )),
          _InfoCard(
            icon: Icons.info_outline,
            title: widget.english ? 'Platform limitation' : 'حدود الفحص',
            subtitle: widget.english
                ? 'This checklist provides guidance. iOS and Android restrict apps from inspecting many other apps or all system security settings.'
                : 'هذه قائمة إرشادية. أنظمة iOS وAndroid تمنع التطبيقات من فحص كثير من التطبيقات الأخرى أو جميع إعدادات النظام.',
          ),
        ],
      ),
    );
  }
}

class AcademyPage extends StatelessWidget {
  final bool english;
  const AcademyPage({super.key, required this.english});

  @override
  Widget build(BuildContext context) {
    final lessons = english
        ? [
            ('Phishing awareness', 'Recognize suspicious messages and links.'),
            ('Account protection', 'Use unique passwords and two-factor authentication.'),
            ('Public Wi-Fi safety', 'Avoid sensitive activity on untrusted networks.'),
            ('Privacy basics', 'Limit app permissions and personal information sharing.'),
          ]
        : [
            ('التوعية بالتصيد', 'تعرّف على الرسائل والروابط المشبوهة.'),
            ('حماية الحسابات', 'استخدم كلمات مرور فريدة والمصادقة الثنائية.'),
            ('أمان شبكات Wi-Fi العامة', 'تجنب الأنشطة الحساسة على الشبكات غير الموثوقة.'),
            ('أساسيات الخصوصية', 'قلّل أذونات التطبيقات ومشاركة بياناتك.'),
          ];
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Text(english ? 'HAMOUDI ACADEMY' : 'أكاديمية HAMOUDI',
            style: Theme.of(context).textTheme.headlineSmall),
        Text(english ? 'Cybersecurity learning bites' : 'تعلم الأمن السيبراني بخطوات بسيطة'),
        const SizedBox(height: 12),
        ...lessons.map((lesson) => Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.school)),
                title: Text(lesson.$1),
                subtitle: Text(lesson.$2),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(lesson.$1),
                    content: Text(lesson.$2),
                    actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(english ? 'Close' : 'إغلاق'))],
                  ),
                ),
              ),
            )),
        const _InfoCard(
          icon: Icons.workspace_premium,
          title: 'Learning content',
          subtitle: 'المحتوى الحالي توعوي تجريبي. الشهادات والنقاط ولوحة المتصدرين تحتاج قاعدة بيانات وحسابات موثقة.',
        ),
      ],
    );
  }
}

class ProPage extends StatelessWidget {
  final bool english;
  const ProPage({super.key, required this.english});

  @override
  Widget build(BuildContext context) {
    final benefits = english
        ? ['Advanced link reputation checks', 'Scan history and security reports', 'HAMOUDI AI assistant', 'Image and screenshot analysis', 'Priority security alerts']
        : ['فحص متقدم لسمعة الروابط', 'سجل الفحوصات والتقارير الأمنية', 'مساعد HAMOUDI AI', 'تحليل الصور ولقطات الشاشة', 'تنبيهات أمنية إضافية'];
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Icon(Icons.workspace_premium, color: blue, size: 64),
        const SizedBox(height: 8),
        const Text('HAMOUDI PRO', textAlign: TextAlign.center, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        Text(english ? 'More tools for your digital safety' : 'مزايا إضافية لأمانك الرقمي', textAlign: TextAlign.center),
        const SizedBox(height: 18),
        ...benefits.map((b) => ListTile(leading: const Icon(Icons.check_circle_outline, color: blue), title: Text(b))),
        const SizedBox(height: 12),
        _PlanCard(title: english ? 'Monthly' : 'اشتراك شهري', price: '\$2.99', description: english ? 'Billed monthly' : 'لمدة شهر'),
        _PlanCard(title: english ? 'Yearly' : 'اشتراك سنوي', price: '\$29.99', description: english ? 'Billed yearly' : 'لمدة سنة'),
        const _InfoCard(
          icon: Icons.info_outline,
          title: 'الاشتراكات غير مفعّلة بعد',
          subtitle: 'الأسعار معروضة حسب الخطة المقترحة فقط. لا يوجد شراء أو تفعيل PRO حقيقي قبل إعداد منتجات Google Play وApple والتحقق من الإيصالات عبر الخادم.',
        ),
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  final bool english;
  final ValueChanged<bool> onLanguageChanged;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  const SettingsPage({
    super.key,
    required this.english,
    required this.onLanguageChanged,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text(english ? 'Settings' : 'الإعدادات', style: Theme.of(context).textTheme.headlineSmall),
          SwitchListTile(
            value: english,
            onChanged: onLanguageChanged,
            title: Text(english ? 'English language' : 'اللغة الإنجليزية'),
            subtitle: Text(english ? 'Turn off for Arabic' : 'فعّل للتبديل إلى الإنجليزية'),
          ),
          SwitchListTile(
            value: themeMode == ThemeMode.dark,
            onChanged: (v) => onThemeChanged(v ? ThemeMode.dark : ThemeMode.light),
            title: Text(english ? 'Dark mode' : 'الوضع الداكن'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.admin_panel_settings),
            title: const Text('HAMOUDI ADMIN'),
            subtitle: Text(english ? 'Admin access requires secure server-side authentication.' : 'لوحة الإدارة تحتاج تسجيل دخول وصلاحيات يتحقق منها الخادم.'),
          ),
          ListTile(
            leading: const Icon(Icons.support_agent),
            title: Text(english ? 'Support and feedback' : 'الدعم والملاحظات'),
            subtitle: Text(english ? 'Support system is not connected yet.' : 'نظام الدعم لم يتم ربطه بعد.'),
          ),
          const _InfoCard(
            icon: Icons.privacy_tip_outlined,
            title: 'HAMOUDI CYBER LABS',
            subtitle: 'نسخة تأسيسية للواجهة. الحسابات والمزامنة والإشعارات ولوحة الإدارة والدعم والذكاء الاصطناعي والدفع تحتاج خدمات خلفية آمنة قبل إطلاقها.',
          ),
        ],
      );
}

class AiInfoPage extends StatelessWidget {
  final bool english;
  const AiInfoPage({super.key, required this.english});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('HAMOUDI AI')),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: _InfoCard(
            icon: Icons.smart_toy_outlined,
            title: english ? 'AI assistant is not connected' : 'مساعد HAMOUDI AI غير متصل بعد',
            subtitle: english
                ? 'A secure backend, authentication, usage limits and a trusted AI provider must be configured before enabling chat or image analysis.'
                : 'يلزم إعداد خادم آمن وتسجيل دخول وحدود استخدام وربط مزود ذكاء اصطناعي موثوق قبل تشغيل المحادثة أو تحليل الصور.',
          ),
        ),
      );
}

class PhotoSharePage extends StatefulWidget {
  final bool english;
  const PhotoSharePage({super.key, required this.english});
  @override
  State<PhotoSharePage> createState() => _PhotoSharePageState();
}

class _PhotoSharePageState extends State<PhotoSharePage> {
  XFile? image;
  bool busy = false;

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 90);
    if (picked != null && mounted) setState(() => image = picked);
  }

  Future<void> shareImage() async {
    if (image == null) return;
    setState(() => busy = true);
    try {
      await Share.shareXFiles([XFile(image!.path)], text: 'Shared with HAMOUDI CYBER LABS');
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(widget.english ? 'Share an image' : 'مشاركة صورة')),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              if (image != null)
                Expanded(child: Image.file(
                  File(image!.path),
                  errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 90),
                ))
              else
                const Expanded(child: Center(child: Icon(Icons.add_photo_alternate, size: 90))),
              FilledButton.icon(onPressed: pickImage, icon: const Icon(Icons.photo), label: Text(widget.english ? 'Choose image' : 'اختر صورة')),
              const SizedBox(height: 10),
              FilledButton.icon(
                onPressed: image == null || busy ? null : shareImage,
                icon: const Icon(Icons.share),
                label: Text(widget.english ? 'Share selected image' : 'شارك الصورة المختارة'),
              ),
            ],
          ),
        ),
      );
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _InfoCard({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: blue, size: 28),
              const SizedBox(width: 12),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                ],
              )),
            ],
          ),
        ),
      );
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _FeatureTile({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          leading: Icon(icon, color: blue, size: 28),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      );
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  const _PlanCard({required this.title, required this.price, required this.description});

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(price, style: const TextStyle(color: blue, fontWeight: FontWeight.bold, fontSize: 28)),
              Text(description),
              const SizedBox(height: 8),
              const Text('قريبًا — الشراء غير متاح حاليًا', style: TextStyle(color: Colors.orange)),
            ],
          ),
        ),
      );
}
