
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const HamoudiApp());
}

const Color navy = Color(0xFF041329);
const Color panel = Color(0xFF0B2342);
const Color blue = Color(0xFF078BFF);
const Color white = Colors.white;

class HamoudiApp extends StatelessWidget {
  const HamoudiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HAMOUDI Cyber Security',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: navy,
        colorScheme: ColorScheme.fromSeed(
          seedColor: blue,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: navy,
          foregroundColor: white,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          color: panel,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selectedIndex = 0;

  // لا تجعلها true يدويًا.
  // تفعيل PRO الحقيقي يحتاج التحقق من المتجر.
  final bool isPro = false;

  void openPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void openProFeature(String feature) {
    if (isPro) {
      if (feature == 'مشاركة الصور') {
        openPage(const PhotoSharePage());
      } else if (feature == 'التقارير الأمنية') {
        openPage(const ReportsPage());
      } else if (feature == 'سجل الفحوصات') {
        openPage(const HistoryPage());
      } else if (feature == 'التنبيهات') {
        openPage(const AlertsPage());
      }
    } else {
      openPage(SubscriptionPage(isPro: isPro));
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        onOpen: openPage,
        onProFeature: openProFeature,
        isPro: isPro,
      ),
      ToolsPage(
        onOpen: openPage,
        onProFeature: openProFeature,
        isPro: isPro,
      ),
      SubscriptionPage(isPro: isPro),
      const AccountPage(),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(child: pages[selectedIndex]),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() => selectedIndex = index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: panel,
          selectedItemColor: blue,
          unselectedItemColor: Colors.white60,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.security),
              label: 'الأدوات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.workspace_premium),
              label: 'الاشتراك',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'حسابي',
            ),
          ],
        ),
      ),
    );
  }
}

// الصفحة الرئيسية

class HomePage extends StatelessWidget {
  final void Function(Widget) onOpen;
  final void Function(String) onProFeature;
  final bool isPro;

  const HomePage({
    super.key,
    required this.onOpen,
    required this.onProFeature,
    required this.isPro,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SizedBox(height: 15),
        const Icon(Icons.shield, color: blue, size: 65),
        const SizedBox(height: 12),
        const Text(
          'HAMOUDI Cyber Security',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'حماية ووعي وأمان رقمي',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 12),
        Center(
          child: Chip(
            avatar: Icon(
              isPro ? Icons.workspace_premium : Icons.person,
              color: blue,
            ),
            label: Text(isPro ? 'HAMOUDI PRO' : 'الخطة المجانية'),
            backgroundColor: panel,
          ),
        ),
        const SizedBox(height: 22),
        const SectionTitle(title: 'الأدوات الأساسية'),
        FeatureLine(
          icon: Icons.link,
          title: 'فحص الروابط',
          subtitle: 'فحص مبدئي لعلامات الروابط المشبوهة',
          onTap: () => onOpen(const LinkCheckerPage()),
        ),
        FeatureLine(
          icon: Icons.lock,
          title: 'قوة كلمات المرور',
          subtitle: 'تقييم محلي لكلمة المرور',
          onTap: () => onOpen(const PasswordPage()),
        ),
        FeatureLine(
          icon: Icons.phone_android,
          title: 'أمان الهاتف',
          subtitle: 'إرشادات لحماية جهازك',
          onTap: () => onOpen(const PhoneSecurityPage()),
        ),
        const SectionTitle(title: 'ميزات HAMOUDI PRO'),
        FeatureLine(
          icon: Icons.photo_library,
          title: 'مشاركة الصور',
          subtitle: 'مشاركة الصور باختيارك',
          locked: !isPro,
          onTap: () => onProFeature('مشاركة الصور'),
        ),
        FeatureLine(
          icon: Icons.analytics,
          title: 'التقارير الأمنية',
          subtitle: 'تقارير ونتائج الفحوصات',
          locked: !isPro,
          onTap: () => onProFeature('التقارير الأمنية'),
        ),
        FeatureLine(
          icon: Icons.history,
          title: 'سجل الفحوصات',
          subtitle: 'متابعة الفحوصات السابقة',
          locked: !isPro,
          onTap: () => onProFeature('سجل الفحوصات'),
        ),
        FeatureLine(
          icon: Icons.notifications_active,
          title: 'التنبيهات الأمنية',
          subtitle: 'توعية وتنبيهات أمنية',
          locked: !isPro,
          onTap: () => onProFeature('التنبيهات'),
        ),
        const SizedBox(height: 15),
        const InfoCard(
          icon: Icons.verified_user,
          title: 'حافظ على أمانك الرقمي',
          description:
              'لا تشارك معلوماتك الشخصية مع مصادر غير موثوقة.',
        ),
      ],
    );
  }
}

