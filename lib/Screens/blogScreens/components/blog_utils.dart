// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_const_constructors_in_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:sessions/assets.dart';
import 'package:sessions/components/carousal_slider.dart';
import 'package:sessions/components/styles.dart';
import 'package:sessions/components/trays.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/models/blogpost.model.dart';
import 'package:sessions/models/profile.model.dart';
import 'package:video_player/video_player.dart';

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

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  VideoPlayerWidget({super.key, required this.url});

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  bool playing = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryLightColor,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  VideoPlayer(_videoPlayerController),
                  VideoProgressIndicator(
                    _videoPlayerController,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      backgroundColor: Colors.white,
                      bufferedColor: kPrimaryLightColor,
                      playedColor: kPrimaryColor,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: !playing
                        ? IconButton(
                            icon: Icon(Icons.play_arrow),
                            color: Colors.white,
                            onPressed: () {
                              _videoPlayerController.play();
                              setState(() {
                                playing = true;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.pause),
                            color: Colors.white,
                            onPressed: () {
                              _videoPlayerController.pause();
                              setState(() {
                                playing = false;
                              });
                            },
                          ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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

int _mediaIndex = 0;

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
        media.add(VideoPlayerWidget(url: item.secureUrl!));
      }
    }

    super.initState();
  }

  void pageChange({required int value}) {
    _mediaIndex = value;

    setState(() {
      _mediaIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 3.5),
      margin: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 5),
      decoration: BoxDecoration(
        color: lightColor.withOpacity(0.4),
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
                      height: size.height * 0.25,
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
                                      height: size.height * 0.25,
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
                                      color: _mediaIndex == index
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
