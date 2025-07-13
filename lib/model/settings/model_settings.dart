// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:ui';

import 'package:flutter/material.dart';

class ModelSettings {
  final String svg;
  final String label;
  final Color color;
  ModelSettings({required this.svg, required this.label, required this.color});

  static List<ModelSettings> settingsList = [
    ModelSettings(
        svg: "assets/svg/logout.svg", label: 'Logout', color: Colors.red),
    ModelSettings(
        svg: "assets/svg/plan.svg",
        label: 'Activate Business Profile',
        color: Colors.black),
  ];
}

class ModelBusinessSettings {
  final String svg;
  final String label;
  ModelBusinessSettings({required this.svg, required this.label});

  static List<ModelBusinessSettings> businessList = [
    ModelBusinessSettings(
        svg: "assets/svg/add.svg", label: 'Add Your Business Details'),
    ModelBusinessSettings(
        svg: "assets/svg/promote.svg", label: 'Complete your KYC Details'),
    ModelBusinessSettings(svg: "assets/svg/post.svg", label: 'Post Ad'),
    ModelBusinessSettings(
        svg: "assets/svg/post.svg", label: 'Edit Your Business Details'),
  ];
}

class Plan {
  final String name;
  final String description;
  final String priceLabel;
  final Color borderColor;
  final Color backgroundColor;
  final Color titleTextColor;
  final Color subtitleTextColor;
  final Color priceTextColor;

  const Plan({
    required this.name,
    required this.description,
    required this.priceLabel,
    required this.borderColor,
    required this.backgroundColor,
    required this.titleTextColor,
    required this.subtitleTextColor,
    required this.priceTextColor,
  });
}

//* Extracted UI colors (approximate):
const _cardBorder = Color(0xFFFFC107); // light amber border
const _cardBg = Color(0xFFFFF8E1); // pale yellow background
const _titleOrange = Color(0xFFB75C00); // dark orange text
const _subtitleGrey = Color(0xFF585858); // medium grey subtitle
const _priceOrange = _titleOrange; // same as title

//* Your list of plans, including a “Free” tier:
final List<Plan> plans = [
  Plan(
    name: 'Free',
    description: 'Basic features to get you started',
    priceLabel: 'Free',
    borderColor: _cardBorder,
    backgroundColor: _cardBg,
    titleTextColor: _titleOrange,
    subtitleTextColor: _subtitleGrey,
    priceTextColor: _priceOrange,
  ),
  Plan(
    name: 'Small Business',
    description: 'Enhanced analytics &\npromotion',
    priceLabel: '₹499/month',
    borderColor: _cardBorder,
    backgroundColor: _cardBg,
    titleTextColor: _titleOrange,
    subtitleTextColor: _subtitleGrey,
    priceTextColor: _priceOrange,
  ),
  Plan(
    name: 'Corporate',
    description: 'Priority support & advanced\nfeatures',
    priceLabel: '₹1,499/month',
    borderColor: _cardBorder,
    backgroundColor: _cardBg,
    titleTextColor: _titleOrange,
    subtitleTextColor: _subtitleGrey,
    priceTextColor: _priceOrange,
  ),
];
