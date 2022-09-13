import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:full_e_commerce_app/utils/colors.dart';
import 'package:full_e_commerce_app/utils/dimensions.dart';
import 'package:full_e_commerce_app/widgets/app_column.dart';
import 'package:full_e_commerce_app/widgets/app_icon.dart';
import 'package:full_e_commerce_app/widgets/big_text.dart';
import 'package:full_e_commerce_app/widgets/expandable_text_widget.dart';

class PopularFoodDetails extends StatelessWidget {
  const PopularFoodDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: Dimensions.popularFoodImgSize,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/image/food0.png'),
                ),
              ),
            ),
          ),
          Positioned(
            left: Dimensions.width20,
            right: Dimensions.width20,
            top: Dimensions.height45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                AppIcon(icon: Icons.arrow_back_ios),
                AppIcon(icon: Icons.shopping_cart_checkout_outlined)
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppColumn(text: 'Chinese Side'),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  BigText(text: 'Introduce'),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ExpandableTextWidget(text: test,),
                    ),
                   )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(
          top: Dimensions.height30,
          bottom: Dimensions.height30,
          right: Dimensions.width20,
          left: Dimensions.width20,
        ),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20 * 2),
            topRight: Radius.circular(Dimensions.radius20 * 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  right: Dimensions.width20,
                  left: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
              ),
              child: Row(children: [
                const Icon(
                  Icons.remove,
                  color: AppColors.signColor,
                ),
                SizedBox(
                  width: Dimensions.width5,
                ),
                BigText(
                  text: '0',
                ),
                SizedBox(
                  width: Dimensions.width5,
                ),
                const Icon(
                  Icons.add,
                  color: AppColors.signColor,
                )
              ]),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  right: Dimensions.width20,
                  left: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Dimensions.radius20,
                  ),
                  color: AppColors.mainColor),
              child: BigText(
                text: '£10 Add to Cart',
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

String test =
    '''According to (World Health Organization, 2020), Malnutrition is characterized by deficiencies, excesses, or imbalances in a person's nutrient- and/or energy-intake. India battles tremendously with malnutrition and even the children are so affected. (De & Chattopadhyay, 2019) stated Children are particularly susceptible to malnutrition because they consume foods with poor nutritional content and because food is distributed inequitably among households. Additionally, due to inadequate care, young children experience frequent infections and a variety of illnesses that can have a deadly or developmentally delayed consequence.
Malnutrition has been for a very long time and many countries have suffered at it hand, it has led to the death of many. (Keusch, 2003) stated that Malnutrition increased a person's susceptibility to infection and that infection worsened nutritional status, starting a vicious cycle of malnutrition-infection that would eventually result in kwashiorkor (whose clinical manifestations were typically also brought on by an infection) and, if left untreated will lead to death. 
Malnutrition has cost India a lot and even affected the world economy. The cost of all types of malnutrition, including undernutrition, micronutrient deficiencies, and over nutrition, has been estimated at US3.5 trillion annually for the world economy. Investment in primary level prevention interventions like health promotion and education makes it interesting to learn from these historical data and studies (Sharma, 2021). While a lot of literature 
dealt with tackling malnutrition in India and even in children as  (Sahu et al., 2015) mentioned that India has a serious public health issue with malnutrition among children under the age of five, not many literatures tackled the problem of malnutrition by recommending effective health policies to help reduced it.
''';
