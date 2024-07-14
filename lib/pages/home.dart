import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoe_plug/core/assets.dart';
import 'package:shoe_plug/core/colors.dart';
import 'package:shoe_plug/core/spacing.dart';
import 'package:shoe_plug/core/style.dart';
import 'package:shoe_plug/models/brand_logo.dart';
import 'package:shoe_plug/models/product.dart';
import 'package:shoe_plug/notifier/cart_notifier.dart';
import 'package:shoe_plug/pages/details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final row1 = const [
    BrandLogo(logo: AppIcons.adidas, name: "Adidas"),
    BrandLogo(logo: AppIcons.balenciaga, name: "Balenciaga"),
    BrandLogo(logo: AppIcons.jordan, name: "Jordan"),
  ];

  final row2 = const [
    BrandLogo(logo: AppIcons.nike, name: "Nike"),
    BrandLogo(logo: AppIcons.jordan, name: "Jordan"),
    BrandLogo(logo: AppIcons.balenciaga, name: "Balenciaga"),
  ];
  bool isLoading = false;
  void fetch() async {
    setState(() {
      isLoading = true;
    });

    await CartNotifier.instance.getProductsFromTimbu();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    final cartNotifier = CartNotifier.instance;
    final errorOccured = cartNotifier.timbuResponse.errorMessage != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          AppImages.logo,
          width: screenWidth * 0.36,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: SvgPicture.asset(AppIcons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.orage,
                    child: Text(
                      "AD",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Good afternoon 👋🏽"),
                      Text(
                        "Ada Dennis",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF0072C6),
                      Color(0xFF003760),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: screenWidth * 0.4,
                        child: Image.asset(AppImages.iconic)),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Iconic Casual Brands",
                          style: styleWith(size: 8, color: AppColors.gray50),
                        ),
                        Text(
                          "Ego Vessel ₦ 37,000.00",
                          style: styleWith(
                            size: 12,
                            color: Colors.white,
                            weight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size.fromHeight(30),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(AppIcons.cart),
                                xSpacing(8),
                                Text(
                                  "Add to cart",
                                  style: styleWith(
                                    color: AppColors.blue,
                                    size: 12,
                                    weight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              ySpacing(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  row1.length,
                  (index) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.gray50,
                        child: SvgPicture.asset(row1[index].logo),
                      ),
                      ySpacing(4),
                      Text(
                        row1[index].name,
                        style: styleWith(
                          size: 10,
                          weight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ySpacing(32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  row2.length,
                  (index) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.gray50,
                        child: SvgPicture.asset(
                          row2[index].logo,
                        ),
                      ),
                      ySpacing(4),
                      Text(
                        row2[index].name,
                        style: styleWith(
                          size: 10,
                          weight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ySpacing(24),
              cartNotifier.timbuResponse.isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Visibility(
                      visible: !errorOccured,
                      replacement: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Error Occurred:\n${cartNotifier.timbuResponse.errorMessage}",
                              style: TextStyle(color: Colors.red.shade500),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: fetch,
                              child: const Text(
                                "R E T R Y",
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                              height: 680,
                              child: SpecialOfferSection(
                                offers: cartNotifier.timbuResponse.products
                                        ?.take(4)
                                        .toList() ??
                                    [],
                              )),
                          ySpacing(12),
                          SizedBox(
                            height: 680,
                            child: FeaturedSection(
                              offers: cartNotifier.timbuResponse.products
                                      ?.sublist(4)
                                      .toList() ??
                                  [],
                            ),
                          ),
                          ySpacing(32),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class SpecialOfferSection extends StatelessWidget {
  const SpecialOfferSection({required this.offers, super.key});
  final List<Product> offers;
  /*final offers = const [
    Product(
      id: '',
      amount: 200,
      image: AppImages.hilly,
      name: "Hilfiger Don Know",
      description:
          "The Hilfiger Don Know is the perfect addition to your casual wardrobe. Pair them with jeans, joggers, or even a dress for an effortlessly cool look that's sure to make a statement. Whether you're running errands or hitting the town, these versatile sneakers will keep you feeling and looking your best.",
      section: "Athletic/Sportswear",
    ),
    Product(
      id: '',
      amount: 200,
      image: AppImages.iconic,
      name: "Iconic Know",
      description:
          "The Iconic Know is the perfect addition to your casual wardrobe. Pair them with jeans, joggers, or even a dress for an effortlessly cool look that's sure to make a statement. Whether you're running errands or hitting the town, these versatile sneakers will keep you feeling and looking your best.",
      section: "Casual Wear",
    ),
    Product(
      id: '',
      amount: 200,
      image: AppImages.pexel1,
      name: "Pexel Fashy",
      description:
          "The Pexel Fashy Don Know is the perfect addition to your casual wardrobe. Pair them with jeans, joggers, or even a dress for an effortlessly cool look that's sure to make a statement. Whether you're running errands or hitting the town, these versatile sneakers will keep you feeling and looking your best.",
      section: "Luxury Fashion",
    ),
    Product(
      amount: 200,
      image: AppImages.iconic,
      name: "Jordy May",
      description:
          "The Jordy May Know is the perfect addition to your casual wardrobe. Pair them with jeans, joggers, or even a dress for an effortlessly cool look that's sure to make a statement. Whether you're running errands or hitting the town, these versatile sneakers will keep you feeling and looking your best.",
      section: "Athletic/Sportswear",
      id: '',
    ),
  ];
 
 */
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Our Special Offers",
          style: styleWith(size: 24, weight: FontWeight.w500),
        ),
        ySpacing(20),
        Expanded(
          child: GridView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.5, crossAxisCount: 2, crossAxisSpacing: 20),
            children: List.generate(
              offers.length,
              (index) => ProductCard(
                product: offers[index],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({required this.offers, super.key});
  final List<Product> offers;
  /*final offers = const [
    Product(
      id: '',
      amount: 200,
      image: AppImages.woman,
      name: "Wommy Runny",
      description:
          "The Wummy Runny Don Know is the perfect addition to your casual wardrobe. Pair them with jeans, joggers, or even a dress for an effortlessly cool look that's sure to make a statement. Whether you're running errands or hitting the town, these versatile sneakers will keep you feeling and looking your best.",
      section: "Running Sneaker",
    ),
    Product(
      id: '',
      amount: 200,
      image: AppImages.sport,
      name: "Gbabe Spy",
      description:
          "The Gbabe Spy is the perfect addition to your casual wardrobe. Pair them with jeans, joggers, or even a dress for an effortlessly cool look that's sure to make a statement. Whether you're running errands or hitting the town, these versatile sneakers will keep you feeling and looking your best.",
      section: "Running Sneaker",
    ),
    Product(
      id: '',
      amount: 200,
      image: AppImages.pexel1,
      name: "Pexel Icy",
      description:
          "The Pexel Icy Don Know is the perfect addition to your casual wardrobe. Pair them with jeans, joggers, or even a dress for an effortlessly cool look that's sure to make a statement. Whether you're running errands or hitting the town, these versatile sneakers will keep you feeling and looking your best.",
      section: "Luxury Fashion",
    ),
    Product(
      id: '',
      amount: 200,
      image: AppImages.iconic,
      name: "Jordy May",
      description:
          "The Jordy May Know is the perfect addition to your casual wardrobe. Pair them with jeans, joggers, or even a dress for an effortlessly cool look that's sure to make a statement. Whether you're running errands or hitting the town, these versatile sneakers will keep you feeling and looking your best.",
      section: "Athletic/Sportswear",
    ),
  ];
 
 */
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Featured Sneakers",
          style: styleWith(size: 24, weight: FontWeight.w500),
        ),
        ySpacing(20),
        Expanded(
          child: GridView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.5, crossAxisCount: 2, crossAxisSpacing: 20),
            children: List.generate(
              offers.length,
              (index) => ProductCard(
                product: offers[index],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({
    required this.product,
    this.isSpecialOffer = true,
    super.key,
  });
  final Product product;
  final bool isSpecialOffer;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final cartNotifier = CartNotifier.instance;
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(product: widget.product),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(widget.product.image),
                )),
          ),
          ySpacing(4),
          Text(
            widget.product.section,
            style: styleWith(size: 10),
          ),
          ySpacing(2),
          Text(
            widget.product.name,
            style: styleWith(
              size: 12,
              weight: FontWeight.w600,
            ),
          ),
          ySpacing(4),
          Row(
            children: [
              const Icon(
                Icons.star_half,
                size: 12,
                color: AppColors.lightYellow,
              ),
              xSpacing(2),
              Text(
                "4.5 (100 sold)",
                style: styleWith(size: 10, weight: FontWeight.w500),
              )
            ],
          ),
          ySpacing(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "₦ ${widget.product.amount}",
                    style: styleWith(
                        size: 12,
                        weight: FontWeight.w600,
                        color: AppColors.blue),
                  ),
                  ySpacing(2),
                  widget.isSpecialOffer
                      ? Text(
                          "₦ 21,000.00",
                          style: styleWith(
                                  size: 12,
                                  weight: FontWeight.w500,
                                  color: AppColors.gray200)
                              .copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: AppColors.gray200),
                        )
                      : const SizedBox()
                ],
              ),
              InkWell(
                onTap: () {
                  cartNotifier.addToCart(widget.product);
                  setState(() {});
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.blue.withAlpha(12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: cartNotifier.productsInCart
                            .where((element) => element.id == widget.product.id)
                            .isNotEmpty
                        ? const Icon(
                            Icons.shopping_basket,
                            color: AppColors.blue,
                            size: 16,
                          )
                        : SvgPicture.asset(AppIcons.cart),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
