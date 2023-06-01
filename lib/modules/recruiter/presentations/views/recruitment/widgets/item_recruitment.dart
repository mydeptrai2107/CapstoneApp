import 'package:app/shared/presentations/widgets/ontap_effect.dart';
import 'package:flutter/material.dart';

import 'package:app/shared/models/recruitment_model.dart';

import '../../../../../candidate/presentations/themes/color.dart';

class ItemRecruitment extends StatelessWidget {
  final Recruitment item;
  const ItemRecruitment({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return OntapEffect(
      onTap: () {},
      radius: 8.0,
      child: Ink(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  item.title!.toUpperCase(),
                  style: textTheme.titleSmall,
                )),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(6.0)),
                  child: Text(
                    'Đang bật',
                    style: textTheme.bodySmall!.copyWith(color: primaryColor),
                  ),
                )
              ],
            ),
            Text(
              'Miêu tả',
              style:
                  textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              item.descriptionWorking!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Element(
                  label: 'Số lượng',
                  des: item.numberOfRecruits.toString(),
                ),
                const Element(
                  label: 'Trạng thái',
                  des: 'Dừng hiển thị',
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Element extends StatelessWidget {
  final String label;
  final String des;
  const Element({
    Key? key,
    required this.label,
    required this.des,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(6.0)),
            child: Text(
              des,
              style: textTheme.bodySmall,
            )),
      ],
    );
  }
}
