import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nasa_space_app/UI/Screens/authscreen.dart';
import 'package:nasa_space_app/UI/Screens/homepage.dart';
import 'package:nasa_space_app/UI/Screens/searchscreen.dart';
import 'package:nasa_space_app/constant.dart';
import 'package:nasa_space_app/repo/auth_repo.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
               BackGround(
                 child: Column(children: [
                  SizedBox(
                    width: 275,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                       const NasaTitle(),
                                      Text('Ceize the chance to discover NASA’s splendid, diverse and eye-pleasing imagery.',
                                      textAlign: TextAlign.center,
                                      style:  Theme.of(context).textTheme.titleMedium),
               
                    ],
                  )), 
                  const SizedBox(height: 50,),
                  Container(
                    width: 304,
                    height: 454,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12) ,
                    border: Border.all(color: Color(0xffE5F3FF).withOpacity(0.3) , width: 0.8),
                    gradient: LinearGradient(colors: [Colors.white.withOpacity(0.02),Colors.white.withOpacity(0),],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                   child: BackdropFilter(
                     filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                     child: LayoutBuilder(
                             builder: (BuildContext context, BoxConstraints constraints) {
               final Size biggest = constraints.biggest;
                      return Stack(
                         children: [
                           PositionedTransition(
               
                             rect: RelativeRectTween(
                  begin: RelativeRect.fromSize(
                      const   Rect.fromLTWH(0, 0, 588 , 588), biggest),
                  end: RelativeRect.fromSize(
                      Rect.fromLTWH(biggest.width - 588,
                          biggest.height - 588, 588, 680),
               biggest
                      )
                             ).animate(CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeInOutCubic,
                             )),
               
                             child: Image.asset(
                             
                             "assets/images/bg.png",width: 588 , height: 697,fit: BoxFit.none,), )
                         ],
                             );
                 }),
                   ),
                 ),
               
                  ),
                            const    SizedBox(height: 50,),
                  ElevatedButton(
                    
                             style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffE5F3FF),
                  shape: RoundedRectangleBorder(
                     borderRadius: borderRadius
                   ),
               
                  minimumSize: Size(260, 48)
                             ),
                             onPressed: (){
                  Navigator.of(context).pushAndRemoveUntil(
                   MaterialPageRoute<void>(builder: (BuildContext context) => AuthScreen(userRepository: UserRepository())),
                   ModalRoute.withName(AuthScreen.route)
               
               
                  );
                             } ,child: Text('Get Started',style: Theme.of(context).textTheme.bodyMedium,),)
                             ]),
               ),
            
          
        
      
    );
  }
}

class BackGroundimage extends StatelessWidget {
  const BackGroundimage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration:   BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/backgroundimage.png'), fit: BoxFit.cover)
      ),
    );
  }
}

class NasaTitle extends StatelessWidget {
  const NasaTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text('NASART', style: Theme.of(context).textTheme.titleLarge,);
  }
}