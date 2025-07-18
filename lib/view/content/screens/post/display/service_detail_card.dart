// service_detail_screen.dart
import 'package:flutter/material.dart';

class ServiceDetailScreen extends StatelessWidget {
  final Map<String, dynamic> serviceData;

  const ServiceDetailScreen({
    Key? key,
    required this.serviceData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    final service = serviceData['customization']['service'];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          //* App Bar with Service Image (simplified)
          SliverAppBar(
            toolbarHeight: sh * 0.055,
            floating: false,
            pinned: true,
            backgroundColor: Colors.blue.shade600,
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
                        Colors.blue.shade400,
                        Colors.indigo.shade600,
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
                  // Service Info Card
                  _buildServiceInfoCard(sw, sh, service),

                  SizedBox(height: sh * 0.02),

                  // Price & Duration Row
                  _buildPriceAndDurationRow(sw, sh, service),

                  SizedBox(height: sh * 0.02),

                  // Category Card
                  _buildCategoryCard(sw, sh, service),

                  SizedBox(height: sh * 0.02),

                  // Location Card
                  _buildLocationCard(sw, sh, service),

                  SizedBox(height: sh * 0.02),

                  // Timing Card
                  _buildTimingCard(sw, sh, service),

                  SizedBox(height: sh * 0.02),

                  // Requirements & Deliverables Row
                  _buildRequirementsAndDeliverablesRow(sw, sh, service),

                  SizedBox(height: sh * 0.04),
                ],
              ),
            ),
          ),
        ],
      ),

      // Fixed Bottom Button
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(sw * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: _buildBookButton(sw, sh, context),
        ),
      ),
    );
  }

  Widget _buildServiceInfoCard(
      double sw, double sh, Map<String, dynamic> service) {
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
                    colors: [Colors.blue.shade500, Colors.indigo.shade500],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.star, color: Colors.white, size: sh * 0.02),
              ),
              SizedBox(width: sw * 0.03),
              Expanded(
                child: Text(
                  service['name'] ?? '',
                  style: TextStyle(
                    fontSize: sh * 0.024,
                    fontFamily: 'Poppins-Bold',
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: sh * 0.015),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(sw * 0.03),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Text(
              service['description'] ?? '',
              style: TextStyle(
                fontSize: sh * 0.016,
                fontFamily: 'Poppins-Regular',
                color: Colors.blue.shade800,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAndDurationRow(
      double sw, double sh, Map<String, dynamic> service) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(sw * 0.04),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade50, Colors.teal.shade50],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade300, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.currency_rupee,
                        color: Colors.green.shade700, size: sh * 0.022),
                    SizedBox(width: sw * 0.02),
                    Text(
                      'PRICE',
                      style: TextStyle(
                        fontSize: sh * 0.012,
                        fontFamily: 'Poppins-Bold',
                        color: Colors.green.shade800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.008),
                Text(
                  '${service['currency']} ${service['price']}',
                  style: TextStyle(
                    fontSize: sh * 0.022,
                    fontFamily: 'Poppins-Bold',
                    color: Colors.green.shade900,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: sw * 0.03),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(sw * 0.04),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade50, Colors.teal.shade50],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade300, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time,
                        color: Colors.green.shade700, size: sh * 0.022),
                    SizedBox(width: sw * 0.02),
                    Text(
                      'DURATION',
                      style: TextStyle(
                        fontSize: sh * 0.012,
                        fontFamily: 'Poppins-Bold',
                        color: Colors.green.shade800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.008),
                Text(
                  '${service['duration']} min',
                  style: TextStyle(
                    fontSize: sh * 0.022,
                    fontFamily: 'Poppins-Bold',
                    color: Colors.green.shade900,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
      double sw, double sh, Map<String, dynamic> service) {
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
              Icon(Icons.category,
                  color: Colors.blue.shade700, size: sh * 0.022),
              SizedBox(width: sw * 0.02),
              Text(
                'CATEGORY & TYPE',
                style: TextStyle(
                  fontSize: sh * 0.014,
                  fontFamily: 'Poppins-Bold',
                  color: Colors.blue.shade800,
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
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: sh * 0.012,
                          fontFamily: 'Poppins-Medium',
                          color: Colors.blue.shade600,
                        ),
                      ),
                      Text(
                        service['category'] ?? '',
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
              SizedBox(width: sw * 0.03),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(sw * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subcategory',
                        style: TextStyle(
                          fontSize: sh * 0.012,
                          fontFamily: 'Poppins-Medium',
                          color: Colors.blue.shade600,
                        ),
                      ),
                      Text(
                        service['subcategory'] ?? '',
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
            ],
          ),
          SizedBox(height: sh * 0.015),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: sw * 0.03, vertical: sh * 0.01),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade600, Colors.indigo.shade600],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              service['serviceType']?.toUpperCase() ?? '',
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
    );
  }

  Widget _buildLocationCard(
      double sw, double sh, Map<String, dynamic> service) {
    final location = service['location'];

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
                'LOCATION DETAILS',
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
                Row(
                  children: [
                    Icon(Icons.business,
                        color: Colors.red.shade600, size: sh * 0.018),
                    SizedBox(width: sw * 0.02),
                    Text(
                      'Service Type: ',
                      style: TextStyle(
                        fontSize: sh * 0.014,
                        fontFamily: 'Poppins-Medium',
                        color: Colors.red.shade700,
                      ),
                    ),
                    Text(
                      location['type']?.toUpperCase() ?? '',
                      style: TextStyle(
                        fontSize: sh * 0.014,
                        fontFamily: 'Poppins-Bold',
                        color: Colors.red.shade900,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.01),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.place,
                        color: Colors.red.shade600, size: sh * 0.018),
                    SizedBox(width: sw * 0.02),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address:',
                            style: TextStyle(
                              fontSize: sh * 0.014,
                              fontFamily: 'Poppins-Medium',
                              color: Colors.red.shade700,
                            ),
                          ),
                          Text(
                            '${location['address']}\n${location['city']}, ${location['state']}\n${location['country']}',
                            style: TextStyle(
                              fontSize: sh * 0.014,
                              fontFamily: 'Poppins-Regular',
                              color: Colors.red.shade800,
                              height: 1.3,
                            ),
                          ),
                        ],
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

  Widget _buildTimingCard(double sw, double sh, Map<String, dynamic> service) {
    final availability = service['availability'];
    final schedule = availability['schedule'] as List<dynamic>? ?? [];

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
              Icon(Icons.schedule,
                  color: Colors.blue.shade700, size: sh * 0.022),
              SizedBox(width: sw * 0.02),
              Text(
                'TIMING & AVAILABILITY',
                style: TextStyle(
                  fontSize: sh * 0.014,
                  fontFamily: 'Poppins-Bold',
                  color: Colors.blue.shade800,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: sh * 0.015),
          if (schedule.isNotEmpty) ...[
            ...schedule.map((daySchedule) {
              final day = daySchedule['day'] ?? '';
              final timeSlots =
                  daySchedule['timeSlots'] as List<dynamic>? ?? [];

              return Container(
                margin: EdgeInsets.only(bottom: sh * 0.01),
                padding: EdgeInsets.all(sw * 0.03),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade50, Colors.indigo.shade50],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    Container(
                      width: sw * 0.02,
                      height: sw * 0.02,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: sw * 0.03),
                    Text(
                      day,
                      style: TextStyle(
                        fontSize: sh * 0.016,
                        fontFamily: 'Poppins-SemiBold',
                        color: Colors.blue.shade900,
                      ),
                    ),
                    Spacer(),
                    if (timeSlots.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: sw * 0.02, vertical: sh * 0.005),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${timeSlots[0]['startTime']} - ${timeSlots[0]['endTime']}',
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
          SizedBox(height: sh * 0.015),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(sw * 0.03),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade300),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline,
                    color: Colors.blue.shade700, size: sh * 0.018),
                SizedBox(width: sw * 0.02),
                Expanded(
                  child: Text(
                    'Book ${availability['bookingAdvance']} hour(s) in advance • Maximum ${availability['maxBookingsPerDay']} bookings per day',
                    style: TextStyle(
                      fontSize: sh * 0.013,
                      fontFamily: 'Poppins-Medium',
                      color: Colors.blue.shade800,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementsAndDeliverablesRow(
      double sw, double sh, Map<String, dynamic> service) {
    final requirements = service['requirements'] as List<dynamic>? ?? [];
    final deliverables = service['deliverables'] as List<dynamic>? ?? [];

    return Column(
      children: [
        // Requirements
        if (requirements.isNotEmpty) ...[
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
                    Icon(Icons.checklist,
                        color: Colors.amber.shade700, size: sh * 0.022),
                    SizedBox(width: sw * 0.02),
                    Text(
                      'REQUIREMENTS',
                      style: TextStyle(
                        fontSize: sh * 0.014,
                        fontFamily: 'Poppins-Bold',
                        color: Colors.amber.shade800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.015),
                ...requirements
                    .map((requirement) => Container(
                          margin: EdgeInsets.only(bottom: sh * 0.01),
                          padding: EdgeInsets.all(sw * 0.03),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.amber.shade200),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: sw * 0.02,
                                height: sw * 0.02,
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade600,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: sw * 0.03),
                              Expanded(
                                child: Text(
                                  requirement.toString(),
                                  style: TextStyle(
                                    fontSize: sh * 0.015,
                                    fontFamily: 'Poppins-Medium',
                                    color: Colors.amber.shade900,
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
          SizedBox(height: sh * 0.02),
        ],

        // Deliverables
        if (deliverables.isNotEmpty) ...[
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
                    Icon(Icons.local_shipping,
                        color: Colors.teal.shade700, size: sh * 0.022),
                    SizedBox(width: sw * 0.02),
                    Text(
                      'WHAT YOU\'LL GET',
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
                ...deliverables
                    .map((deliverable) => Container(
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
                                  deliverable.toString(),
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

  Widget _buildBookButton(double sw, double sh, BuildContext context) {
    return Container(
      width: double.infinity,
      height: sh * 0.06,
      child: ElevatedButton(
        onPressed: () {
          // Handle booking logic here
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Service Booked'),
              backgroundColor: Colors.green,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade600,
                Colors.indigo.shade600,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'CLICK FOR MORE DETAILS',
              style: TextStyle(
                fontSize: sh * 0.02,
                fontFamily: 'Poppins-Bold',
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