// صفحة الأدوات

class ToolsPage extends StatelessWidget {
  final void Function(Widget) onOpen;
  final void Function(String) onProFeature;
  final bool isPro;

  const ToolsPage({
    super.key,
    required this.onOpen,
    required this.onProFeature,
    required this.isPro,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SectionTitle(title: 'أدوات التوعية الأمنية'),
        FeatureLine(
          icon: Icons.link,
          title: 'فحص الروابط',
          subtitle: 'تحليل مبدئي لعنوان الموقع',
          onTap: () => onOpen(const LinkCheckerPage()),
        ),
        FeatureLine(
          icon: Icons.password,
          title: 'قوة كلمات المرور',
          subtitle: 'تقييم كلمة المرور محليًا',
          onTap: () => onOpen(const PasswordPage()),
        ),
        FeatureLine(
          icon: Icons.phone_android,
          title: 'حماية الهاتف',
          subtitle: 'قائمة خطوات الأمان',
          onTap: () => onOpen(const PhoneSecurityPage()),
        ),
        const SectionTitle(title: 'أدوات PRO'),
        FeatureLine(
          icon: Icons.photo_library,
          title: 'مشاركة الصور',
          subtitle: 'مشاركة الصور باختيار المستخدم',
          locked: !isPro,
          onTap: () => onProFeature('مشاركة الصور'),
        ),
        FeatureLine(
          icon: Icons.analytics,
          title: 'التقارير الأمنية',
          subtitle: 'تقارير الفحوصات',
          locked: !isPro,
          onTap: () => onProFeature('التقارير الأمنية'),
        ),
        FeatureLine(
          icon: Icons.history,
          title: 'سجل الفحوصات',
          subtitle: 'الرجوع إلى النتائج السابقة',
          locked: !isPro,
          onTap: () => onProFeature('سجل الفحوصات'),
        ),
        FeatureLine(
          icon: Icons.notifications,
          title: 'التنبيهات',
          subtitle: 'التوعية بالمخاطر الرقمية',
          locked: !isPro,
          onTap: () => onProFeature('التنبيهات'),
        ),
      ],
    );
  }
}

// صفحة الاشتراكات

class SubscriptionPage extends StatelessWidget {
  final bool isPro;

  const SubscriptionPage({super.key, required this.isPro});

