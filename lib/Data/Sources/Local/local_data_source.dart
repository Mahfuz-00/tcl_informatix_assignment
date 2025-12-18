// --------------
// Local data source implementation using mock JSON file
// All data is currently in assets/MockAPI/data.json
// Each method extracts only the portion needed for a specific feature
// This mirrors what separate remote APIs would return in production
// --------------

import 'dart:convert';

import 'package:flutter/services.dart';

import '../../Models/company_model.dart';
import '../../Models/project_model.dart';

class LocalDataSource {

  // --------------
  // Loads the entire raw JSON once – used by all methods
  // --------------
  Future<Map<String, dynamic>> _loadFullJson() async {
    final String jsonString = await rootBundle.loadString('assets/MockAPI/data.json');
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  // --------------
  // Returns only company basic info (name, currency, etc.)
  // Used by Dashboard
  // --------------
  Future<CompanyModel> getCompanyInfo() async {
    final jsonMap = await _loadFullJson();
    return CompanyModel.fromJson(jsonMap['company'] as Map<String, dynamic>);
  }

  // --------------
  // Returns list of all projects (full project objects)
  // Used by Project List and Dashboard aggregations
  // --------------
  Future<List<ProjectModel>> getAllProjects() async {
    final jsonMap = await _loadFullJson();
    final companyJson = jsonMap['company'] as Map<String, dynamic>;
    final List<dynamic> projectsJson = companyJson['projects'] as List<dynamic>;
    return projectsJson.map((p) => ProjectModel.fromJson(p as Map<String, dynamic>)).toList();
  }

  // --------------
  // Returns a single project by projectId
  // Used by Project Details, Task & Team, Payments screens
  // --------------
  Future<ProjectModel> getProjectById(String projectId) async {
    final projects = await getAllProjects();
    final project = projects.firstWhere(
          (p) => p.projectId == projectId,
      orElse: () => throw Exception('Project not found'),
    );
    return project;
  }
}