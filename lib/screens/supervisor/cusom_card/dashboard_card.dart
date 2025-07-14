// lib/widgets/dashboard_card.dart
import 'package:flutter/material.dart';
import 'package:construction_manager_app/models/supervisor/dashboard_model/dashboard.dart';

class DashboardCardWidget extends StatelessWidget {
  final DashboardCard card;
  final int index;
  final Function(DashboardCard) onTap;

  const DashboardCardWidget({
    super.key,
    required this.card,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 100)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(card),
          borderRadius: BorderRadius.circular(18),
          child: Container(
            height: 155,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: card.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(card.icon, color: card.color, size: 18),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  card.value,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  card.title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  card.subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardCardsRow extends StatelessWidget {
  final List<DashboardCard> cards;
  final Function(DashboardCard) onCardTap;

  const DashboardCardsRow({
    super.key,
    required this.cards,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DashboardCardWidget(
                  card: cards[0],
                  index: 0,
                  onTap: onCardTap,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DashboardCardWidget(
                  card: cards[1],
                  index: 1,
                  onTap: onCardTap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DashboardCardWidget(
                  card: cards[2],
                  index: 2,
                  onTap: onCardTap,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DashboardCardWidget(
                  card: cards[3],
                  index: 3,
                  onTap: onCardTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
