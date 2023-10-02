class EndPoints {
  static String baseUrl = 'https://codingarabic.online/api';
  static String registerEndpoint = '/register';
  static String loginEndpoint = '/login';
  static String sliderEndpoint = '/sliders';
  static String bestSellerEndpoint = '/products-bestseller';
  static String newArrivalsEndpoint = '/products-new-arrivals';
  static String categoriesEndpoint = '/categories';
  static String searchEndpoint(String name,int page)=>'/products-search?name=$name&page=$page';

}