  void showNotActive(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'الشراء الإلكتروني لم يتم تفعيله بعد. سيتم تفعيله بعد إعداد المتجر.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Icon(
          Icons.workspace_premium,
          color: blue,
          size: 65,
        ),
        const SizedBox(height: 12),
        const Text(
          'HAMOUDI PRO',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'ارتقِ بحمايتك الرقمية',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 20),
        if (isPro)
          const InfoCard(
            icon: Icons.verified,
            title: 'أنت مشترك في PRO',
            description: 'حالة العرض فقط؛ يجب التحقق من اشتراك المتجر.',
          ),
        const SectionTitle(title: 'مميزات PRO'),
        const BenefitLine(
          icon: Icons.link,
          title: 'فحص روابط متقدم',
          subtitle: 'تحليل إضافي باستخدام خدمات موثوقة عند ربطها.',
        ),
        const BenefitLine(
          icon: Icons.history,
          title: 'سجل الفحوصات',
          subtitle: 'الاحتفاظ بنتائج الفحوصات ومراجعتها.',
        ),
        const BenefitLine(
          icon: Icons.analytics,
          title: 'تقارير أمنية',
          subtitle: 'عرض النتائج في تقارير واضحة.',
        ),
        const BenefitLine(
          icon: Icons.lock,
          title: 'أدوات كلمات المرور',
          subtitle: 'تقييم محلي ونصائح إضافية.',
        ),
        const BenefitLine(
          icon: Icons.photo_library,
          title: 'مشاركة الصور',
          subtitle: 'اختيار الصور ومشاركتها بنفسك.',
        ),
        const BenefitLine(
          icon: Icons.notifications_active,
          title: 'التنبيهات الأمنية',
          subtitle: 'معلومات توعوية عن المخاطر الرقمية.',
        ),
        const SizedBox(height: 15),
        PlanCard(
          title: 'الخطة المجانية',
          price: '0 USD',
          description: 'الأدوات الأساسية للتوعية والحماية.',
          buttonText: 'الخطة الحالية',
          onPressed: null,
        ),
        PlanCard(
          title: 'HAMOUDI PRO الشهري',
          price: '4.99 USD',
          description: 'جميع الميزات المدفوعة لمدة شهر.',
          buttonText: 'الاشتراك الشهري',
          onPressed: () => showNotActive(context),
        ),
        PlanCard(
          title: 'HAMOUDI PRO السنوي',
          price: '39.99 USD',
          description: 'جميع الميزات المدفوعة لمدة سنة.',
          buttonText: 'الاشتراك السنوي',
          onPressed: () => showNotActive(context),
        ),
        const SizedBox(height: 12),
        const Text(
          'ملاحظة: الأسعار والميزات معروضة حاليًا. '
          'الدفع والتحقق من الاشتراكات لم يتم تفعليهما بعد.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}

// فحص الروابط

class LinkCheckerPage extends StatefulWidget {
  const LinkCheckerPage({super.key});

  @override
  State<LinkCheckerPage> createState() => _LinkCheckerPageState();
}

class _LinkCheckerPageState extends State<LinkCheckerPage> {
  final controller = TextEditingController();
  String result = '';
  Color resultColor = Colors.white70;
  List<String> warnings = [];

  void checkLink() {
    final input = controller.text.trim();
    warnings = [];

    if (input.isEmpty) {
      setState(() {
        result = 'أدخل رابطًا أولًا.';
        resultColor = Colors.orange;
      });
      return;
    }

    final uri = Uri.tryParse(input);

    if (uri == null || !uri.hasAuthority || uri.host.isEmpty) {
      setState(() {
        result = 'صيغة الرابط غير صحيحة.';
        resultColor = Colors.redAccent;
      });
      return;
    }

    if (uri.scheme != 'https') {
      warnings.add('الرابط لا يستخدم HTTPS.');
    }

    if (uri.userInfo.isNotEmpty) {
      warnings.add('الرابط يحتوي على بيانات مستخدم داخل العنوان.');
    }

    if (uri.host.startsWith('xn--') || uri.host.contains('.xn--')) {
      warnings.add('اسم النطاق يستخدم صيغة دولية قد تكون مضللة.');
    }

    if (RegExp(r'^\d{1,3}(\.\d{1,3}){3}$').hasMatch(uri.host)) {
      warnings.add('الرابط يستخدم عنوان IP بدل اسم نطاق واضح.');
    }

    if (uri.host.split('.').length > 4) {
      warnings.add('اسم الموقع يحتوي على نطاقات فرعية كثيرة.');
    }

    setState(() {
      if (warnings.isEmpty) {
        result = 'لم تظهر علامات اشتباه واضحة في الفحص المبدئي.';
        resultColor = Colors.green;
      } else {
        result = 'انتبه! ظهرت علامات تستحق التحقق.';
        resultColor = Colors.orange;
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('فحص الروابط')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Icon(Icons.link, color: blue, size: 65),
          const SizedBox(height: 15),
          const Text(
            'تحقق من الرابط قبل فتحه',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller,
            textDirection: TextDirection.ltr,
            decoration: const InputDecoration(
              hintText: 'https://example.com',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: checkLink,
            child: const Text('افحص الرابط'),
          ),
          const SizedBox(height: 20),
          if (result.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result,
                      style: TextStyle(
                        color: resultColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...warnings.map((warning) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text('• $warning'),
                        )),
                  ],
                ),
              ),
            ),
          const InfoCard(
            icon: Icons.info_outline,
            title: 'تنبيه',
            description:
                'هذا فحص مبدئي لشكل الرابط فقط، ولا يؤكد أن الموقع آمن أو خالٍ من البرمجيات الضارة.',
          ),
        ],
      ),
    );
  }
}

