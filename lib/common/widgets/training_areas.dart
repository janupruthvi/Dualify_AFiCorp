import 'package:dualify_apprenticeship_aficorp/models/company.dart';
import 'package:dualify_apprenticeship_aficorp/models/school.dart';
import 'package:flutter/material.dart';

class TrainingAreasSection extends StatelessWidget {

  final Company company;
  final School school;

  const TrainingAreasSection({
    super.key,
    required this.company,
    required this.school,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('My Training Areas', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        const SizedBox(height: 12),
        Row(
          spacing: 0,
          children: [
            Expanded(
              child: _TrainingCard(
                title: 'Company',
                subtitle: company.name,
                icon: Icons.apartment_outlined,
                isVerified: company.isVerified,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _TrainingCard(
                title: 'School',
                subtitle: school.name,
                icon: Icons.school_outlined,
                isVerified: school.isVerified,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TrainingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isVerified;

  const _TrainingCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.orange),
            const SizedBox(width: 6),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    subtitle,
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isVerified)
                const Icon(Icons.verified, color: Colors.orange, size: 22),
              ],
            )
          ],
        ),
      ),
    );
  }
}
