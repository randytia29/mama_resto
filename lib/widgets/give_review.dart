import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mama_resto/theme_manager/space_manager.dart';
import 'package:mama_resto/widgets/custom_text_form.dart';

import '../features/restaurant/cubit/add_review_cubit.dart';
import '../theme_manager/color_manager.dart';

class GiveReview extends StatelessWidget {
  const GiveReview({
    super.key,
    required TextEditingController reviewController,
    required AddReviewCubit addReviewCubit,
    required TextEditingController nameController,
    required String id,
  })  : _reviewController = reviewController,
        _nameController = nameController,
        _addReviewCubit = addReviewCubit,
        _id = id;

  final TextEditingController _reviewController;
  final TextEditingController _nameController;
  final AddReviewCubit _addReviewCubit;
  final String _id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child:
              CustomTextForm(searchController: _nameController, hint: 'Nama'),
        ),
        16.0.spaceY,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextFormField(
            textInputAction: TextInputAction.done,
            maxLines: 4,
            controller: _reviewController,
            decoration: InputDecoration(
              fillColor: ColorManager.white,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: ColorManager.grey),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
        16.0.spaceY,
        BlocBuilder<AddReviewCubit, AddReviewState>(
          builder: (context, addReviewState) {
            if (addReviewState is AddReviewLoading) {
              return const CircularProgressIndicator();
            }
            return ElevatedButton(
              onPressed: () {
                _addReviewCubit.sendReview(
                    _id, _nameController.text, _reviewController.text);
              },
              child: const Text('Kirim review'),
            );
          },
        ),
      ],
    );
  }
}
