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
        primaryColor: blue,
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

  void openPhotoShare() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const PhotoSharePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onPhotoShare: openPhotoShare),
      const ToolsPage(),
      const SubscriptionPage(),
      const AccountPage(),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: pages[selectedIndex],
        ),
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

class HomePage extends StatelessWidget {
  final VoidCallback onPhotoShare;

  const HomePage({
    super.key,
    required this.onPhotoShare,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SizedBox(height: 15),
        const Icon(
          Icons.shield,
          color: blue,
          size: 65,
        ),
        const SizedBox(height: 12),
        const Text(
          'HAMOUDI Cyber Security',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: white,
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
        const SizedBox(height: 28),
        const SectionTitle(title: 'الخدمات الرئيسية'),
        FeatureLine(
          icon: Icons.photo_library,
          title: 'مشاركة الصور',
          subtitle: 'اختر الصور وشاركها بموافقتك',
          onTap: onPhotoShare,
        ),
        const FeatureLine(
          icon: Icons.link,
          title: 'التوعية بالروابط',
          subtitle: 'تعرف على علامات الروابط المشبوهة',
        ),
        const FeatureLine(
          icon: Icons.lock,
          title: 'حماية كلمات المرور',
          subtitle: 'نصائح لإنشاء كلمات مرور قوية',
        ),
        const FeatureLine(
          icon: Icons.phone_android,
          title: 'أمان الهاتف',
          subtitle: 'إرشادات لحماية جهازك',
        ),
        const SizedBox(height: 22),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(Icons.verified_user, color: blue, size: 35),
                SizedBox(height: 8),
                Text(
                  'حافظ على أمانك الرقمي',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'لا تشارك معلوماتك الشخصية مع مصادر غير موثوقة.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: const [
        SectionTitle(title: 'أدوات التوعية الأمنية'),
        FeatureLine(
          icon: Icons.password,
          title: 'كلمات المرور',
          subtitle: 'استخدم كلمات مرور طويلة ومختلفة.',
        ),
        FeatureLine(
          icon: Icons.link,
          title: 'الروابط المشبوهة',
          subtitle: 'تحقق من عنوان الموقع قبل فتحه.',
        ),
        FeatureLine(
          icon: Icons.email,
          title: 'أمان البريد الإلكتروني',
          subtitle: 'احذر الرسائل التي تطلب بياناتك.',
        ),
        FeatureLine(
          icon: Icons.smartphone,
          title: 'حماية الهاتف',
          subtitle: 'حدّث نظام جهازك وتطبيقاتك باستمرار.',
        ),
        FeatureLine(
          icon: Icons.report,
          title: 'الإبلاغ عن المخاطر',
          subtitle: 'احتفظ بالأدلة وأبلغ الجهة المختصة.',
        ),
      ],
    );
  }
}

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: const [
        SectionTitle(title: 'خطط الاشتراك'),
        PlanCard(
          title: 'الخطة المجانية',
          price: '0 USD',
          description: 'ميزات أساسية محدودة.',
        ),
        PlanCard(
          title: 'الاشتراك الشهري',
          price: '4.99 USD',
          description: 'جميع الميزات والأدوات.',
        ),
        PlanCard(
          title: 'الاشتراك السنوي',
          price: '39.99 USD',
          description: 'جميع الميزات والأدوات لمدة سنة.',
        ),
        SizedBox(height: 15),
        Text(
          'ملاحظة: الخطط والأسعار معروضة حاليًا فقط. '
          'الشراء والتحقق من الاشتراكات لم يتم تفعيلهما بعد.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}

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
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: panel,
          title: const Text('تأكيد مشاركة الصور'),
          content: const Text(
            'هل توافق على اختيار الصور ومشاركتها؟ '
            'لن يتم اختيار الصور أو مشاركتها دون موافقتك.',
          ),
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
        );
      },
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
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مشاركة الصور'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.photo_library,
                color: blue,
                size: 75,
              ),
              const SizedBox(height: 20),
              const Text(
                'مشاركة الصور بأمان',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'بموافقتك يمكنك اختيار الصور التي تريد مشاركتها. '
                'لن يتم إرسال أي صورة دون اختيارك.',
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
          subtitle: 'نحترم خصوصيتك ولا نشارك صورك دون موافقتك.',
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

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 8),
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

  const FeatureLine({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
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
        trailing: onTap == null
            ? null
            : const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;

  const PlanCard({
    super.key,
    required this.title,
    required this.price,
    required this.description,
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
          ],
        ),
      ),
    );
  }
}