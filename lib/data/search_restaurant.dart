class SearchRestaurant {
  SearchRestaurant({
    required this.error,
    required this.founded,
    required this.searchRestaurants,
  });

  bool error;
  int founded;
  List<SearchRestaurantResult> searchRestaurants;

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) =>
      SearchRestaurant(
        error: json["error"],
        founded: json["founded"],
        searchRestaurants: List<SearchRestaurantResult>.from(
            json["restaurants"].map((x) => SearchRestaurantResult.fromJson(x))),
      );
}

class SearchRestaurantResult {
  SearchRestaurantResult({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory SearchRestaurantResult.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantResult(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  String getSmallPicture() =>
      'https://restaurant-api.dicoding.dev/images/small/' + this.pictureId;
  String getMediumPicture() =>
      'https://restaurant-api.dicoding.dev/images/medium/' + this.pictureId;
  String getLargePicture() =>
      'https://restaurant-api.dicoding.dev/images/large/' + this.pictureId;
}
