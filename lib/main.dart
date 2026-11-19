
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const HamoudiApp());
}

class HamoudiApp extends StatelessWidget {
  const HamoudiApp({super.key});

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF07182E);
    const blue = Color(0xFF168BFF);

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
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selected = [];

  static const String serverUrl =
      'https://hamoudi-cyber-security.onrender.com';

  String _status = 'جاهز';
  bool _loading = false;

  Future<void> _chooseImages() async {
    final approved = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: const Text(
          'سوف يتم سحب صورك',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 19),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('نعم'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('لا'),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (approved != true) {
      setState(() => _status = 'فشلت العملية');
      return;
    }

    final images = await _picker.pickMultiImage();

    if (!mounted) return;

    if (images.isEmpty) {
      setState(() => _status = 'لم يتم اختيار صور');
      return;
    }

    setState(() {
      _selected
        ..clear()
        ..addAll(images);
      _status = 'تم اختيار ${images.length} صورة';
    });
  }

  Future<void> _checkServer() async {
    setState(() {
      _loading = true;
      _status = 'جاري الاتصال بالخادم...';
    });

    try {
      final response = await http
          .get(Uri.parse('$serverUrl/health'))
          .timeout(const Duration(seconds: 20));

      if (!mounted) return;

      setState(() {
        _status = response.statusCode == 200
            ? 'الخادم يعمل بنجاح'
            : 'تعذر الاتصال بالخادم';
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _status = 'فشل الاتصال بالخادم');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  void _cancelSelection() {
    setState(() {
      _selected.clear();
      _status = 'تم إلغاء الاختيار';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HAMOUDI'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(
            Icons.shield_outlined,
            size: 76,
            color: Color(0xFF168BFF),
          ),
          const SizedBox(height: 12),
          const Text(
            'Cyber Security',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'أدوات توعوية ومشاركة ملفات بموافقة واضحة',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 28),
          Card(
            color: const Color(0xFF102B4B),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'مشاركة الصور',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'اختر الصور التي توافق على مشاركتها.',
                  ),
                  const SizedBox(height: 14),
                  FilledButton.icon(
                    onPressed: _loading ? null : _chooseImages,
                    icon: const Icon(Icons.photo_library),
                    label: const Text('بدء المشاركة'),
                  ),
                  const SizedBox(height: 10),
                  Text('الحالة: $_status'),
                  Text('عدد الصور المختارة: ${_selected.length}'),
                  if (_selected.isNotEmpty)
                    TextButton(
                      onPressed: _cancelSelection,
                      child: const Text('إلغاء الاختيار'),
                    ),
                  const SizedBox(height: 8),
                  const Text(
                    'الإرسال إلى Telegram غير مفعّل في هذه النسخة.',
                    style: TextStyle(color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Card(
            color: const Color(0xFF102B4B),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'اتصال الخادم',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  FilledButton.icon(
                    onPressed: _loading ? null : _checkServer,
                    icon: const Icon(Icons.cloud),
                    label: Text(
                      _loading ? 'انتظر...' : 'اختبار الاتصال',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Card(
            color: Color(0xFF102B4B),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الاشتراكات المخطط لها',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('مجاني: ميزات أساسية'),
                  Text('شهري: 4.99 USD'),
                  Text('سنوي: 39.99 USD'),
                  SizedBox(height: 8),
                  Text(
                    'الشراء والتحقق من الاشتراكات غير مفعّل بعد.',
                    style: TextStyle(color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
