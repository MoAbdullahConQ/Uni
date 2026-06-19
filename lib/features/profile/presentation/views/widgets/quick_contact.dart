import 'package:flutter/material.dart';
import 'package:uni/features/profile/presentation/views/widgets/contact_us_channel_card.dart';
import 'package:url_launcher/url_launcher.dart';

// dummy contact data — replace with real values when available
const _kWhatsAppNumber = '201000000000'; // without leading +
const _kPhoneNumber = '+201000000000';
const _kEmail = 'support@gameaty.app';

class QuickContact extends StatelessWidget {
  const QuickContact({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ContactUsChannelCard(
            icon: Icons.chat_bubble_outline,
            label: 'واتساب',
            iconColor: const Color(0xFF25D366),
            onTap: () => _launch('https://wa.me/$_kWhatsAppNumber'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ContactUsChannelCard(
            icon: Icons.phone_outlined,
            label: 'اتصال',
            iconColor: const Color(0xFF6BBF26),
            onTap: () => _launch('tel:$_kPhoneNumber'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ContactUsChannelCard(
            icon: Icons.email_outlined,
            label: 'إيميل',
            iconColor: Colors.orange,
            onTap: () => _launch('mailto:$_kEmail'),
          ),
        ),
      ],
    );
  }
}
