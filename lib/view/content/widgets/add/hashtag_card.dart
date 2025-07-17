import 'package:flutter/material.dart';

class HashtagInputWidget extends StatefulWidget {
  final List<String> initialHashtags;
  final Function(List<String>) onHashtagsChanged;
  final int maxHashtags;
  final bool allowDuplicates;

  const HashtagInputWidget({
    Key? key,
    this.initialHashtags = const [],
    required this.onHashtagsChanged,
    this.maxHashtags = 10,
    this.allowDuplicates = false,
  }) : super(key: key);

  @override
  State<HashtagInputWidget> createState() => _HashtagInputWidgetState();
}

class _HashtagInputWidgetState extends State<HashtagInputWidget> {
  late TextEditingController hashtagController;
  late List<String> hashtags;

  @override
  void initState() {
    super.initState();
    hashtagController = TextEditingController();
    hashtags = List.from(widget.initialHashtags);
  }

  @override
  void dispose() {
    hashtagController.dispose();
    super.dispose();
  }

  void _addHashtag(String hashtag) {
    final trimmedHashtag = hashtag.trim();
    
    if (trimmedHashtag.isEmpty) return;
    
    // Check for duplicates if not allowed
    if (!widget.allowDuplicates && hashtags.contains(trimmedHashtag)) return;
    
    // Check max hashtags limit
    if (hashtags.length >= widget.maxHashtags) return;

    setState(() {
      hashtags.add(trimmedHashtag);
      hashtagController.clear();
    });
    
    widget.onHashtagsChanged(hashtags);
  }

  void _removeHashtag(String hashtag) {
    setState(() {
      hashtags.remove(hashtag);
    });
    widget.onHashtagsChanged(hashtags);
  }

  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final double sh = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add hashtags',
          style: TextStyle(
            fontSize: sh * 0.02,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(height: sh * 0.015),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(sw * 0.04),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade500, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: hashtagController,
                      decoration: InputDecoration(
                        labelText: 'Add hashtag',
                        labelStyle: TextStyle(
                          fontSize: sh * 0.018,
                          fontFamily: 'Poppins-Medium',
                        ),
                        hintText: 'Enter hashtag (without #)',
                        hintStyle: TextStyle(
                          fontSize: sh * 0.016,
                          fontFamily: 'Poppins-Light',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.amber, width: 2),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: sw * 0.03, 
                          vertical: sh * 0.015,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: sh * 0.018,
                        fontFamily: 'Poppins-Light',
                      ),
                      onSubmitted: _addHashtag,
                    ),
                  ),
                  SizedBox(width: sw * 0.02),
                  ElevatedButton(
                    onPressed: () => _addHashtag(hashtagController.text),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: sh * 0.018,
                        fontFamily: 'Poppins-Medium',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: sh * 0.015),
              if (hashtags.isNotEmpty) ...[
                Text(
                  'Added Hashtags:',
                  style: TextStyle(
                    fontSize: sh * 0.018,
                    fontFamily: 'Poppins-Medium',
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: sh * 0.01),
                Wrap(
                  spacing: sw * 0.02,
                  runSpacing: sh * 0.01,
                  children: hashtags
                      .map((hashtag) => _buildHashtagChip(hashtag, sw, sh))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHashtagChip(String hashtag, double sw, double sh) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: sw * 0.03, 
        vertical: sh * 0.008,
      ),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '#$hashtag',
            style: TextStyle(
              color: Colors.white,
              fontSize: sh * 0.02,
              fontFamily: 'Poppins-Medium',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: sw * 0.015),
          GestureDetector(
            onTap: () => _removeHashtag(hashtag),
            child: Container(
              width: sw * 0.04,
              height: sw * 0.04,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: Colors.orange,
                size: sh * 0.015,
              ),
            ),
          ),
        ],
      ),
    );
  }
}