// business_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:social_media_clone/core/utils/linkhelper.dart';

class BusinessDetailScreen extends StatelessWidget {
  final Map<String, dynamic> businessData;

  const BusinessDetailScreen({
    Key? key,
    required this.businessData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    final business = businessData['customization']['business'];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          // App Bar with Business Image
          SliverAppBar(
            toolbarHeight: sh * 0.055,
            floating: false,
            pinned: true,
            backgroundColor: Color(0xFF8A2BE2),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: sh * 0.03,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF8A2BE2),
                        Color(0xFF4B0082),
                      ],
                    ),
                  ),
                  child: SizedBox()),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(sw * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Announcement Section (if available)
                  if (business['announcement'] != null &&
                      business['announcement'].isNotEmpty) ...[
                    _buildAnnouncementCard(sw, sh, business),
                    SizedBox(height: sh * 0.02),
                  ],

                  // Promotions Section (if available)
                  if (business['promotions'] != null &&
                      business['promotions'].isNotEmpty) ...[
                    _buildPromotionCard(sw, sh, business),
                    SizedBox(height: sh * 0.02),
                  ],

                  // Business Info Card
                  _buildBusinessInfoCard(sw, sh, business),

                  SizedBox(height: sh * 0.02),

                  // Contact & Social Media Row
                  _buildContactRow(sw, sh, business),

                  SizedBox(height: sh * 0.02),

                  // Category & Type Card
                  _buildCategoryCard(sw, sh, business),

                  SizedBox(height: sh * 0.02),

                  // Location Card
                  _buildLocationCard(sw, sh, business),

                  SizedBox(height: sh * 0.02),

                  // Hours Card
                  _buildHoursCard(sw, sh, business),

                  SizedBox(height: sh * 0.02),

                  // Features & Rating Row
                  _buildFeaturesAndRatingRow(sw, sh, business),

                  SizedBox(height: sh * 0.04),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementCard(
      double sw, double sh, Map<String, dynamic> business) {
    return Container(
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
            business['announcement'],
            style: TextStyle(
              fontSize: sh * 0.014,
              fontFamily: 'Poppins-Medium',
              color: Colors.amber.shade900,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionCard(
      double sw, double sh, Map<String, dynamic> business) {
    final promotion = business['promotions'][0];

    return Container(
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
                  '${promotion['discount']}% OFF',
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
            promotion['title'] ?? '',
            style: TextStyle(
              fontSize: sh * 0.015,
              fontFamily: 'Poppins-SemiBold',
              color: Colors.red.shade900,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (promotion['description'] != null) ...[
            SizedBox(height: sh * 0.003),
            Text(
              promotion['description'],
              style: TextStyle(
                fontSize: sh * 0.013,
                fontFamily: 'Poppins-Medium',
                color: Colors.red.shade800,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBusinessInfoCard(
      double sw, double sh, Map<String, dynamic> business) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(sw * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(sw * 0.02),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF8A2BE2), Color(0xFF4B0082)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    Icon(Icons.business, color: Colors.white, size: sh * 0.02),
              ),
              SizedBox(width: sw * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      business['businessName'] ?? '',
                      style: TextStyle(
                        fontSize: sh * 0.024,
                        fontFamily: 'Poppins-Bold',
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      business['businessType'] ?? '',
                      style: TextStyle(
                        fontSize: sh * 0.016,
                        fontFamily: 'Poppins-SemiBold',
                        color: Color(0xFF8A2BE2),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                business['priceRange'] ?? '',
                style: TextStyle(
                  fontSize: sh * 0.018,
                  fontFamily: 'Poppins-Bold',
                  color: Color(0xFF8A2BE2),
                ),
              ),
            ],
          ),
          SizedBox(height: sh * 0.015),
          Container(
            width: double.infinity,
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
            child: Text(
              business['description'] ?? '',
              style: TextStyle(
                fontSize: sh * 0.016,
                fontFamily: 'Poppins-Regular',
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(double sw, double sh, Map<String, dynamic> business) {
    final contact = business['contact'];

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => UrlLauncherHelper.launchPhone(contact['phone']),
                child: Container(
                  padding: EdgeInsets.all(sw * 0.04),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade50, Colors.indigo.shade50],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade300, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.phone,
                              color: Colors.blue.shade700, size: sh * 0.022),
                          SizedBox(width: sw * 0.02),
                          Text(
                            'PHONE',
                            style: TextStyle(
                              fontSize: sh * 0.012,
                              fontFamily: 'Poppins-Bold',
                              color: Colors.blue.shade800,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.call,
                              color: Colors.blue.shade700, size: sh * 0.018),
                        ],
                      ),
                      SizedBox(height: sh * 0.008),
                      Text(
                        contact['phone'] ?? '',
                        style: TextStyle(
                          fontSize: sh * 0.016,
                          fontFamily: 'Poppins-SemiBold',
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: sw * 0.03),
            Expanded(
              child: GestureDetector(
                onTap: () => UrlLauncherHelper.launchEmail(contact['email']),
                child: Container(
                  padding: EdgeInsets.all(sw * 0.04),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade50, Colors.indigo.shade50],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade300, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.email,
                              color: Colors.blue.shade700, size: sh * 0.022),
                          SizedBox(width: sw * 0.02),
                          Text(
                            'EMAIL',
                            style: TextStyle(
                              fontSize: sh * 0.012,
                              fontFamily: 'Poppins-Bold',
                              color: Colors.blue.shade800,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.mail_outline,
                              color: Colors.blue.shade700, size: sh * 0.018),
                        ],
                      ),
                      SizedBox(height: sh * 0.008),
                      Text(
                        contact['email'] ?? '',
                        style: TextStyle(
                          fontSize: sh * 0.014,
                          fontFamily: 'Poppins-SemiBold',
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        // Website & Social Media
        SizedBox(height: sh * 0.02),
        Row(
          children: [
            if (contact['website'] != null) ...[
              Expanded(
                child: GestureDetector(
                  onTap: () => UrlLauncherHelper.launchURL(contact['website']),
                  child: Container(
                    padding: EdgeInsets.all(sw * 0.04),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade50, Colors.teal.shade50],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: Colors.green.shade300, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.language,
                                color: Colors.green.shade700, size: sh * 0.022),
                            SizedBox(width: sw * 0.02),
                            Text(
                              'WEBSITE',
                              style: TextStyle(
                                fontSize: sh * 0.012,
                                fontFamily: 'Poppins-Bold',
                                color: Colors.green.shade800,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.open_in_new,
                                color: Colors.green.shade700, size: sh * 0.018),
                          ],
                        ),
                        SizedBox(height: sh * 0.008),
                        Text(
                          UrlLauncherHelper.formatURL(contact['website']),
                          style: TextStyle(
                            fontSize: sh * 0.014,
                            fontFamily: 'Poppins-SemiBold',
                            color: Colors.green.shade900,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (contact['socialMedia'] != null &&
                  contact['socialMedia'].isNotEmpty)
                SizedBox(width: sw * 0.03),
            ],
            if (contact['socialMedia'] != null &&
                contact['socialMedia'].isNotEmpty) ...[
              Expanded(
                child: GestureDetector(
                  onTap: () => UrlLauncherHelper.launchURL(
                      contact['socialMedia'][0]['url']),
                  child: Container(
                    padding: EdgeInsets.all(sw * 0.04),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.shade50,
                          Colors.deepPurple.shade50
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: Colors.purple.shade300, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.share,
                                color: Colors.purple.shade700,
                                size: sh * 0.022),
                            SizedBox(width: sw * 0.02),
                            Text(
                              'SOCIAL',
                              style: TextStyle(
                                fontSize: sh * 0.012,
                                fontFamily: 'Poppins-Bold',
                                color: Colors.purple.shade800,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.open_in_new,
                                color: Colors.purple.shade700,
                                size: sh * 0.018),
                          ],
                        ),
                        SizedBox(height: sh * 0.008),
                        Text(
                          contact['socialMedia'][0]['platform'] ?? '',
                          style: TextStyle(
                            fontSize: sh * 0.016,
                            fontFamily: 'Poppins-SemiBold',
                            color: Colors.purple.shade900,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
      double sw, double sh, Map<String, dynamic> business) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(sw * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.category, color: Color(0xFF8A2BE2), size: sh * 0.022),
              SizedBox(width: sw * 0.02),
              Text(
                'CATEGORY & TYPE',
                style: TextStyle(
                  fontSize: sh * 0.014,
                  fontFamily: 'Poppins-Bold',
                  color: Color(0xFF8A2BE2),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: sh * 0.015),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(sw * 0.03),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF8A2BE2).withOpacity(0.1),
                        Color(0xFF4B0082).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: Color(0xFF8A2BE2).withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: sh * 0.012,
                          fontFamily: 'Poppins-Medium',
                          color: Color(0xFF8A2BE2),
                        ),
                      ),
                      Text(
                        business['category'] ?? '',
                        style: TextStyle(
                          fontSize: sh * 0.016,
                          fontFamily: 'Poppins-SemiBold',
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: sw * 0.03),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(sw * 0.03),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF8A2BE2).withOpacity(0.2),
                        Color(0xFF4B0082).withOpacity(0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: Color(0xFF8A2BE2).withOpacity(0.5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subcategory',
                        style: TextStyle(
                          fontSize: sh * 0.012,
                          fontFamily: 'Poppins-Medium',
                          color: Color(0xFF8A2BE2),
                        ),
                      ),
                      Text(
                        business['subcategory'] ?? '',
                        style: TextStyle(
                          fontSize: sh * 0.016,
                          fontFamily: 'Poppins-SemiBold',
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: sh * 0.015),
        ],
      ),
    );
  }

  Widget _buildLocationCard(
      double sw, double sh, Map<String, dynamic> business) {
    final location = business['location'];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(sw * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on,
                  color: Colors.red.shade700, size: sh * 0.022),
              SizedBox(width: sw * 0.02),
              Text(
                'LOCATION',
                style: TextStyle(
                  fontSize: sh * 0.014,
                  fontFamily: 'Poppins-Bold',
                  color: Colors.red.shade800,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: sh * 0.015),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(sw * 0.03),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${location['address']}',
                  style: TextStyle(
                    fontSize: sh * 0.016,
                    fontFamily: 'Poppins-SemiBold',
                    color: Colors.red.shade900,
                  ),
                ),
                SizedBox(height: sh * 0.005),
                Text(
                  '${location['city']}, ${location['state']}',
                  style: TextStyle(
                    fontSize: sh * 0.014,
                    fontFamily: 'Poppins-Medium',
                    color: Colors.red.shade800,
                  ),
                ),
                Text(
                  '${location['country']} - ${location['postalCode'] ?? ''}',
                  style: TextStyle(
                    fontSize: sh * 0.014,
                    fontFamily: 'Poppins-Medium',
                    color: Colors.red.shade800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHoursCard(double sw, double sh, Map<String, dynamic> business) {
    final hours = business['hours'] as List<dynamic>? ?? [];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(sw * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.access_time,
                  color: Colors.cyan.shade700, size: sh * 0.022),
              SizedBox(width: sw * 0.02),
              Text(
                'BUSINESS HOURS',
                style: TextStyle(
                  fontSize: sh * 0.014,
                  fontFamily: 'Poppins-Bold',
                  color: Colors.cyan.shade800,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: sh * 0.015),
          ...hours.map((dayHour) {
            return Container(
              margin: EdgeInsets.only(bottom: sh * 0.01),
              padding: EdgeInsets.all(sw * 0.03),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.cyan.shade50, Colors.blue.shade50],
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.cyan.shade200),
              ),
              child: Row(
                children: [
                  Container(
                    width: sw * 0.02,
                    height: sw * 0.02,
                    decoration: BoxDecoration(
                      color: dayHour['isClosed']
                          ? Colors.red
                          : Colors.cyan.shade600,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: sw * 0.03),
                  Text(
                    dayHour['day'],
                    style: TextStyle(
                      fontSize: sh * 0.016,
                      fontFamily: 'Poppins-SemiBold',
                      color: Colors.cyan.shade900,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: sw * 0.02, vertical: sh * 0.005),
                    decoration: BoxDecoration(
                      color: dayHour['isClosed']
                          ? Colors.red
                          : Colors.cyan.shade600,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      dayHour['isClosed']
                          ? 'CLOSED'
                          : '${dayHour['openTime']} - ${dayHour['closeTime']}',
                      style: TextStyle(
                        fontSize: sh * 0.013,
                        fontFamily: 'Poppins-Medium',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildFeaturesAndRatingRow(
      double sw, double sh, Map<String, dynamic> business) {
    final features = business['features'] as List<dynamic>? ?? [];
    final rating = business['rating'] ?? 0.0;

    return Column(
      children: [
        // Rating Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(sw * 0.04),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow.shade50, Colors.amber.shade50],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber.shade300, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.amber.shade700, size: sh * 0.03),
              SizedBox(width: sw * 0.02),
              Text(
                rating.toString(),
                style: TextStyle(
                  fontSize: sh * 0.024,
                  fontFamily: 'Poppins-Bold',
                  color: Colors.amber.shade900,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: sw * 0.02),
              Text(
                'RATING',
                style: TextStyle(
                  fontSize: sh * 0.014,
                  fontFamily: 'Poppins-Bold',
                  color: Colors.amber.shade800,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),

        if (features.isNotEmpty) ...[
          SizedBox(height: sh * 0.02),
          // Features Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(sw * 0.04),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.featured_play_list,
                        color: Colors.teal.shade700, size: sh * 0.022),
                    SizedBox(width: sw * 0.02),
                    Text(
                      'FEATURES',
                      style: TextStyle(
                        fontSize: sh * 0.014,
                        fontFamily: 'Poppins-Bold',
                        color: Colors.teal.shade800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.015),
                ...features
                    .map((feature) => Container(
                          margin: EdgeInsets.only(bottom: sh * 0.01),
                          padding: EdgeInsets.all(sw * 0.03),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.teal.shade200),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: sw * 0.02,
                                height: sw * 0.02,
                                decoration: BoxDecoration(
                                  color: Colors.teal.shade600,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: sw * 0.03),
                              Expanded(
                                child: Text(
                                  feature.toString(),
                                  style: TextStyle(
                                    fontSize: sh * 0.015,
                                    fontFamily: 'Poppins-Medium',
                                    color: Colors.teal.shade900,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
