const String base= "https://retail.amit-learning.com/api";


const String REGISTER_URL='$base/register';
const String LOGIN_URL='$base/login';
const String GET_PRODUCTS_URL='$base/products';
const String GET_CATEGORIES_URL='$base/categories';
const String CART_URL='$base/user/products';
// const String ADD_TO_CART_URL='$base/user/products';

// http://retail.amit-learning.com/api/user/products

String getAddToCartUrl({String productId})=>'$base/user/products/$productId';




