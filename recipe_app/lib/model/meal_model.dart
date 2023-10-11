class Meal {
  final int id;
  final String title, imgURL;

  Meal({
    this.id,
    this.title,
    this.imgURL
});


/* Lecture 45
Factory Constructor Meal.fromMap parses the decoded JSON data to get the values of the meal, and returns the Meal Object
*/

  factory Meal.fromMap(Map<String, dynamic> map) {
    //Meal object
    return Meal(
      id: map['id'],
      title: map['title'],
      imgURL: map['sourceUrl'],
    );
  }
}