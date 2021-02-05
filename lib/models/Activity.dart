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
  }

  String getImgLink(){
    return imgLink;
  }

  String getCategory(){
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
    Name: $name
    Image Link: $imgLink
    Category: $category
    Time: $time
    Description: $description
    ''';
  }
}