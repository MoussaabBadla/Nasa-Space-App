part of 'imageoftheday_cubit.dart';

@immutable
@immutable
abstract class ImageState {}

class ImageInitial extends ImageState {}
class ImageLoading extends ImageState{}

class Getimage extends ImageState{
  final ImageOfTheDaY imageOfTheDaY ; 
  Getimage({required this.imageOfTheDaY});
}
class ImageEmpry extends ImageState{}
class ImageFail extends ImageState{}
