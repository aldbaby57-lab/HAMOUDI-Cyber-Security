
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

  setState(() {
    _status = 'بدأت عملية المشاركة';
  });

  // المشاركة الفعلية تحتاج صلاحية صور واضحة
  // وربطًا آمنًا بالخادم.
}
