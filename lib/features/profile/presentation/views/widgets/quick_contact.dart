import 'package:flutter/material.dart';
import 'package:uni/features/profile/presentation/views/widgets/contact_us_channel_card.dart';

class QuickContact extends StatelessWidget {
  const QuickContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ContactUsChannelCard(
            icon: Icons.chat_bubble_outline,
            label: 'واتساب',
            iconColor: const Color(0xFF25D366),
            onTap: () {
              // TODO: launch whatsapp
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ContactUsChannelCard(
            icon: Icons.phone_outlined,
            label: 'اتصال',
            iconColor: const Color(0xFF6BBF26),
            onTap: () {
              // TODO: launch phone
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ContactUsChannelCard(
            icon: Icons.email_outlined,
            label: 'إيميل',
            iconColor: Colors.orange,
            onTap: () {
              // TODO: launch email
            },
          ),
        ),
      ],
    );
  }
}
