import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:social_media_clone/http/models/posts/base_post_model.dart';
import 'package:social_media_clone/view/content/screens/post/display/business_detail_card.dart';
import 'package:social_media_clone/view/content/screens/post/display/service_detail_card.dart';

Widget buildContentTypeInfo(
    double sw, double sh, BuildContext context, PostModel postData) {
  final contentType = postData.contentType;

  switch (contentType) {
    case 'business':
      return _buildBusinessInfo(sw, sh, context, postData);
    case 'service':
      return _buildServiceInfo(sw, sh, context, postData);
    case 'product':
      return _buildProductInfo(sw, sh, postData);
    default:
      return SizedBox.shrink();
  }
}

Widget _buildBusinessInfo(
    double sw, double sh, BuildContext context, PostModel postData) {
  final businessData = postData.customization.business;

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BusinessDetailScreen(businessData: businessData!),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.only(
          top: sh * 0.0, bottom: sh * 0.02, left: sw * 0.04, right: sw * 0.04),
      padding: EdgeInsets.all(sw * 0.03),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF8A2BE2).withOpacity(0.1),
            Color(0xFF4B0082).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF8A2BE2).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.business, color: Color(0xFF8A2BE2), size: sh * 0.02),
              SizedBox(width: sw * 0.02),
              Expanded(
                child: Text(
                  businessData?.businessName ?? 'Business',
                  style: TextStyle(
                    fontSize: sh * 0.016,
                    fontFamily: 'Poppins-SemiBold',
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                businessData?.priceRange ?? 'Rs.',
                style: TextStyle(
                  fontSize: sh * 0.014,
                  fontFamily: 'Poppins-Medium',
                  color: Color(0xFF8A2BE2),
                ),
              ),
            ],
          ),

          // HIGHLIGHTED: Announcement Section
          if (businessData?.announcement != null &&
              businessData!.announcement!.isNotEmpty) ...[
            SizedBox(height: sh * 0.01),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(sw * 0.03),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.amber.shade50,
                    Colors.orange.shade50,
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade300, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.campaign,
                          color: Colors.amber.shade700, size: sh * 0.018),
                      SizedBox(width: sw * 0.015),
                      Text(
                        'ANNOUNCEMENT',
                        style: TextStyle(
                          fontSize: sh * 0.012,
                          fontFamily: 'Poppins-Bold',
                          color: Colors.amber.shade800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: sh * 0.005),
                  Text(
                    businessData?.announcement ?? '',
                    style: TextStyle(
                      fontSize: sh * 0.014,
                      fontFamily: 'Poppins-Medium',
                      color: Colors.amber.shade900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // HIGHLIGHTED: Promotions Section
          if (businessData?.promotions != null &&
              businessData!.promotions.isNotEmpty) ...[
            SizedBox(height: sh * 0.01),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(sw * 0.03),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red.shade50,
                    Colors.pink.shade50,
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade300, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_offer,
                          color: Colors.red.shade700, size: sh * 0.018),
                      SizedBox(width: sw * 0.015),
                      Text(
                        'SPECIAL OFFER',
                        style: TextStyle(
                          fontSize: sh * 0.012,
                          fontFamily: 'Poppins-Bold',
                          color: Colors.red.shade800,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: sw * 0.02, vertical: sh * 0.003),
                        decoration: BoxDecoration(
                          color: Colors.red.shade700,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${businessData.promotions[0].discount}% OFF',
                          style: TextStyle(
                            fontSize: sh * 0.011,
                            fontFamily: 'Poppins-Bold',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: sh * 0.005),
                  Text(
                    businessData.promotions[0].title,
                    style: TextStyle(
                      fontSize: sh * 0.015,
                      fontFamily: 'Poppins-SemiBold',
                      color: Colors.red.shade900,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: sh * 0.003),
                  Text(
                    businessData.promotions[0].description,
                    style: TextStyle(
                      fontSize: sh * 0.013,
                      fontFamily: 'Poppins-Medium',
                      color: Colors.red.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    ),
  );
}

Widget _buildServiceInfo(
    double sw, double sh, BuildContext context, PostModel postData) {
  final serviceData = postData.customization.service;

  return GestureDetector(
    onTap: () {
     
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ServiceDetailScreen(serviceData: serviceData),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.only(
          top: sh * 0.0, bottom: sh * 0.02, left: sh * 0.02, right: sh * 0.02),
      padding: EdgeInsets.all(sw * 0.03),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.1),
            Colors.indigo.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HIGHLIGHTED: Service Name
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(sw * 0.025),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade100,
                  Colors.indigo.shade100,
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade300, width: 2),
            ),
            child: Row(
              children: [
                Icon(Icons.room_service,
                    color: Colors.blue.shade700, size: sh * 0.022),
                SizedBox(width: sw * 0.02),
                Expanded(
                  child: Text(
                    serviceData?.name ?? '',
                    style: TextStyle(
                      fontSize: sh * 0.018,
                      fontFamily: 'Poppins-Bold',
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: sh * 0.01),

          // HIGHLIGHTED: Location & Price Row
          Container(
            padding: EdgeInsets.all(sw * 0.025),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade50,
                  Colors.teal.shade50,
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade300, width: 2),
            ),
            child: Column(
              children: [
                // Location
                Row(
                  children: [
                    Icon(Icons.location_on,
                        color: Colors.green.shade700, size: sh * 0.018),
                    SizedBox(width: sw * 0.015),
                    Text(
                      'LOCATION',
                      style: TextStyle(
                        fontSize: sh * 0.011,
                        fontFamily: 'Poppins-Bold',
                        color: Colors.green.shade800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${serviceData!.location.city}, ${serviceData!.location.state}',
                      style: TextStyle(
                        fontSize: sh * 0.014,
                        fontFamily: 'Poppins-SemiBold',
                        color: Colors.green.shade900,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.008),

                // Price
                Row(
                  children: [
                    Icon(Icons.currency_rupee,
                        color: Colors.green.shade700, size: sh * 0.018),
                    SizedBox(width: sw * 0.015),
                    Text(
                      'PRICE',
                      style: TextStyle(
                        fontSize: sh * 0.011,
                        fontFamily: 'Poppins-Bold',
                        color: Colors.green.shade800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${serviceData.currency} ${serviceData.price}',
                      style: TextStyle(
                        fontSize: sh * 0.016,
                        fontFamily: 'Poppins-Bold',
                        color: Colors.green.shade900,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: sh * 0.008),

          // Additional Service Info
          Row(
            children: [
              Icon(Icons.access_time,
                  color: Colors.grey.shade600, size: sh * 0.015),
              SizedBox(width: sw * 0.01),
              Text(
                '${serviceData.duration} min',
                style: TextStyle(
                  fontSize: sh * 0.013,
                  fontFamily: 'Poppins-Regular',
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(width: sw * 0.03),
              Icon(Icons.person, color: Colors.grey.shade600, size: sh * 0.015),
              SizedBox(width: sw * 0.01),
              Text(
                serviceData.serviceType,
                style: TextStyle(
                  fontSize: sh * 0.013,
                  fontFamily: 'Poppins-Regular',
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildProductInfo(double sw, double sh, PostModel postData) {
  final productData = postData.customization.product;

  return Container(
    margin: EdgeInsets.only(
        top: sh * 0.0, bottom: sh * 0.02, left: sh * 0.02, right: sh * 0.02),
    padding: EdgeInsets.all(sw * 0.03),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.purple.withOpacity(0.1),
          Colors.deepPurple.withOpacity(0.1),
        ],
      ),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.purple.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HIGHLIGHTED: Product Name
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(sw * 0.025),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple.shade100,
                Colors.deepPurple.shade100,
              ],
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.purple.shade300, width: 2),
          ),
          child: Row(
            children: [
              Icon(Icons.shopping_bag,
                  color: Colors.purple.shade700, size: sh * 0.022),
              SizedBox(width: sw * 0.02),
              Expanded(
                child: Text(
                  productData?.name ?? "New Product",
                  style: TextStyle(
                    fontSize: sh * 0.018,
                    fontFamily: 'Poppins-Bold',
                    color: Colors.purple.shade900,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: sh * 0.01),

        // // HIGHLIGHTED: Product Price (if available)
        // if (_getProductPriceFromDescription(description).isNotEmpty) ...[
        //   Container(
        //     width: double.infinity,
        //     padding: EdgeInsets.all(sw * 0.025),
        //     decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //         colors: [
        //           Colors.green.shade100,
        //           Colors.teal.shade100,
        //         ],
        //       ),
        //       borderRadius: BorderRadius.circular(8),
        //       border: Border.all(color: Colors.green.shade300, width: 2),
        //     ),
        //     child: Row(
        //       children: [
        //         Icon(Icons.currency_rupee,
        //             color: Colors.green.shade700, size: sh * 0.020),
        //         SizedBox(width: sw * 0.015),
        //         Text(
        //           'PRICE',
        //           style: TextStyle(
        //             fontSize: sh * 0.012,
        //             fontFamily: 'Poppins-Bold',
        //             color: Colors.green.shade800,
        //             letterSpacing: 0.5,
        //           ),
        //         ),
        //         Spacer(),
        //         Text(
        //           _getProductPriceFromDescription(description),
        //           style: TextStyle(
        //             fontSize: sh * 0.018,
        //             fontFamily: 'Poppins-Bold',
        //             color: Colors.green.shade900,
        //             fontWeight: FontWeight.w700,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   SizedBox(height: sh * 0.01),
        // ],

        // HIGHLIGHTED: Location & Shop Now
        Container(
          padding: EdgeInsets.all(sw * 0.025),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange.shade50,
                Colors.deepOrange.shade50,
              ],
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.shade300, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location Header
              Row(
                children: [
                  Icon(Icons.location_on,
                      color: Colors.orange.shade700, size: sh * 0.018),
                  SizedBox(width: sw * 0.015),
                  Text(
                    'LOCATION',
                    style: TextStyle(
                      fontSize: sh * 0.012,
                      fontFamily: 'Poppins-Bold',
                      color: Colors.orange.shade800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: sh * 0.005),

              // Location Address (Multi-line, readable)
              Container(
                width: double.infinity,
                child: Text(
                  postData.customization.normal?.location?.name ??
                      'Available Online',
                  style: TextStyle(
                    fontSize: sh * 0.014,
                    fontFamily: 'Poppins-SemiBold',
                    color: Colors.orange.shade900,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(height: sh * 0.01),

              // Divider
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.orange.shade200,
              ),

              SizedBox(height: sh * 0.01),

              // Shop Now CTA Row
              Row(
                children: [
                  Icon(Icons.star,
                      color: Colors.orange.shade700, size: sh * 0.018),
                  SizedBox(width: sw * 0.015),
                  Text(
                    'NEW ARRIVAL',
                    style: TextStyle(
                      fontSize: sh * 0.012,
                      fontFamily: 'Poppins-Bold',
                      color: Colors.orange.shade800,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: sw * 0.025, vertical: sh * 0.005),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange.shade600,
                          Colors.deepOrange.shade600
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.3),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'SHOP NOW',
                      style: TextStyle(
                        fontSize: sh * 0.012,
                        fontFamily: 'Poppins-Bold',
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
