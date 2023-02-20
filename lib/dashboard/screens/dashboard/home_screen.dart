import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medtrack/constants/app_constants.dart';
import 'package:medtrack/dashboard/models/auth/auth_model.dart';
import 'package:medtrack/dashboard/models/item_model.dart';
import 'package:medtrack/dashboard/screens/dashboard/settings/settings_screen.dart';
import 'package:medtrack/repository/utils/helper.dart';
import 'package:medtrack/widgets/grid_select_card.dart';
import 'package:medtrack/widgets/list_tile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> items = [];
  AuthModel authModel = AuthModel();

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/item_data_list.json');
    final data = await json.decode(response);

    setState(() {
      items = data['items'].map((data) => Item.fromJson(data)).toList();
    });
  }

  @override
  void initState() {
    super.initState();

    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppConstants.whiteColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        color: AppConstants.primaryColor,
                        height: AppConstants.headerHeight,
                      ),

                      // BODY
                      Padding(
                        padding: EdgeInsets.all(AppConstants.paddingSide),
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            // Header - Greetings and Avatar
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Icon(
                                  Icons.notifications,
                                  color: AppConstants.whiteColor,
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                const SizedBox(width: 12),
                                Icon(Icons.light_mode,
                                    color: AppConstants.darkOrange),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Good Morning",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppConstants.whiteColor),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () => Helper.navigateToNextPage(
                                      context, const SettingsScreen()),
                                  child: CircleAvatar(
                                    radius: 32.0,
                                    backgroundColor: AppConstants.blackColor
                                        .withOpacity(0.2),
                                    backgroundImage: const NetworkImage(AppConstants
                                        .profileURL), /*AssetImage(
                                      'assets/icons/profile_picture.png')*/
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      authModel.getFullName() ??
                                          AppConstants.profileName,
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w500,
                                          color: AppConstants.whiteColor),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                            color: AppConstants.blackColor
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            "ID",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: AppConstants.whiteColor),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          authModel.getGhanaCardNumber() ??
                                              AppConstants.healthCardID,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppConstants
                                                  .artBoardBackground),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin:
                                  const EdgeInsets.only(top: 84, bottom: 16),
                              child: Center(
                                child: GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16.0,
                                    mainAxisSpacing: 16.0,
                                    children:
                                        List.generate(items.length, (index) {
                                      return Center(
                                        child: SelectCard(item: items[index]),
                                      );
                                    })),
                              ),
                            ),
                            Container(
                              height: 32,
                              padding: const EdgeInsets.only(
                                  left: 16, top: 8.0, bottom: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: AppConstants.secondaryBackGround,
                              ),
                              child: Text(
                                "Recent visits",
                                style: TextStyle(
                                  color: AppConstants.blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: ListTileWidget(
                      icon: SvgPicture.asset(
                          Helper.getAssetSVGName("iconDarkEncounter", "svg")),
                      title: 'Acute Migraine',
                      subTitle: "1st Jan 2021",
                      backGroundColor: AppConstants.secondaryBackGround,
                      onTab: () {},
                      trailingIcon: Icons.arrow_forward_ios_outlined,
                    ),
                  )
                ],
              ),
            )));
  }
}
