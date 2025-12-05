import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/providers/wishlist_provider.dart';
import '../network_image_with_loader.dart';

class EnhancedProductCard extends StatelessWidget {
  const EnhancedProductCard({
    super.key,
    required this.product,
    required this.press,
    this.showWishlistButton = true,
  });

  final ProductModel product;
  final VoidCallback press;
  final bool showWishlistButton;

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, _) {
        final isInWishlist = wishlistProvider.isInWishlist(product);

        return OutlinedButton(
          onPressed: press,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(140, 220),
            maximumSize: const Size(140, 220),
            padding: const EdgeInsets.all(8),
          ),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.15,
                child: Stack(
                  children: [
                    NetworkImageWithLoader(
                      product.image,
                      radius: defaultBorderRadious,
                    ),
                    if (product.dicountpercent != null)
                      Positioned(
                        right: defaultPadding / 2,
                        top: defaultPadding / 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2,
                          ),
                          height: 16,
                          decoration: const BoxDecoration(
                            color: errorColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(defaultBorderRadious),
                            ),
                          ),
                          child: Text(
                            "${product.dicountpercent}% off",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    if (showWishlistButton)
                      Positioned(
                        left: defaultPadding / 2,
                        top: defaultPadding / 2,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              wishlistProvider.toggleWishlist(product);
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.9),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                isInWishlist
                                    ? "assets/icons/Bookmark.svg"
                                    : "assets/icons/Bookmark.svg",
                                height: 16,
                                colorFilter: ColorFilter.mode(
                                  isInWishlist ? errorColor : Colors.grey,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding / 2,
                    vertical: defaultPadding / 2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.brandName.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 10),
                      ),
                      const SizedBox(height: defaultPadding / 2),
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 12),
                      ),
                      const Spacer(),
                      product.priceAfetDiscount != null
                          ? Row(
                              children: [
                                Text(
                                  "\$${product.priceAfetDiscount!.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    color: Color(0xFF31B0D8),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: defaultPadding / 4),
                                Text(
                                  "\$${product.price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color,
                                    fontSize: 10,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              "\$${product.price.toStringAsFixed(2)}",
                              style: const TextStyle(
                                color: Color(0xFF31B0D8),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

