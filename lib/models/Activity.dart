<<<<<<< HEAD
class Activity {
  String name, imgLink, category, description;
  int time;

  Activity(name, imgLink, category, time, description){
    this.name = name;
    this.imgLink = imgLink;
    this.category = category;
    this.time = time;
    this.description = description;
  }

  String getName(){
    return name;
=======
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
>>>>>>> ad831fdc1cf08b9d07a0874311b1b1400b8cb742
  }

  String getImgLink(){
    return imgLink;
  }

<<<<<<< HEAD
  String getCategory(){
=======
  ActivityCategory getCategory() {
>>>>>>> ad831fdc1cf08b9d07a0874311b1b1400b8cb742
    return category;
  }

  int getTime(){
    return time;
  }

<<<<<<< HEAD
=======
  int getIntensity() {
    return intensity;
  }

  BodyFocus getFocus() {
    return focus;
  }

>>>>>>> ad831fdc1cf08b9d07a0874311b1b1400b8cb742
  String getDescription(){
    return description;
  }

<<<<<<< HEAD
  @override
  String toString(){
    return '''
    Name: $name
    Image Link: $imgLink
    Category: $category
    Time: $time
    Description: $description
=======
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
>>>>>>> ad831fdc1cf08b9d07a0874311b1b1400b8cb742
    ''';
  }
}