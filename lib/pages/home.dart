import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoe_plug/core/assets.dart';
import 'package:shoe_plug/core/colors.dart';
import 'package:shoe_plug/core/spacing.dart';
import 'package:shoe_plug/core/style.dart';
import 'package:shoe_plug/models/brand_logo.dart';
import 'package:shoe_plug/notifier/cart_notifier.dart';
import 'package:shoe_plug/pages/category.dart';
import 'package:shoe_plug/pages/widgets/home_sections.dart';
import 'package:shoe_plug/pages/widgets/preview_card.dart';
import 'package:shoe_plug/pages/widgets/product_card.dart';

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
    BrandLogo(logo: AppIcons.gucci, name: "Gucci"),
    BrandLogo(logo: AppIcons.reebok, name: "Reebok"),
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
      if (CartNotifier.instance.timbuResponse.products == null) {
        fetch();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final cartNotifier = CartNotifier.instance;
    final errorOccured = cartNotifier.timbuResponse.errorMessage != null;

    final isLoadingTimbu = cartNotifier.timbuResponse.isLoading == true;

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
              isLoadingTimbu
                  ? const ShimmerLoading()
                  : const ProductPreviewCard(),
              ySpacing(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  row1.length,
                  (index) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPage(
                            brand: row1[index].name,
                            products: cartNotifier
                                .categoriseProduct(row1[index].name),
                          ),
                        ),
                      );
                    },
                    child: Column(
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
              ),
              ySpacing(32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  row2.length,
                  (index) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPage(
                            brand: row2[index].name,
                            products: cartNotifier
                                .categoriseProduct(row2[index].name),
                          ),
                        ),
                      );
                    },
                    child: Column(
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
              ),
              ySpacing(24),
              Visibility(
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
                        height: screenHeight * 0.52,
                        child: SpecialOfferSection(
                          isLoading: isLoadingTimbu,
                          offers: cartNotifier.timbuResponse.products
                                  ?.take(6)
                                  .toList() ??
                              [],
                        )),
                    ySpacing(12),
                    SizedBox(
                      height: screenHeight * 0.54,
                      child: FeaturedSection(
                        isLoading: isLoadingTimbu,
                        offers: cartNotifier.timbuResponse.products
                                ?.sublist(6)
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

