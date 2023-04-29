import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mama_resto/theme_manager/space_manager.dart';

import '../features/restaurant/cubit/review_cubit.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, reviewState) {
        final reviews = reviewState.reviews.reversed.toList();

        return Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reviews.isNotEmpty
                  ? const Padding(
                      padding: EdgeInsets.only(left: 24),
                      child: Text(
                        'Reviews :',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 200,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    final review = reviews[index];

                    return Card(
                      child: Container(
                        width: 200,
                        height: 200,
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    review.name ?? '-',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                8.0.spaceX,
                                Text(review.date ?? '-')
                              ],
                            ),
                            16.0.spaceY,
                            Expanded(
                              child: Text(review.review ?? '-'),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      8.0.spaceX,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
