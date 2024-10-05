import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:running_app/shared_widgets/custom_text_button.dart';

class UserProfileViewPage extends StatelessWidget {
  const UserProfileViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).highlightColor,
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: Theme.of(context).colorScheme.onSurface,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.gear,
                color: Theme.of(context).colorScheme.onSurface,
              ))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              color: Theme.of(context).highlightColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30.0,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Cosmin Popovici",
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "this is my bio",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 20.0),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Following",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  "6",
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 20.0),
                                )
                              ],
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Followers",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  "6",
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 20.0),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                          width: 100,
                          child: CustomElevatedButton(
                            backgroundColor: Theme.of(context).brightness == Brightness.light
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onSurface,
                            text: AppLocalizations.of(context)!.edit,
                            textColor: Theme.of(context).colorScheme.surface,
                            trailing: Icon(
                              FontAwesomeIcons.pen,
                              color: Theme.of(context).colorScheme.surface,
                              size: 15,
                            ),
                            onTap: () {
                              //TODO Add navigation to edit profile page
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
