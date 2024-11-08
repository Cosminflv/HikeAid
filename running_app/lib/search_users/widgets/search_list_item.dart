import 'package:flutter/material.dart';
import 'package:running_app/shared_widgets/custom_text_button.dart';

class UserListItem extends StatelessWidget {
  //final SearchUserEntity user;
  //final VoidCallback onTap;
  const UserListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            highlightColor: Theme.of(context).colorScheme.outlineVariant,
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cosmin Popovici",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Text(
                            "3 common friends",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            "Suceava, Romania",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 70,
                  height: 40,
                  child: CustomElevatedButton(
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    text: "Add",
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
