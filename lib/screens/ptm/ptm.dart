import 'package:flutter/material.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/screens/ptm/add/add_screen.dart';
import 'package:masterjee/screens/ptm/minutebook/minutebook_screen.dart';
import 'package:masterjee/screens/ptm/schedule/schedule_screen.dart';
import 'package:masterjee/screens/ptm/upcoming/upcoming_screen.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/cardHomeWidget.dart';

class PTMScreen extends StatefulWidget {
  const PTMScreen({super.key});

  static String routeName = 'PTMScreen';

  @override
  State<PTMScreen> createState() => _PTMScreenState();
}

class _PTMScreenState extends State<PTMScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBarTwo(title: AppTags.pTM),
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  childAspectRatio: 0.99,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  mainAxisSpacing: 20.9,
                  crossAxisSpacing:20.9,
                  children: <Widget>[
                    cardHomeWidget(
                      name: AppTags.upcoming,
                      image: AssetsUtils.upcomingIcon,
                      onTap: () {
                        Navigator.pushNamed(context, UpcomingScreen.routeName);
                      },
                    ),
                    cardHomeWidget(
                        name: AppTags.add,
                        image: AssetsUtils.addPtmIcon,
                        onTap: () {
                          Navigator.pushNamed(context, AddScreen.routeName);
                        }),
                    cardHomeWidget(
                        name: AppTags.schedule,
                        image: AssetsUtils.timeTableIcon,
                        onTap: () {
                          Navigator.pushNamed(
                              context, ScheduleScreen.routeName);
                        }),
                    cardHomeWidget(
                        name: AppTags.minutebook,
                        image: AssetsUtils.minutebookIcon,
                        onTap: () {
                          Navigator.pushNamed(
                              context, MinutebookScreen.routeName);
                        }),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
