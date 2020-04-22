class City {
  //--- Name Of City
  final String name;
  //-- image
  final String image;
  //--- population
  final String population;
  //--- country
  final String country;

  City({this.name, this.country, this.population, this.image});

  static List<City> allCities() {
    var lstOfCities = new List<City>();

    lstOfCities.add(new City(
        name: "Delhi",
        country: "India",
        population: "19 mill",
        image: "https://www.ahstatic.com/photos/9399_ho_00_p_1024x768.jpg"));
    lstOfCities.add(new City(
        name: "London",
        country: "Britain",
        population: "8 mill",
        image: "https://www.vivendo.co/sites/default/files/field/image/que_es_un_condominio_residencial_conoce_alguna_de_sus_ventajas-02.jpg"));
    lstOfCities.add(new City(
        name: "Vancouver",
        country: "Canada",
        population: "2.4 mill",
        image: "https://www.ciudaris.com/blog/wp-content/uploads/ciudaris-diferencia-condominio-departamento.jpg"));
    lstOfCities.add(new City(
        name: "New York",
        country: "USA",
        population: "8.1 mill",
        image: "https://r-cf.bstatic.com/images/hotel/max1024x768/180/180866728.jpg"));
    lstOfCities.add(new City(
        name: "Paris",
        country: "France",
        population: "2.2 mill",
        image: "https://definicion.de/wp-content/uploads/2009/02/condominio.jpg"));
    lstOfCities.add(new City(
        name: "Berlin",
        country: "Germany",
        population: "3.7 mill",
        image: "https://staticw.s3.amazonaws.com/inmuebles/238501320190610121120.jpg"));
    return lstOfCities;
  }
}
