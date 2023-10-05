class EndPoints {
  static String baseUrl = 'https://codingarabic.online/api';
  static String registerEndpoint = '/register';
  static String loginEndpoint = '/login';
  static String sliderEndpoint = '/sliders';
  static String bestSellerEndpoint = '/products-bestseller';
  static String newArrivalsEndpoint = '/products-new-arrivals';
  static String categoriesEndpoint = '/categories';
  static String favouritesEndpoint(int page)=> '/wishlist?page=$page';
  static String cartEndpoint = '/cart';
  static String updateCartEndpoint = '/update-cart';
  static String removeFavouritesEndpoint = '/remove-from-wishlist';
  static String removeCartEndpoint = '/remove-from-cart';
  static String addFavouritesEndpoint = '/add-to-wishlist';
  static String addCartEndpoint = '/add-to-cart';
  static String updateProfileEndpoint = '/update-profile';
  static String searchEndpoint(String name,int page)=>'/products-search?name=$name&page=$page';

}
