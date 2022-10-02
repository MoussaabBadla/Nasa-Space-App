import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_space_app/UI/Screens/get_started.dart';
import 'package:nasa_space_app/UI/Screens/searchscreen.dart';
import 'package:nasa_space_app/constant.dart';

import '../../logic/cubit/cubit/imageoftheday_cubit.dart';
import '../../logic/cubit/search_cubit.dart';

class Homepage extends StatefulWidget {
  static const String route = '/homepage';
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    context.read<ImageofthedayCubit>().getimageofday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackGround(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 127,
                width: 275,
                child: Column(
                  children: [
                    const NasaTitle(),
                    Text(
                      'Roses Are Red \n Violets Are Blue \n Creative Are Words \n Screens To Glow',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            const CostumTextfield(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: List.generate(
                    bottunslist.length,
                    (index) => SugChips(
                          index: index,
                          Sug: bottunslist,
                        )),
              ),
            ),
            BlocBuilder<ImageofthedayCubit, ImageState>(
              builder: (context, state) {
                if(state is Getimage){
                        return Container(
                  height: 350,
                  width: 310,
                  decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      border: Border.all(color: darkblue, width: 1)),
                  child: Column(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        child: Image.network(
                          state.imageOfTheDaY.href,
                          fit: BoxFit.none,
                          width: 310,
                          height: 265.13,
                        )),
                    Container(
                      height: 80,
                      width: 310,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.04)
                      ])),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  'Picture of the day',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
state.imageOfTheDaY.title,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.labelSmall,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ) ]),
                );

                }
                 return CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    ));
  }
}

class SugChips extends StatelessWidget {
  const SugChips({
    super.key,
    required this.index,
    required this.Sug,
  });
  final int index;
  final List<String> Sug;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          context.read<SearchCubit>().getdata(Sug[index]);
          Navigator.pushNamed(context, Search.route);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: borderRadius,
              border: Border.all(color: darkblue.withOpacity(0.6))),
          child: Text(
            Sug[index],
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}

class CostumTextfield extends StatelessWidget {
  const CostumTextfield({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        width: 340,
        child: ClipRRect(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: TextField(
                cursorColor: darkblue30,
                onSubmitted: (value) {
                  FocusManager.instance.primaryFocus?.unfocus();

                  Navigator.of(context)
                      .pushNamed(Search.route, arguments: value);
                  context.read<SearchCubit>().getdata(value);
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: darkblue30,
                    ),
                    hintText: 'Through NASA’s imagery dataset',
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide: BorderSide(color: darkblue30)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: borderRadius,
                        borderSide: BorderSide(color: darkblue30))
                        
                        ),
              )),
        ));
  }
}
