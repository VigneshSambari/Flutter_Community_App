// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:sessions/assets.dart';
import 'package:sessions/components/carousal_slider.dart';
import 'package:sessions/components/styles.dart';
import 'package:sessions/components/trays.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/models/blogpost.model.dart';
import 'package:sessions/models/profile.model.dart';
import 'package:sessions/utils/navigations.dart';

class BlogImageTile extends StatelessWidget {
  final String url;

  const BlogImageTile({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return url.isEmpty
        ? Placeholder()
        : ClipRRect(
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              placeholder: (context, _) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              imageUrl: url,
            ),
          );
  }
}

class BlogVideoTile extends StatefulWidget {
  final String url;
  const BlogVideoTile({super.key, required this.url});

  @override
  State<BlogVideoTile> createState() => _BlogVideoTileState();
}

class _BlogVideoTileState extends State<BlogVideoTile> {
  late CachedVideoPlayerController controller;

  @override
  void initState() {
    controller = CachedVideoPlayerController.network(
      widget.url,
    );
    controller.initialize().then((value) {
      controller.play();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.pause();
        navigatorPush(BlogVideoTile(url: widget.url), context);
      },
      child: Center(
        child: controller.value.isInitialized
            ? ClipRRect(
                child: CachedVideoPlayer(
                  controller,
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}

class BlogTile extends StatefulWidget {
  final ProfileModel user;
  final BlogPostModel blog;
  const BlogTile({
    super.key,
    required this.blog,
    required this.user,
  });

  @override
  State<BlogTile> createState() => _BlogTileState();
}

int mediaIndex = 0;

String getFileType(String url) {
  final mimeType = lookupMimeType(url);
  if (mimeType == null) {
    return 'unknown';
  } else if (mimeType.startsWith('image/')) {
    return 'image';
  } else if (mimeType.startsWith('audio/')) {
    return 'audio';
  } else if (mimeType.startsWith('video/')) {
    return 'video';
  } else {
    return 'other';
  }
}

class _BlogTileState extends State<BlogTile> {
  List<Widget> media = [];

  @override
  void initState() {
    for (var item in widget.blog.coverMedia!) {
      if (getFileType(item.secureUrl!) == "image") {
        media.add(BlogImageTile(
          url: item.secureUrl!,
        ));
      }
      if (getFileType(item.secureUrl!) == "video") {
        media.add(BlogVideoTile(
          url: item.secureUrl!,
        ));
      }
    }

    super.initState();
  }

  void pageChange({required int value}) {
    mediaIndex = value;

    setState(() {
      mediaIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 3.5),
      margin: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 5),
      decoration: BoxDecoration(
        color: lightColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    //margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          child: CircleAvatar(
                            backgroundColor: kPrimaryLightColor,
                            radius: 20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CircleImageTile(
                                groupOrPerson: false,
                                url: widget.user.profilePic!.secureUrl,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.blog.title!,
                              style: blogTitleStyle,
                            ),
                            Text(
                              widget.user.userName!,
                              style: blogSubtitleStyle,
                            )
                          ],
                        ),
                        Spacer(),
                        InkWell(
                          child: Icon(Icons.more_vert),
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: size.width,
                      height: 220,
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Center(
                              child: media.isEmpty
                                  ? Image.asset(
                                      Assets.assetsGlobalNoimageexists,
                                      fit: BoxFit.cover,
                                      height: 220,
                                      width: size.width,
                                    )
                                  : CarouselSlider(
                                      height: size.height * 0.25,
                                      items: media,
                                      margin: 0,
                                      scroll: false,
                                      widthRatio: 1,
                                      pageChange: pageChange,
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 3,
                            right: 0,
                            left: 0,
                            child: Center(
                              child: Wrap(
                                children: List.generate(
                                  widget.blog.coverMedia!.length,
                                  (index) => Container(
                                    width: 7,
                                    height: 7,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 2.0),
                                    decoration: BoxDecoration(
                                      color: mediaIndex == index
                                          ? Colors.white
                                          : Colors.white70,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Positioned(
                  //   bottom: 10,
                  //   right: 10,
                  //   child: GestureDetector(
                  //     onTap: () {},
                  //     child: SizedBox(
                  //       height: 35,
                  //       width: 35,
                  //       child: ClipRRect(
                  //         borderRadius: BorderRadius.circular(15),
                  //         child: BackdropFilter(
                  //           filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  //           child: widget.blog.coverMedia!.length <= 1
                  //               ? SizedBox()
                  //               : Container(
                  //                   child: CircleAvatar(
                  //                     backgroundColor: Colors.transparent,
                  //                     child: Text(
                  //                       "+${widget.blog.coverMedia!.length - 1}",
                  //                       style: TextStyle(
                  //                         fontSize: 13,
                  //                         color: Colors.white,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Wrap(
                  children: [
                    Text(
                      "${widget.user.userName!} ",
                      overflow: TextOverflow.fade,
                    ),
                    Text(
                      "${widget.blog.body}",
                      overflow: TextOverflow.fade,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SelectedFileTile extends StatelessWidget {
  const SelectedFileTile({
    Key? key,
    required this.index,
    required this.removeTile,
    required this.title,
  }) : super(key: key);

  final Function removeTile;
  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.5),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: kPrimaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              removeTile(index);
            },
            child: Icon(
              Icons.close,
              color: kPrimaryColor,
            ),
          )
        ],
      ),
    );
  }
}

class TypeSpecifiers extends StatelessWidget {
  const TypeSpecifiers({
    super.key,
    required this.background,
    required this.textColor,
    required this.title,
  });

  final Color background, textColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          color: textColor,
        ),
      ),
    );
  }
}
