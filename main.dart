import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const HamoudiApp());

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
        colorScheme: ColorScheme.fromSeed(seedColor: blue, brightness: Brightness.dark),
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
  bool _consent = false;
  String _status = 'جاهز';

  Future<void> _chooseImages() async {
    final approved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('موافقة مشاركة الصور'),
        content: const Text('هل توافق على فتح منتقي الصور واختيار الصور التي تريد مشاركتها؟ لن يتم الوصول إلى صورك دون اختيارك.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('لا أوافق')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('أوافق')),
        ],
      ),
    );
    if (approved != true) return;
    final images = await _picker.pickMultiImage();
    if (!mounted) return;
    setState(() {
      _selected
        ..clear()
        ..addAll(images);
      _consent = true;
      _status = images.isEmpty ? 'لم يتم اختيار صور' : 'تم اختيار ${images.length} صورة';
    });
  }

  Future<void> _chooseScreenshot() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (!mounted || image == null) return;
    setState(() {
      _selected
        ..clear()
        ..add(image);
      _consent = true;
      _status = 'تم اختيار صورة واحدة للمشاركة';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HAMOUDI'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(Icons.shield_outlined, size: 76, color: Color(0xFF168BFF)),
          const SizedBox(height: 12),
          const Text('Cyber Security', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('أدوات توعوية ومشاركة ملفات بموافقة واضحة',
              textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 28),
          Card(
            color: const Color(0xFF102B4B),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const Text('مشاركة الصور', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('اختر بنفسك الصور التي تريد مشاركتها. لا يوجد سحب تلقائي أو خفي للصور.'),
                const SizedBox(height: 14),
                FilledButton.icon(onPressed: _chooseImages, icon: const Icon(Icons.photo_library), label: const Text('اختيار صور متعددة')),
                OutlinedButton.icon(onPressed: _chooseScreenshot, icon: const Icon(Icons.image), label: const Text('اختيار صورة / لقطة شاشة')),
                const SizedBox(height: 10),
                Text('الحالة: $_status'),
                Text('عدد الصور المختارة: ${_selected.length}'),
                if (_selected.isNotEmpty)
                  TextButton(onPressed: () => setState(() { _selected.clear(); _consent = false; _status = 'تم إلغاء الاختيار'; }),
                    child: const Text('إلغاء الاختيار')),
                const SizedBox(height: 8),
                const Text('ملاحظة: الإرسال إلى Telegram أو الخادم غير مفعّل في هذه النسخة الأولية.',
                    style: TextStyle(color: Colors.amberAccent)),
              ]),
            ),
          ),
          const SizedBox(height: 18),
          const Card(
            color: Color(0xFF102B4B),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('الاشتراكات المخطط لها', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('مجاني: ميزات أساسية'),
                Text('شهري: 4.99 USD'),
                Text('سنوي: 39.99 USD'),
                SizedBox(height: 8),
                Text('الشراء والتحقق من الاشتراكات غير مفعّل بعد.', style: TextStyle(color: Colors.amberAccent)),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
