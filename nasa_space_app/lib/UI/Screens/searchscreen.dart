import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_space_app/UI/Screens/get_started.dart';
import 'package:nasa_space_app/UI/Screens/homepage.dart';
import 'package:nasa_space_app/constant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/content.dart';
import '../../models/logic/cubit/search_cubit.dart';

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
              return        Expanded(
                  child: PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
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
                                            state.contents[ind].href,
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
                                            state.contents[ind].title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 8),
                                          child: Text(
                                            state.contents[ind].description
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
                                            state.contents[ind].date_created,
                                            style: TextStyle(
                                              color: darkblue.withOpacity(0.9),
                                              fontSize: 10,
                                              fontFamily: 'Nasalization',
                                            ),
                                          ),
                                        ),
                                        Wrap(
                                          children: List.generate(
                                              state.contents[ind].keywords.length,
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
                                                        child: Text(
                                                          state.contents[ind].keywords[index],
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
                                                    share ? () {} : () {},
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
                                                    share ? () {} : () {},
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
