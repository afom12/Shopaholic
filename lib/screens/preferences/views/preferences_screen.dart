import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants.dart';
import 'package:shop/providers/theme_provider.dart';

import 'components/prederence_list_tile.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preferences"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
        child: Column(
          children: [
            // Theme Toggle
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) {
                return ListTile(
                  title: const Text("Dark Mode"),
                  subtitle: const Padding(
                    padding: EdgeInsets.only(top: defaultPadding / 2),
                    child: Text(
                      "Switch between light and dark theme",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  trailing: CupertinoSwitch(
                    onChanged: (value) {
                      themeProvider.toggleTheme();
                    },
                    activeColor: primaryColor,
                    value: themeProvider.isDarkMode,
                  ),
                );
              },
            ),
            const Divider(height: defaultPadding * 2),
            PreferencesListTile(
              titleText: "Analytics",
              subtitleTxt:
                  "Analytics cookies help us improve our application by collecting and reporting info on how you use it. They collect information in a way that does not directly identify anyone.",
              isActive: true,
              press: () {},
            ),
            const Divider(height: defaultPadding * 2),
            PreferencesListTile(
              titleText: "Personalization",
              subtitleTxt:
                  "Personalisation cookies collect information about your use of this app in order to display contect and experience that are relevant to you.",
              isActive: false,
              press: () {},
            ),
            const Divider(height: defaultPadding * 2),
            PreferencesListTile(
              titleText: "Marketing",
              subtitleTxt:
                  "Maarketing cookies collec information about your use of this and other apps to enable display ads and other marketing that is more relevant to you.",
              isActive: false,
              press: () {},
            ),
            const Divider(height: defaultPadding * 2),
            PreferencesListTile(
              titleText: "Social media cookies",
              subtitleTxt:
                  "These cookies are set by a range of social media services that we have added to the site to enable you to share our content with your friends and networks.",
              isActive: false,
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
