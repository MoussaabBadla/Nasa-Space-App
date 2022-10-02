import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_space_app/UI/Screens/get_started.dart';
import 'package:nasa_space_app/UI/Screens/homepage.dart';
import 'package:nasa_space_app/constant.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

import '../../logic/cubit/search_cubit.dart';
import '../../models/content.dart';
enum Share {
  facebook,
  messenger,
  twitter,
  whatsapp,
  whatsapp_personal,
  whatsapp_business,
  share_system,
  share_instagram,
  share_telegram
}

class Search extends StatefulWidget {
  const Search({super.key});
  static const String route = '/search';

  @override
  State<Search> createState() => _SearchState();
}

bool share = false;
class _SearchState extends State<Search> {
@override

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BackGround(
        child: Column(
          children: [
            NasaTitle(),
            Text(
              'Enjoy the view',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CostumTextfield(),
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is Searchdone){
                  print(state.contents[0].nasa_id);
              return        Expanded(
                  child: PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.contents.length,
                    itemBuilder: ((context, ind) => GestureDetector(
                          onTap: () {
                            setState(() {
                              share = false;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            width: 312,
                            height: 581,
                            decoration: BoxDecoration(
                              borderRadius: borderRadius,
                              border:
                                  Border.all(color: darkblue.withOpacity(0.7)),
                            ),
                            child: SingleChildScrollView(
                              child: Stack(
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8)),
                                              
                                          child: Image.network(
                                            state.contents[ind].href !=null?
                                            state.contents[ind].href!:'https://cdn.mos.cms.futurecdn.net/cMDRA3454bGvfZASbxviZe.jpg',
                                            height: 290,
                                            width: 312,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {},
                                                icon: Image.asset(
                                                  'assets/images/heart.png',
                                                  width: 28,
                                                  height: 28,
                                                  fit: BoxFit.none,
                                                )),
                                            const Spacer(),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Image.asset(
                                                  'assets/images/nonsaved.png',
                                                  width: 28,
                                                  height: 28,
                                                  fit: BoxFit.none,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    share = !share;
                                                  });
                                                },
                                                icon: Image.asset(
                                                  'assets/images/share.png',
                                                  width: 28,
                                                  height: 28,
                                                  fit: BoxFit.none,
                                                )),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 8),
                                          child: Text(
                                            state.contents[ind].title != null ?
                                            state.contents[ind].title! : '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          ),
                                        ),
                                        if(state.contents[ind].description!=null)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 8),
                                          child: Text(
                                            state.contents[ind].description!
                                            ,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 8),
                                          child: Text(
                                            state.contents[ind].date_created!,
                                            style: TextStyle(
                                              color: darkblue.withOpacity(0.9),
                                              fontSize: 10,
                                              fontFamily: 'Nasalization',
                                            ),
                                          ),
                                        ),
                                        if(state.contents[ind].keywords != null)
                                        Wrap(
                                          children: List.generate(
                                              state.contents[ind].keywords!.length,
                                              (index) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              borderRadius,
                                                          border: Border.all(
                                                              color: darkblue,
                                                              width: 1)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8,
                                                                vertical: 3),

                                                        child: 
                                                        Text(
                                                          state.contents[ind].keywords![index],
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                        )
                                      ]),
                                  Positioned(
                                      top: 240,
                                      left: 10,
                                      child: AnimatedOpacity(
                                        opacity: share ? 1 : 0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: borderRadius,
                                              border: Border.all(
                                                  color: darkblue
                                                      .withOpacity(0.6))),
                                          child: Row(children: [
                                            IconButton(
                                                onPressed: share
                                                    ? () {
                                                        print('object');
                                                      }
                                                    : () {},
                                                icon: Image.asset(
                                                  'assets/images/discord.png',
                                                  width: 28,
                                                  height: 28,
                                                  fit: BoxFit.none,
                                                )),
                                            IconButton(
                                                onPressed:
                                                    share ? () {} : () {},
                                                icon: Image.asset(
                                                  'assets/images/snapchat.png',
                                                  width: 28,
                                                  height: 28,
                                                  fit: BoxFit.none,
                                                )),
                                            IconButton(
                                                onPressed: share
                                                    ? () {
                                                        print('object');
                                                      }
                                                    : () {},
                                                icon: Image.asset(
                                                  'assets/images/P.png',
                                                  width: 28,
                                                  height: 28,
                                                  fit: BoxFit.none,
                                                )),
                                            IconButton(
                                                onPressed:
                                                    share ? () {} : () {
                                                                                                            onButtonTap(Share.twitter,state.contents[ind].title!, state.contents[ind].href!);

                                                    },
                                                icon: Image.asset(
                                                  'assets/images/twitter.png',
                                                  width: 28,
                                                  height: 28,
                                                  fit: BoxFit.none,
                                                )),
                                            IconButton(
                                                onPressed: share
                                                    ? () {
                                                        print('object');
                                                      }
                                                    : () {},
                                                icon: Image.asset(
                                                  'assets/images/instagram.png',
                                                  width: 28,
                                                  height: 28,
                                                  fit: BoxFit.none,
                                                )),
                                            IconButton(
                                                onPressed:
                                                    share ? () {
                                                      onButtonTap(Share.facebook,state.contents[ind].title!, state.contents[ind].href!);
                                                    } : () {},
                                                icon: Image.asset(
                                                  'assets/images/facebook.png',
                                                  width: 28,
                                                  height: 28,
                                                  fit: BoxFit.none,
                                                )),
                                          ]),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ),
                );

                }
                 return Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      ),
    );
  }
}

class BackGround extends StatelessWidget {
  const BackGround({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BackGroundimage(),
      SafeArea(
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: child))
    ]);
  }
}
  Future<void> onButtonTap(Share share, String msg , String url) async {

    String? response;
    final FlutterShareMe flutterShareMe = FlutterShareMe();
    switch (share) {

      
      case Share.facebook:
        response = await flutterShareMe.shareToFacebook(url: url, msg: msg);
        break;
      case Share.twitter:
        response = await flutterShareMe.shareToTwitter(url: url, msg: msg);
        break;
      case Share.whatsapp:
          response = await flutterShareMe.shareToWhatsApp(msg: msg,);
        
        break;
      case Share.whatsapp_business:
        response = await flutterShareMe.shareToWhatsApp(msg: msg);
        break;
      case Share.share_system:
        response = await flutterShareMe.shareToSystem(msg: msg);
        break;
      case Share.share_instagram:
      case Share.messenger:
        // TODO: Handle this case.
        break;
      case Share.whatsapp_personal:
        // TODO: Handle this case.
        break;
      case Share.share_telegram:
        // TODO: Handle this case.
        break;
    }
    debugPrint(response);
  }

