import 'package:zotivity/models/activityCategory.dart';
import 'package:zotivity/models/BodyFocus.dart';
import 'package:zotivity/models/Equipment.dart';

class Activity {
  ActivityCategory category;
  BodyFocus focus;
  String title, imgLink, description, resources;
  int time, intensity;  // intensity can be from 0 - 2? 0 = easy to 2 = hard
  List<Equipment> equipment; // idk if list or map is best here

// Todo: fix default parameters to point to a blank image or smth
  Activity(title, category, time, intensity, focus, description, equipment, [imgLink="", resources=""]){
    this.title = title;
    this.imgLink = imgLink;
    this.category = category;
    this.time = time;
    this.intensity = intensity;
    this.focus = focus;
    this.description = description;
    this.equipment = equipment;
    this.resources = resources;
  }

  String getTitle(){
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

  int getIntensity() {
    return intensity;
  }

  BodyFocus getFocus() {
    return focus;
  }

  String getDescription(){
    return description;
  }

  List<Equipment> getEquipment() {
    return equipment;
  }

  String getResources() {
    return resources;
  }

  @override
  String toString(){
    return '''
    Title: $title
    Image Link: $imgLink
    Category: $category
    Time: $time
    Intensity: $intensity
    Focus: $focus
    Description: $description
    Resources: $resources
    Equipment: $equipment
    ''';
  }
}