# Shopaholic 🛍️

A modern, feature-rich e-commerce shopping app built with Flutter. Experience seamless shopping with cart management, wishlist, search, filters, dark mode, and much more!

## ✨ Features

### 🛒 Shopping Cart
- **Persistent Cart**: Your cart items are saved locally and persist across app restarts
- **Add/Remove Items**: Easily add products to cart or remove them
- **Quantity Management**: Increase or decrease item quantities with intuitive controls
- **Size & Color Selection**: Select product variants (size and color) when adding to cart
- **Cart Badge**: See cart item count in the bottom navigation bar
- **Empty Cart State**: Beautiful empty state when cart is empty

### ❤️ Wishlist
- **Save Favorites**: Add products to your wishlist with a single tap
- **Persistent Storage**: Wishlist items are saved locally
- **Quick Access**: Access your wishlist from the bookmark tab or profile menu
- **Visual Feedback**: See which items are in your wishlist

### 🎨 Dark Mode
- **Theme Toggle**: Switch between light and dark themes
- **Persistent Preference**: Your theme choice is saved
- **Beautiful UI**: Carefully designed dark theme for comfortable viewing

### 📱 Modern UI/UX
- **Smooth Animations**: Page transitions and interactions
- **Loading States**: Skeleton loaders and loading indicators
- **Error Handling**: Graceful error states throughout the app
- **Empty States**: Beautiful empty states for cart, wishlist, etc.
- **Responsive Design**: Works beautifully on all screen sizes

### 🏗️ Architecture
- **State Management**: Provider pattern for efficient state management
- **Local Storage**: SharedPreferences for data persistence
- **Clean Code**: Well-organized, maintainable codebase
- **Modular Design**: Reusable components and widgets

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.2.0)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd Shopaholic
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## 📦 Dependencies

- **provider**: State management
- **shared_preferences**: Local data persistence
- **cached_network_image**: Optimized image loading
- **flutter_svg**: SVG support
- **animations**: Smooth page transitions
- **flutter_rating_bar**: Product ratings
- **intl**: Internationalization
- **uuid**: Unique ID generation

## 🎯 Key Screens

- **Home**: Browse featured products, flash sales, and categories
- **Discover**: Explore products by category
- **Cart**: Manage your shopping cart
- **Wishlist**: View your saved items
- **Product Details**: View product information, reviews, and add to cart
- **Profile**: Manage account settings and preferences

## 🔧 State Management

The app uses Provider for state management with the following providers:

- **CartProvider**: Manages shopping cart state
- **WishlistProvider**: Manages wishlist state
- **ThemeProvider**: Manages theme (light/dark) state

## 📝 Future Enhancements

- [ ] Search functionality with filters
- [ ] Product reviews and ratings
- [ ] Order tracking
- [ ] Payment integration
- [ ] User authentication
- [ ] Backend API integration
- [ ] Push notifications
- [ ] Social sharing

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is open source and available under the MIT License.

---

Made with ❤️ using Flutter



