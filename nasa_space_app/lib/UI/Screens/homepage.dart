import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:nasa_space_app/UI/Screens/get_started.dart';
import 'package:nasa_space_app/constant.dart';

class Homepage extends StatelessWidget {
  static const String route  = '/homepage' ; 
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const BackGroundimage(),
        SafeArea(child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column
          (
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 127,
                width: 275,
                child: Column(
                  children: [
                    const NasaTitle()
                    ,
                    Text('Roses Are Red \n Violets Are Blue \n Creative Are Words \n Screens To Glow'
                    ,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,)
                    
                  ],
                )),
                const SizedBox(height: 20,),
                 const CostumTextfield(),
                 Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                   child: Wrap(
                    alignment: WrapAlignment.center,
                    children: List.generate(bottunslist.length, (index) => Padding(
                      padding: EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 13,vertical: 5),
                          decoration: BoxDecoration(
                                                  color: Colors.transparent,
                    
                            borderRadius: borderRadius,
                            border: Border.all(
                              color: darkblue.withOpacity(0.6)
                            )
                          ),
                          child: Text(bottunslist[index],style: Theme.of(context).textTheme.bodySmall,),
                        ),
                      ),
                    )) ,
                   ),
                 ), 
                 Container(
                  height: 350,
                  width: 310,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    border: Border.all(color: darkblue,width: 1)
                  ),
                  child: Column(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)
                        ),
                        child: Image.asset(
                        
                        'assets/images/spaceman.png',fit: BoxFit.none,
                        width: 310,height: 265.13,)),
                        Container(
                      
                          height: 80,
                          width: 310,
                          decoration: BoxDecoration(gradient: LinearGradient(colors: 
                          [
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.04)
                          ])),
                          child:ClipRect(
                            child: BackdropFilter(
                                   filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                             
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Column(
                                children: [
                                  Text('Picture of the day', style: Theme.of(context).textTheme.titleSmall,),
                                  Text('NASA astronaunts landed safely on planet Mars.',
                                  textAlign: TextAlign.center,
                                   style: Theme.of(context).textTheme.labelSmall,)
                                ],
                               ),
                             ),
                             ),
                          ) ,
                        )
                    
                  ]),
                 )
            ],
          ),
        ))
      ]),
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
        decoration:InputDecoration(
          prefixIcon: Icon(Icons.search, color: darkblue30,),
          hintText: 'Through NASA’s imagery dataset',
          hintStyle: Theme.of(context).textTheme.labelMedium,
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color:darkblue30)
           ),
           focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color:darkblue30)
           )
        ) ,
      )),
     ));
  }
}

