import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/models/favorites_manager.dart';
import '../../../data/models/favorite_model/datum.dart';
import '../../manger/cubit/favorites_cubit.dart';

class BuildListViewFavoritesItem extends StatelessWidget {
  const BuildListViewFavoritesItem({super.key, required this.model});
  final Datum model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: 120,
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  '${model.product!.image //  item.image,
                  }',
                  width: 120,
                  height: 120,
                ),
                if (model.product!.discount != 0)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'DISCOUNT',
                        style:
                            AppStyles.textStyle12.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product!.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.textStyle14.copyWith(height: 1.4),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.product!.price}',
                        style: AppStyles.textStyle14
                            .copyWith(color: kPrimaryColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.product!.discount != 0)
                        Text(
                          '${model.product!.oldPrice}',
                          style: AppStyles.textStyle12.copyWith(
                              color: Colors.grey[400],
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          FavoritesCubit.get(context)
                              .changeFavorites(productId: model.product!.id!);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              FavoritesManager.favorites[model.product!.id]!
                                  ? kPrimaryColor
                                  : Colors.grey[350],
                          child: const Icon(
                            color: Colors.white,
                            Icons.favorite_border,
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
