import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/content.dart';
import '../../../models/imageoftheday.dart';
import '../../../repo/datareposotry.dart';

part 'imageoftheday_state.dart';

class ImageofthedayCubit extends Cubit<ImageState> {
  ImageofthedayCubit() : super(ImageInitial());
    final DataRepo dataRepo = DataRepo();

  ImageOfTheDaY _imageOfTheDaY = ImageOfTheDaY(title: 'nasa_id',  href: 'href');
  ImageOfTheDaY get imageOfTheDaY => _imageOfTheDaY;

  
  Future<void> getimageofday()  async{
    emit(ImageLoading());
    try {
      _imageOfTheDaY = await dataRepo.imageoftheday();
      print(_imageOfTheDaY);
      emit(Getimage(imageOfTheDaY: _imageOfTheDaY));
    } catch (e) {
      print(e);
      emit(ImageFail());
      
    }
  }
}
