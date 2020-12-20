import 'package:flutter/material.dart';
import 'package:frontend/models/placement.dart';

enum PlacementFilterCompareFunctionType { TYPE_OF_CONTRACT, YEARLY_SALARY }

class PlacementFilter {
  final String name;
  final dynamic value;
  final String category;
  final PlacementFilterCompareFunctionType compareType;

  PlacementFilter(this.name, this.value, this.category, this.compareType);

  PlacementFilter.typeOfContract(
    this.name,
    this.value,
    this.compareType, {
    this.category = "Type of contract",
  });

  PlacementFilter.yearlySalary(this.name, this.value, this.compareType,
      {this.category = "Yearly Salary"});

  bool compare(Placement placement) {
    switch (this.compareType) {
      case PlacementFilterCompareFunctionType.TYPE_OF_CONTRACT:
        return _compareTypeOfContract(placement);
      case PlacementFilterCompareFunctionType.YEARLY_SALARY:
        return _compareYearlySalary(placement);
      default:
        return false;
    }
  }

  bool _compareTypeOfContract(Placement placement) {
    return this.value == placement.employmentType.string;
  }

  bool _compareYearlySalary(Placement placement) {
    switch (this.value) {
      case "13,000£ or lower":
        return placement.salary <= 13000;
      case "13,000£ - 14,000£":
        return placement.salary <= 14000 && placement.salary >= 13000;
      case "14,000£ - 15,000£":
        return placement.salary <= 15000 && placement.salary >= 14000;
      case "15,000£ - 16,000£":
        return placement.salary <= 16000 && placement.salary >= 15000;
      case "16,000£ - 17,000£":
        return placement.salary <= 17000 && placement.salary >= 16000;
      case "17,000£ - 18,000£":
        return placement.salary <= 18000 && placement.salary >= 17000;
      case "18,000£ - 19,000£":
        return placement.salary <= 19000 && placement.salary >= 18000;
      case "19,000£ or higher":
        return placement.salary >= 19000;
      default:
        return false;
    }
  }
}

class PlacementFilters {
  static final List<PlacementFilter> list = [
    PlacementFilter.typeOfContract(
        EmploymentType.FULLTIME.niceString,
        EmploymentType.FULLTIME.string,
        PlacementFilterCompareFunctionType.TYPE_OF_CONTRACT),
    PlacementFilter.typeOfContract(
        EmploymentType.PARTTIME.niceString,
        EmploymentType.PARTTIME.string,
        PlacementFilterCompareFunctionType.TYPE_OF_CONTRACT),
    PlacementFilter.typeOfContract(
        EmploymentType.CONTRACT.niceString,
        EmploymentType.CONTRACT.string,
        PlacementFilterCompareFunctionType.TYPE_OF_CONTRACT),
    PlacementFilter.typeOfContract(
        EmploymentType.INTERNSHIP.niceString,
        EmploymentType.INTERNSHIP.string,
        PlacementFilterCompareFunctionType.TYPE_OF_CONTRACT),
    PlacementFilter.yearlySalary("13,000£ or lower", "13,000£ or lower",
        PlacementFilterCompareFunctionType.YEARLY_SALARY),
    PlacementFilter.yearlySalary("13,000£ - 14,000£", "13,000£ - 14,000£",
        PlacementFilterCompareFunctionType.YEARLY_SALARY),
    PlacementFilter.yearlySalary("14,000£ - 15,000£", "14,000£ - 15,000£",
        PlacementFilterCompareFunctionType.YEARLY_SALARY),
    PlacementFilter.yearlySalary("15,000£ - 16,000£", "15,000£ - 16,000£",
        PlacementFilterCompareFunctionType.YEARLY_SALARY),
    PlacementFilter.yearlySalary("16,000£ - 17,000£", "16,000£ - 17,000£",
        PlacementFilterCompareFunctionType.YEARLY_SALARY),
    PlacementFilter.yearlySalary("17,000£ - 18,000£", "17,000£ - 18,000£",
        PlacementFilterCompareFunctionType.YEARLY_SALARY),
    PlacementFilter.yearlySalary("18,000£ - 19,000£", "18,000£ - 19,000£",
        PlacementFilterCompareFunctionType.YEARLY_SALARY),
    PlacementFilter.yearlySalary("19,000£ or higher", "19,000£ or higher",
        PlacementFilterCompareFunctionType.YEARLY_SALARY),
  ];
}
