class ValueManager {
  static const baseUrl = 'https://restaurant-api.dicoding.dev';
  static const noInternet = 'Tidak ada koneksi internet';

  static String smallRes(String pictureId) {
    return 'https://restaurant-api.dicoding.dev/images/small/$pictureId';
  }

  static String mediumRes(String pictureId) {
    return 'https://restaurant-api.dicoding.dev/images/medium/$pictureId';
  }

  static String largeRes(String pictureId) {
    return 'https://restaurant-api.dicoding.dev/images/large/$pictureId';
  }
}
