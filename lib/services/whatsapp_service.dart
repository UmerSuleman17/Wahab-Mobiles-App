import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  String generateReminderMessage(
    String customerName,
    String businessName,
    String currency,
    double amount,
  ) {
    return 'Hello $customerName, this is a friendly reminder from $businessName that you have an outstanding balance of $currency${amount.toStringAsFixed(2)}. Please arrange payment at your earliest convenience. Thank you!';
  }

  Future<bool> openWhatsApp(String phoneNumber, String message) async {
    final cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final encodedMessage = Uri.encodeComponent(message);
    final url = Uri.parse('https://wa.me/$cleanPhone?text=$encodedMessage');
    if (await canLaunchUrl(url)) {
      return await launchUrl(url, mode: LaunchMode.externalApplication);
    }
    return false;
  }

  Future<bool> canLaunchWhatsApp() async {
    final url = Uri.parse('https://wa.me/');
    return await canLaunchUrl(url);
  }
}
