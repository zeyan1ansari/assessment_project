import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:video_player/video_player.dart';

import 'model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}



  Future<List<Job>> _fetchJobs() async {

    const jobsListAPIUrl = 'https://www.xynie.com/feeds/short-videos-app/page/0';
    final response = await http.get(Uri.parse(jobsListAPIUrl));
    if (response.statusCode == 200) {
      String data = response.body;

      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

class _MyHomePageState extends State<MyHomePage> {

  VideoPlayerController? _controller;
  @override
  void initState() {
    // put it here
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

    super.initState();

    loadVideoClip();
  }
  @override
  void dispose() {
    videoPlayerController.dispose();
    // chewie.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body:  FutureBuilder<List<Job>>(
          future: _fetchJobs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Job>? data = snapshot.data;
              return InViewNotifierList(
                isInViewPortCondition:
                    (double deltaTop, double deltaBottom, double vpHeight) {
                  return deltaTop < (0.5 * vpHeight) && deltaBottom > (0.5 * vpHeight);
                },
                itemCount: 3,
                builder: (BuildContext context, int index) {
                  final chewie = ChewieController(
                        aspectRatio:0.5 ,
                    showControls: false,
                    videoPlayerController: VideoPlayerController.network(
                        data![index].vimeo![index].link.toString()),
                    autoPlay: true,
                    looping: true,
                    allowFullScreen: true,
                    autoInitialize: true,
                    cupertinoProgressColors: ChewieProgressColors(),

                  );
                  return InViewNotifierWidget(
                    id: '$index',
                    builder: (BuildContext context, bool isInView, _) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.black,

                        ),

                        child: Stack(
                          children: [
                            Chewie(controller:chewie ),
                            Container(padding: EdgeInsets.all(15),width: MediaQuery.of(context).size.width,
                              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Icon(Icons.chevron_left,size: 30, color: Colors.white,),
                                  // Center(
                                  //   child: CircleAvatar(radius: 30,backgroundColor: Colors.white.withOpacity(0.25),
                                  //     child: IconButton( onPressed: () {
                                  //       setState(() {
                                  //         _controller!.value.isPlaying
                                  //             ? _controller!.pause()
                                  //             : _controller!.play();
                                  //       });
                                  //     }, icon: Icon(
                                  //       _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,color: Colors.black,size: 30,
                                  //     ),),
                                  //   ),
                                  // ),
                                  Container(width: MediaQuery.of(context).size.width,
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [

                                        Container(width:MediaQuery.of(context).size.width*0.8,
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            children:  [
                                              Text(data![index].postDateStr.toString(),style: TextStyle(fontSize: 14,color: Colors.white,),),
                                              SizedBox(height: 5,),
                                              Text(data[index].title.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white),),
                                              SizedBox(height: 55,),
                                            ],
                                          ),
                                        ),
                                        Column(children:  [
                                          CircleAvatar(child: Icon(Icons.favorite_border,color: Colors.black,),backgroundColor: Colors.white.withOpacity(0.25),),
                                          const SizedBox(height: 8,),
                                          CircleAvatar(child: Icon(Icons.comment,color: Colors.black),backgroundColor: Colors.white.withOpacity(0.25),),
                                          const SizedBox(height: 8,),
                                          CircleAvatar(child: Icon(Icons.share,color: Colors.black),backgroundColor: Colors.white.withOpacity(0.25),),
                                          const SizedBox(height: 80,),
                                        ],),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        )


      ),
    );
  }

  final videoPlayerController = VideoPlayerController.network(
      'https://player.vimeo.com/external/552421426.hd.mp4?s=a4e3b5d1768bd29f37298743162e1b15c93856e4&profile_id=172&oauth2_token_id=57447761');

  void loadVideoClip() async {
    await videoPlayerController.initialize();
  }

  //
  // InViewNotifierList _jobsListView(data) {
  //
  //   return InViewNotifierList(
  //     isInViewPortCondition:
  //         (double deltaTop, double deltaBottom, double vpHeight) {
  //       return deltaTop < (0.5 * vpHeight) && deltaBottom > (0.5 * vpHeight);
  //     },
  //     itemCount: 3,
  //     builder: (BuildContext context, int index) {
  //       // final chewie = ChewieController(
  //       //   videoPlayerController: VideoPlayerController.network(
  //       //       'https://player.vimeo.com/external/552421426.hd.mp4?s=a4e3b5d1768bd29f37298743162e1b15c93856e4&profile_id=172&oauth2_token_id=57447761'),
  //       //   autoPlay: true,
  //       //   looping: true,
  //       //   allowFullScreen: true,
  //       //   autoInitialize: true,
  //       //   cupertinoProgressColors: ChewieProgressColors(),
  //       //
  //       // );
  //       return InViewNotifierWidget(
  //         id: '$index',
  //         builder: (BuildContext context, bool isInView, _) {
  //           return Container(
  //             height: MediaQuery.of(context).size.height,
  //             width: MediaQuery.of(context).size.width,
  //             decoration: const BoxDecoration(
  //               color: Colors.black,
  //
  //             ),
  //
  //             child: Stack(
  //               children: [
  //                 Chewie(controller: ChewieController(
  //                   videoPlayerController: VideoPlayerController.network(
  //                       'https://player.vimeo.com/external/552421426.hd.mp4?s=a4e3b5d1768bd29f37298743162e1b15c93856e4&profile_id=172&oauth2_token_id=57447761'),
  //                   autoPlay: true,
  //                   looping: true,
  //                   allowFullScreen: true,
  //                   autoInitialize: true,
  //                   cupertinoProgressColors: ChewieProgressColors(),
  //
  //                 )),
  //                 Container(padding: EdgeInsets.all(15),width: MediaQuery.of(context).size.width,
  //                   child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
  //                     children:  [
  //                       Icon(Icons.chevron_left,size: 30, color: Colors.white,),
  //                       Center(
  //                         child: CircleAvatar(radius: 30,backgroundColor: Colors.white.withOpacity(0.25),
  //                           child: IconButton( onPressed: () {
  //                             setState(() {
  //                               _controller!.value.isPlaying
  //                                   ? _controller!.pause()
  //                                   : _controller!.play();
  //                             });
  //                           }, icon: Icon(
  //                             _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,color: Colors.black,size: 30,
  //                           ),),
  //                         ),
  //                       ),
  //                       Container(width: MediaQuery.of(context).size.width,
  //                         child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.end,
  //                           children: [
  //
  //                             Container(width:MediaQuery.of(context).size.width*0.8,
  //                               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children:  [
  //                                   Text(data[index].postDateStr,style: TextStyle(fontSize: 14,color: Colors.white,),),
  //                                   SizedBox(height: 5,),
  //                                   Text(data[index].title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white),),
  //                                 ],
  //                               ),
  //                             ),
  //                             Column(children:  [
  //                               CircleAvatar(child: Icon(Icons.favorite_border,color: Colors.black,),backgroundColor: Colors.white.withOpacity(0.25),),
  //                               const SizedBox(height: 8,),
  //                               CircleAvatar(child: Icon(Icons.comment,color: Colors.black),backgroundColor: Colors.white.withOpacity(0.25),),
  //                               const SizedBox(height: 8,),
  //                               CircleAvatar(child: Icon(Icons.share,color: Colors.black),backgroundColor: Colors.white.withOpacity(0.25),),
  //                               const SizedBox(height: 80,),
  //                             ],),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }


}
