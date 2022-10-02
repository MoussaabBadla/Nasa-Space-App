import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_space_app/UI/Screens/homepage.dart';
import 'package:nasa_space_app/UI/Screens/searchscreen.dart';

import '../../constant.dart';
import '../../logic/cubit/bloc/authentication_bloc.dart';
import '../../logic/cubit/bloc/login_bloc.dart';
import '../../repo/auth_repo.dart';
import 'get_started.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key, required this.userRepository}) : super(key: key);
  static const String route = '/auth';
  final UserRepository userRepository;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  int selectedindex = 0;
  late LoginBloc _loginBloc;
  late AuthenticationBloc _authenticationBloc;
  UserRepository get userRepository => widget.userRepository;

  final registerData = {};
  final loginData = {};

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(
      userRepository: userRepository,
      authenticationBloc: _authenticationBloc,
    );

    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  Future<void> register() async {
    FocusManager.instance.primaryFocus?.unfocus();

    _formKey.currentState!.save();

    _loginBloc.add(RegisterButtonPressed(registerData: registerData));
  }

  Future<void> login() async {
    FocusManager.instance.primaryFocus?.unfocus();

    _formKey.currentState!.save();

    _loginBloc.add(LoginButtonPressed(loginData: loginData));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          body: BackGround(
              child: SingleChildScrollView(
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 300),
                    padding: selectedindex==1 ? EdgeInsets.zero : EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                              children: [
                                NasaTitle(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                    'Welcome to the art-ship',
                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textfield(registerData: registerData, mapkey: "email"),
                      Textfield(registerData: registerData, mapkey: "password"),
                    if(selectedindex==0)
                      Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ), 
                                       if(selectedindex==1)
                                                           Textfield(registerData: registerData, mapkey: "username"),
                                       if(selectedindex==1)
                                                           Textfield(registerData: registerData, mapkey: "phone"),
                  
                   
                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                                  child: ElevatedButton(
                    
                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffE5F3FF),
                      shape: RoundedRectangleBorder(
                         borderRadius: borderRadius
                       ),
                                   
                      minimumSize: Size(312, 48)
                                
                    ),
                    onPressed: state is! LoginLoading
                                            ? () {
                                                if (selectedindex == 1) {
                                                  register();
                                                } else {
                                                  login();
                                                }
                                              }
                                            : null, child: Row(
                                              children: [
                                                Image.asset('assets/images/authvector.png'),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                                  child: Text(selectedindex == 0? 'Log in to NASART':'Sign up for NAZART',style: Theme.of(context).textTheme.bodyMedium,),
                                                ),
                                              ],
                                            )),
                                ),
                  
                                Authbutton(text: 'Log in with Google',image: 'google',),
                              Authbutton(text: 'Log in with Apple',image: 'apple',),
                                Text(selectedindex == 0 ? 'Don’t have an account?' : 'Already have an account',                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16),
                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                                  child: ElevatedButton(
                    
                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffE5F3FF),
                      shape: RoundedRectangleBorder(
                         borderRadius: borderRadius
                       ),
                                   
                      minimumSize: Size(312, 48)
                                
                    ),
                    onPressed: (){
                      setState(() {
                         selectedindex== 1 ?
                        selectedindex =0  : selectedindex=1;
                      });
                    }, child: Row(
                                              children: [
                                                Image.asset('assets/images/authvector.png'),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                                  child: Text(selectedindex == 1? 'Log in to NASART':'Sign up for NAZART',style: Theme.of(context).textTheme.bodyMedium,),
                                                ),
                                              ],
                                            )),
                                ),
                                SizedBox(height: 20,),
                  
                                GestureDetector(
                               onTap: (){
                    Navigator.of(context).pushAndRemoveUntil(
                     MaterialPageRoute<void>(builder: (BuildContext context) => const Homepage()),
                     ModalRoute.withName(Homepage.route),
                                 
                                 
                    );},
                                  child: Container(
                    width: 160,
                    height: 36,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                         color: Colors.transparent,
                         borderRadius: borderRadius,
                         border: Border.all(color: Color(0xffE5F3FF).withOpacity(0.6))
                      ),
                      child: Text('Skip For Now',style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),),
                                
                                  ),
                                )
                  
                              ],
                            ),
                  ))),
        );
      },
    );
  }
}

class Authbutton extends StatelessWidget {
  const Authbutton({
    super.key, required this.image, required this.text,
  });
  final String image; 
  final String text ; 
  @override
  Widget build(BuildContext context) {
    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
     child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: 312,
      height: 48,
      decoration: BoxDecoration(
         color: Colors.transparent,
         borderRadius: borderRadius,
         border: Border.all(color: Color(0xffE5F3FF))
      ),
      child:Row(
                                  children: [
                                    Image.asset('assets/images/$image.png'),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Text(text,style: Theme.of(context).textTheme.labelSmall,),
                                    ),
                                  ],
                                ))
    );
  }
}

class Textfield extends StatelessWidget {
  const Textfield(
      {super.key,
      required this.registerData,
      required this.mapkey,
      this.loginData});

  final Map registerData;
  final Map? loginData;

  final String mapkey;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: 312,
        height: 48,
        child: TextFormField(
          onSaved: (value) {
            registerData[mapkey] = value!;
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(color: darkblue30)),
            focusedBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(color: darkblue30)),
            hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 15,
                fontWeight: FontWeight.bold),
            hintText: mapkey[0].toUpperCase() + mapkey.substring(1),
          ),
        ),
      ),
    );
  }
}
