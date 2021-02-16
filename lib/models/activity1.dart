import 'package:zotivity/models/activityCategory.dart';

class Activity {
  ActivityCategory category;
  String title, description, resources;

  Activity(ActivityCategory _category, String _title,  String _description, String _resources) {
    category = _category;
    title = _title;
    description = _description;
    resources = _resources;
  }

  ActivityCategory getCategory() {
    return category;
  }

  String getTitle() {
    return title;
  }

  String getDescription() {
    return description;
  }

  String getResources() {
    return resources;
  }

  static List<ActivityCategory> getAllCategories() {
    return ActivityCategory.values;
  }
}