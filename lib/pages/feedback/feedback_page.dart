import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:event_admin/pages/feedback/controlles/feedback_controller.dart';
import 'package:event_admin/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 08/12/22 at 12:31 AM
///

class FeedbackPage extends StatefulWidget {
  static const routeName = '/feedback-page';

  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  late FeedbackController controller;

  @override
  void initState() {
    super.initState();
    controller = FeedbackController();
    controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                Text(
                  "Send us your Feedback!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Do you have a suggestion or found some bug? Let us know in the field below.",
                ),
                const SizedBox(height: 12),
                RatingBar(
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: Icon(Icons.star, color: Colors.yellow),
                    half: Icon(Icons.star, color: Colors.yellow),
                    empty: Icon(Icons.star_border, color: Colors.yellow),
                  ),
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  onRatingUpdate: controller.onRatingSaved,
                ),
                const SizedBox(height: 18),
                TextFormField(
                  minLines: 12,
                  maxLines: 16,
                  onChanged: controller.onDescSaved,
                  onSaved: controller.onDescSaved,
                  decoration:
                      AppDecorations.textFieldDecoration(context).copyWith(),
                ),
                const SizedBox(height: 12),
                GetBuilder(
                  init: controller,
                  builder: (c) => Row(
                    children: [1, 2, 3]
                        .map(
                          (e) => SuggestionType(
                            title: e == 1
                                ? "Suggestion"
                                : e == 2
                                    ? "Issue"
                                    : "Others",
                            selected: controller.type == e,
                            onTap: () => controller.onTypeSaved(e),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: AppPrimaryButton(
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: controller.proceed,
                key: controller.buttonKey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SuggestionType extends StatelessWidget {
  final bool selected;
  final String title;
  final VoidCallback? onTap;

  const SuggestionType(
      {Key? key, this.selected = false, this.onTap, this.title = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 18),
        child: Row(
          children: [
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.brightSecondaryColor
                    : Colors.transparent,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "$title",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
