
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

  final List<Widget> pages = const [
    HomePage(),
    ToolsPage(),
    SubscriptionPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: panel,
        indicatorColor: blue.withOpacity(0.25),
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(Icons.security_outlined),
            selectedIcon: Icon(Icons.security),
            label: 'الأدوات',
          ),
          NavigationDestination(
            icon: Icon(Icons.workspace_premium_outlined),
            selectedIcon: Icon(Icons.workspace_premium),
            label: 'الاشتراك',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HAMOUDI Cyber Security',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0756A5), panel],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.shield, size: 55, color: white),
                SizedBox(height: 18),
                Text(
                  'مرحباً بك في HAMOUDI',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'منصتك للتوعية والحماية في عالم الأمن السيبراني',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'خدمات التطبيق',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const FeatureTile(
            icon: Icons.lock_outline,
            title: 'التوعية الأمنية',
            subtitle: 'تعلم أساسيات حماية حساباتك وبياناتك',
          ),
          const FeatureTile(
            icon: Icons.phishing_outlined,
            title: 'التوعية بالتصيد',
            subtitle: 'تعرف على الروابط والرسائل المشبوهة',
          ),
          const FeatureTile(
            icon: Icons.security,
            title: 'أدوات الحماية',
            subtitle: 'أدوات تعليمية لمساعدتك على حماية نفسك',
          ),
          const FeatureTile(
            icon: Icons.photo_library_outlined,
            title: 'مشاركة الصور',
            subtitle: 'مشاركة الصور بموافقة واختيار المستخدم',
          ),
        ],
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const FeatureTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: panel,
      child: ListTile(
        leading: Icon(icon, color: blue, size: 30),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('أدوات الحماية')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          FeatureTile(
            icon: Icons.password,
            title: 'كلمات المرور',
            subtitle: 'نصائح لإنشاء كلمة مرور قوية',
          ),
          FeatureTile(
            icon: Icons.link,
            title: 'فحص الروابط',
            subtitle: 'تعرف على علامات الروابط المشبوهة',
          ),
          FeatureTile(
            icon: Icons.phonelink_lock,
            title: 'حماية الهاتف',
            subtitle: 'إرشادات لتأمين جهازك',
          ),
          FeatureTile(
            icon: Icons.email_outlined,
            title: 'حماية البريد',
            subtitle: 'تعلم اكتشاف رسائل الاحتيال',
          ),
          FeatureTile(
            icon: Icons.history,
            title: 'التقارير',
            subtitle: 'سجل الأنشطة سيضاف في تحديث قادم',
          ),
        ],
      ),
    );
  }
}

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  Widget plan(
    String title,
    String price,
    String description,
    bool featured,
  ) {
    return Card(
      color: featured ? const Color(0xFF103D69) : panel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: featured ? blue : Colors.transparent,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              price,
              style: const TextStyle(
                fontSize: 27,
                color: blue,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('خطط الاشتراك')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          plan(
            'الخطة المجانية',
            '0 USD',
            'الوصول إلى الخدمات الأساسية المحدودة.',
            false,
          ),
          plan(
            'الاشتراك الشهري',
            '4.99 USD',
            'الخطة المدفوعة وجميع الميزات بعد تفعيل الدفع.',
            true,
          ),
          plan(
            'الاشتراك السنوي',
            '39.99 USD',
            'الخطة المدفوعة وجميع الميزات بعد تفعيل الدفع.',
            false,
          ),
          const SizedBox(height: 12),
          const Text(
            'ملاحظة: هذه الأسعار للعرض فقط. الشراء والتحقق من اشتراكات المتاجر لم يتم تفعليهما بعد.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.orangeAccent),
          ),
        ],
      ),
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

  Future<void> sharePhotos() async {
    final consent = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: panel,
        title: const Text('موافقة مشاركة الصور'),
        content: const Text(
          'هل توافق على اختيار صور من جهازك ومشاركتها؟ '
          'لن يتم اختيار الصور أو إرسالها دون موافقتك.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('لا'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('نعم، أوافق'),
          ),
        ],
      ),
    );

    if (consent != true || !mounted) {
      return;
    }

    setState(() => loading = true);

    try {
      final photos = await picker.pickMultiImage();

      if (!mounted) return;

      if (photos.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لم يتم اختيار أي صورة')),
        );
        return;
      }

      await Share.shareXFiles(
        photos,
        text: 'مشاركة الصور عبر HAMOUDI Cyber Security',
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذرت مشاركة الصور')),
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
      appBar: AppBar(title: const Text('مشاركة الصور')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
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
                'مشاركة الصور بموافقتك',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'ستختار الصور بنفسك من نافذة اختيار الصور الرسمية.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              ElevatedButton.icon(
                onPressed: loading ? null : sharePhotos,
                icon: const Icon(Icons.share),
                label: Text(
                  loading ? 'يرجى الانتظار...' : 'مشاركة الصور',
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
    return Scaffold(
      appBar: AppBar(title: const Text('حسابي')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          CircleAvatar(
            radius: 42,
            backgroundColor: panel,
            child: Icon(Icons.person, size: 48, color: blue),
          ),
          SizedBox(height: 18),
          Center(
            child: Text(
              'HAMOUDI Cyber Security',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 25),
          FeatureTile(
            icon: Icons.person_outline,
            title: 'المطور',
            subtitle: 'محمد صادق عبده',
          ),
          FeatureTile(
            icon: Icons.info_outline,
            title: 'حول التطبيق',
            subtitle: 'منصة للتوعية بالأمن السيبراني',
          ),
          FeatureTile(
            icon: Icons.privacy_tip_outlined,
            title: 'الخصوصية',
            subtitle: 'لا تتم مشاركة الصور دون اختيار وموافقة المستخدم',
          ),
        ],
      ),
    );
  }
}
