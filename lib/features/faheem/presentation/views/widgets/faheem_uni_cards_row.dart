import 'package:flutter/material.dart';
import 'package:uni/features/faheem/domain/entities/chat_message_entity.dart';
import 'package:uni/features/faheem/presentation/views/widgets/faheem_uni_card.dart';

class FaheemUniCardsRow extends StatelessWidget {
  const FaheemUniCardsRow({super.key, required this.faheemUniCardEntities});

  final List<FaheemUniCardEntity> faheemUniCardEntities;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: faheemUniCardEntities.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => FaheemUniCard(faheemUniCardEntity: faheemUniCardEntities[i]),
      ),
    );
  }
}