// تقييم كلمات المرور

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final controller = TextEditingController();
  bool hidden = true;
  String strength = '';
  Color strengthColor = Colors.white70;
  List<String> tips = [];

  void evaluatePassword() {
    final password = controller.text;
    tips = [];

    if (password.isEmpty) {
      setState(() {
        strength = 'أدخل كلمة مرور تجريبية.';
        strengthColor = Colors.orange;
      });
      return;
    }

    int score = 0;

    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[a-z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(password)) score++;

    if (password.length < 12) {
      tips.add('استخدم 12 حرفًا أو أكثر.');
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      tips.add('أضف حرفًا إنجليزيًا كبيرًا.');
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      tips.add('أضف حرفًا إنجليزيًا صغيرًا.');
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      tips.add('أضف رقمًا.');
    }
    if (!RegExp(r'[^A-Za-z0-9]').hasMatch(password)) {
      tips.add('أضف رمزًا خاصًا.');
    }

    setState(() {
      if (score <= 2) {
        strength = 'ضعيفة';
        strengthColor = Colors.redAccent;
      } else if (score <= 4) {
        strength = 'متوسطة';
        strengthColor = Colors.orange;
      } else {
        strength = 'قوية مبدئيًا';
        strengthColor = Colors.green;
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('قوة كلمات المرور')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Icon(Icons.lock, color: blue, size: 65),
          const SizedBox(height: 15),
          const Text(
            'اختبر قوة كلمة المرور',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller,
            obscureText: hidden,
            decoration: InputDecoration(
              hintText: 'اكتب كلمة مرور تجريبية',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(hidden ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => hidden = !hidden),
              ),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: evaluatePassword,
            child: const Text('تقييم كلمة المرور'),
          ),
          const SizedBox(height: 20),
          if (strength.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('نتيجة التقييم'),
                    const SizedBox(height: 8),
                    Text(
                      strength,
                      style: TextStyle(
                        color: strengthColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...tips.map((tip) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text('• $tip'),
                        )),
                    if (tips.isEmpty)
                      const Text('كلمة المرور تستوفي المعايير الأساسية.'),
                  ],
                ),
              ),
            ),
          const InfoCard(
            icon: Icons.privacy_tip,
            title: 'خصوصيتك مهمة',
            description:
                'التقييم محلي ولا يرسل كلمة المرور للإنترنت. استخدم كلمة تجريبية ولا تدخل كلمة مرور حسابك الحقيقية.',
          ),
        ],
      ),
    );
  }
}

// أمان الهاتف

class PhoneSecurityPage extends StatefulWidget {
  const PhoneSecurityPage({super.key});

  @override
  State<PhoneSecurityPage> createState() => _PhoneSecurityPageState();
}

class _PhoneSecurityPageState extends State<PhoneSecurityPage> {
  final items = [
    'تحديث نظام الهاتف.',
    'تحديث التطبيقات من المتجر الرسمي.',
    'استخدام قفل شاشة قوي.',
    'تفعيل المصادقة الثنائية.',
    'تجنب التطبيقات من المصادر المجهولة.',
    'مراجعة أذونات التطبيقات.',
    'تجنب الروابط والمرفقات المشبوهة.',
    'الاحتفاظ بنسخة احتياطية.',
    'تفعيل العثور على الهاتف.',
  ];

  final Set<int> completed = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('أمان الهاتف')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Icon(Icons.phone_android, color: blue, size: 65),
          const SizedBox(height: 12),
          const Text(
            'قائمة حماية جهازك',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'أنجزت ${completed.length} من ${items.length} خطوات',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          LinearProgressIndicator(
            value: completed.length / items.length,
            color: blue,
            backgroundColor: panel,
          ),
          const SizedBox(height: 20),
          ...List.generate(items.length, (index) {
            return Card(
              child: CheckboxListTile(
                value: completed.contains(index),
                activeColor: blue,
                title: Text(items[index]),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      completed.add(index);
                    } else {
                      completed.remove(index);
                    }
                  });
                },
              ),
            );
          }),
          const InfoCard(
            icon: Icons.info_outline,
            title: 'معلومة مهمة',
            description:
                'هذه قائمة إرشادية وليست فحصًا تلقائيًا للهاتف.',
          ),
        ],
      ),
    );
  }
}

// مشاركة الصور - ميزة PRO

