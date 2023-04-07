import 'package:flutter/material.dart';
import 'package:rune_of_the_day/app/data/models/category.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/card_category/castom_category_card.dart';
import 'package:rune_of_the_day/app/presentation/common_widgets/custom_card.dart';
import '../../common_widgets/share_widgets.dart';

Widget buildDescriptionCard({
  @required CardCategory descriptionCategory,
  @required bool isClosedCard,
}) {
  if (isClosedCard) {
    return SliverToBoxAdapter(child: Container());
  }
  return SliverToBoxAdapter(
    child: CustomCard(
      child: Column(
        children: [
          CustomCategoryCard(
            header: descriptionCategory.header,
            content: descriptionCategory.description,
            icon: descriptionCategory.icon,
            isWrapped: false,
          ),
          buildShareAndCopy(descriptionCategory.description),
        ],
      ),
    ),
  );
}
