// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:sessions/bloc/profile/profile_bloc_imports.dart';
import 'package:sessions/bloc/user/user_bloc.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/popup_menus.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/screens/profile/bottom_sheet.dart';
import 'package:sessions/screens/profile/components/tiles.dart';
import 'package:sessions/screens/profile/components/trays.dart';
import 'package:sessions/utils/classes.dart';

List<PairPopMenu> popUpOptions = [
  PairPopMenu(value: 0, option: "Edit Profile"),
  PairPopMenu(value: 1, option: "Edit Blogs"),
  PairPopMenu(value: 2, option: "Refresh"),
];

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  late String userId;
  @override
  void initState() {
    final userState = BlocProvider.of<UserBloc>(context).state;
    if (userState is UserSignedInState) {
      userId = userState.user.userId!;
      BlocProvider.of<ProfileBloc>(context)
          .add(LoadProfileEvent(userId: userId));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(
        title: "Profile",
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: PopUpMenuWidget(
              options: popUpOptions,
              onSelect: ({required int value}) {},
            ),
          ),
        ],
        leading: Container(),
      ),
      body: ViewProfileBody(),
    );
  }
}

class ViewProfileBody extends StatelessWidget {
  const ViewProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        ///
        if (state is ProfileCreatedState) {
          final List<InterestClip> interests = [];
          List<String> interestTitles = state.profile.interests!;
          for (String title in interestTitles) {
            interests.add(InterestClip(title: title));
          }

          ///
          final List<LinkClip> links = [];
          List<LinkItem> linkdetails = state.profile.links!;
          for (LinkItem item in linkdetails) {
            links.add(LinkClip(title: item.name!, url: item.link!));
          }

          ///
          return Container(
            // padding: EdgeInsets.symmetric(5),
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                PhotoTray(
                  coverPhoto: state.profile.coverPic!.secureUrl,
                  profilePic: state.profile.profilePic!.secureUrl,
                  userName: "${state.profile.userName}",
                ),
                MyBottomSheet(
                  minHeight: size.height * 0.65,
                  interests: interests,
                  links: links,
                ),
              ],
            ),
          );
        }
        if (state is ProfileErrorState) {
          return Center(
            child: Text(
              "Error in fetching profile!",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }
        return LoadingIndicator(
          circularBlue: true,
        );
      },
    );
  }
}