class PhotoSharePage extends StatefulWidget {
  const PhotoSharePage({super.key});

  @override
  State<PhotoSharePage> createState() => _PhotoSharePageState();
}

class _PhotoSharePageState extends State<PhotoSharePage> {
  final ImagePicker picker = ImagePicker();
  bool loading = false;
  List<XFile> selectedImages = [];

  Future<void> startSharing() async {
    final consent = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: panel,
        title: const Text('تأكيد مشاركة الصور'),
        content: const Text('هل توافق على اختيار الصور ومشاركتها؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('لا'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('نعم'),
          ),
        ],
      ),
    );

    if (consent != true || !mounted) return;

    setState(() => loading = true);

    try {
      final images = await picker.pickMultiImage();

      if (!mounted) return;

      if (images.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لم يتم اختيار أي صورة')),
        );
        return;
      }

      setState(() => selectedImages = images);

      await Share.shareXFiles(
        images,
        text: 'مشاركة الصور عبر HAMOUDI Cyber Security',
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e')),
      );
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مشاركة الصور')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.photo_library, color: blue, size: 75),
              const SizedBox(height: 20),
              const Text(
                'مشاركة الصور بأمان',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'اختر الصور التي تريد مشاركتها بنفسك.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 25),
              if (selectedImages.isNotEmpty)
                Text('عدد الصور المختارة: ${selectedImages.length}'),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: loading ? null : startSharing,
                  icon: const Icon(Icons.share),
                  label: Text(
                    loading ? 'يرجى الانتظار...' : 'بدء المشاركة',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    foregroundColor: white,
                    padding: const EdgeInsets.all(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// التقارير الأمنية - واجهة أولية

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التقارير الأمنية')),
      body: const Padding(
        padding: EdgeInsets.all(18),
        child: InfoCard(
          icon: Icons.analytics,
          title: 'التقارير الأمنية',
          description:
              'ستظهر هنا التقارير بعد ربط أدوات الفحص المتقدمة وتخزين نتائجها.',
        ),
      ),
    );
  }
}

// سجل الفحوصات - واجهة أولية

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سجل الفحوصات')),
      body: const Padding(
        padding: EdgeInsets.all(18),
        child: InfoCard(
          icon: Icons.history,
          title: 'سجل الفحوصات',
          description:
              'سيتم عرض نتائج الفحوصات السابقة هنا بعد تنفيذ نظام حفظ السجل.',
        ),
      ),
    );
  }
}

// التنبيهات - واجهة أولية

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التنبيهات الأمنية')),
      body: const Padding(
        padding: EdgeInsets.all(18),
        child: InfoCard(
          icon: Icons.notifications_active,
          title: 'التنبيهات الأمنية',
          description:
              'سيتم إضافة التنبيهات التوعوية بعد ربط خدمة التنبيهات.',
        ),
      ),
    );
  }
}

// الحساب

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: const [
        SizedBox(height: 25),
        Icon(Icons.account_circle, color: blue, size: 80),
        SizedBox(height: 12),
        Text(
          'حسابي',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 25),
        FeatureLine(
          icon: Icons.person,
          title: 'المطور',
          subtitle: 'محمد صادق عبده',
        ),
        FeatureLine(
          icon: Icons.security,
          title: 'سياسة الخصوصية',
          subtitle: 'نحترم خصوصيتك وخصوصية بياناتك.',
        ),
        FeatureLine(
          icon: Icons.info,
          title: 'حول التطبيق',
          subtitle: 'HAMOUDI Cyber Security',
        ),
      ],
    );
  }
}

// عناصر التصميم

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 18),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: blue,
        ),
      ),
    );
  }
}

class FeatureLine extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool locked;

  const FeatureLine({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.locked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: blue, size: 30),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: locked
            ? const Icon(Icons.lock, color: Colors.orange)
            : (onTap == null
                ? null
                : const Icon(Icons.arrow_forward_ios, size: 16)),
      ),
    );
  }
}

class BenefitLine extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const BenefitLine({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: blue),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: blue, size: 35),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final String buttonText;
  final VoidCallback? onPressed;

  const PlanCard({
    super.key,
    required this.title,
    required this.price,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              price,
              style: const TextStyle(
                color: blue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  foregroundColor: white,
                ),
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
