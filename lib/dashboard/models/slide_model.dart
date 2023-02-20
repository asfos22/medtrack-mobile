class SliderModel {
  String? imageAssetPath;
  String? title;
  String? desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String? getImageAssetPath() {
    return imageAssetPath;
  }

  String? getTitle() {
    return title;
  }

  String? getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = <SliderModel>[];
  SliderModel sliderModel = SliderModel();

  //1 note setImageAssetPath is optional ,may be added by medtrack team
  sliderModel.setTitle("Discover");
  sliderModel.setDesc("Discover new or trending hairstyle\n inspirations");
  slides.add(sliderModel);

  sliderModel = SliderModel();

  //2
  sliderModel.setTitle("Discover");
  sliderModel.setDesc("Discover new or trending hairstyle \ninspirations");
  slides.add(sliderModel);

  sliderModel = SliderModel();

  //3
  sliderModel.setTitle("Discover");
  sliderModel.setDesc("Discover new or trending hairstyle \ninspirations");
  slides.add(sliderModel);

  sliderModel = SliderModel();

  return slides;
}
