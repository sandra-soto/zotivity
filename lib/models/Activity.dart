import 'package:zotivity/models/activityCategory.dart';
class Activity {
  ActivityCategory category;
  String title, imgLink, description, resources;
  int time;

// Todo: fix default parameters to point to a blank image or smth
  Activity(title, category, time, description, [imgLink="", resources=""]){
    this.title = title;
    this.imgLink = imgLink;
    this.category = category;
    this.time = time;
    this.description = description;
    this.resources = resources;
  }

  String getName(){
    return title;
  }

  String getImgLink(){
    return imgLink;
  }

  ActivityCategory getCategory() {
    return category;
  }

  int getTime(){
    return time;
  }

  String getDescription(){
    return description;
  }

  @override
  String toString(){
    return '''
    Title: $title
    Image Link: $imgLink
    Category: $category
    Time: $time
    Description: $description
    ''';
  }
}