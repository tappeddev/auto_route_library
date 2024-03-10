import 'package:code_builder/code_builder.dart' as _code;

import 'resolved_type.dart';

const _reservedVarNames = ['children'];

/// A list of valid path param types
/// that can be parsed from a path string
const validPathParamTypes = [
  'String',
  'int',
  'double',
  'num',
  'bool',
  'dynamic'
];

/// holds constructor parameter info to be used
/// in generating route parameters.
class ParamConfig {
  /// the type of the parameter
  final ResolvedType type;
  /// the name of the parameter
  final String name;
  /// the alias of the parameter
  final String? alias;
  /// whether the parameter is positional
  final bool isPositional;
  /// whether the parameter is optional
  final bool isOptional;
  /// whether the parameter is required
  final bool isRequired;
  /// whether the parameter is named
  final bool isNamed;
  /// whether the parameter is a path param
  final bool isPathParam;
  /// whether the parameter is an inherited path param
  final bool isInheritedPathParam;
  /// whether the parameter is a query param
  final bool isQueryParam;
  /// the default value code of the parameter
  final String? defaultValueCode;

  /// Default constructor
  ParamConfig({
    required this.type,
    required this.name,
    required this.isNamed,
    required this.isPositional,
    required this.isOptional,
    required this.isRequired,
    required this.isPathParam,
    required this.isQueryParam,
    required this.isInheritedPathParam,
    this.alias,
    this.defaultValueCode,
  });

  /// If the parameter name conflicts with a reserved name
  /// add a zero to the end of the name
  ///
  /// e.g. children -> children0
  ///
  /// otherwise return the name as is
  String getSafeName() {
    if (_reservedVarNames.contains(name)) {
      return name + "0";
    } else {
      return name;
    }
  }

  /// Return the getter function name
  /// based on the type of the parameter
  String get getterMethodName {
    switch (type.name) {
      case 'String':
        return type.isNullable ? 'optString' : 'getString';
      case 'int':
        return type.isNullable ? 'optInt' : 'getInt';
      case 'double':
        return type.isNullable ? 'optDouble' : 'getDouble';
      case 'num':
        return type.isNullable ? 'optNum' : 'getNum';
      case 'bool':
        return type.isNullable ? 'optBool' : 'getBool';
      default:
        return 'get';
    }
  }

  /// Returns the alias if exists otherwise the name
  String get paramName => alias ?? name;

  /// Serializes the parameter to a json map
  Map<String, dynamic> toJson() {
    return {
      'type': this.type.toJson(),
      'name': this.name,
      'alias': this.alias,
      'isPositional': this.isPositional,
      'isOptional': this.isOptional,
      'isRequired': this.isRequired,
      'isNamed': this.isNamed,
      'isPathParam': this.isPathParam,
      'isInheritedPathParam': this.isInheritedPathParam,
      'isQueryParam': this.isQueryParam,
      'defaultValueCode': this.defaultValueCode,
    };
  }

  /// Deserializes the parameter from a json map
  factory ParamConfig.fromJson(Map<String, dynamic> map) {
    if (map['isFunctionParam'] == true) {
      return FunctionParamConfig.fromJson(map);
    }

    return ParamConfig(
      type: ResolvedType.fromJson(map['type']),
      name: map['name'] as String,
      alias: map['alias'] as String?,
      isPositional: map['isPositional'] as bool,
      isOptional: map['isOptional'] as bool,
      isRequired: map['isRequired'] as bool,
      isNamed: map['isNamed'] as bool,
      isPathParam: map['isPathParam'] as bool,
      isInheritedPathParam: map['isInheritedPathParam'] as bool,
      isQueryParam: map['isQueryParam'] as bool,
      defaultValueCode: map['defaultValueCode'] as String?,
    );
  }
}

/// holds constructor func-parameter info to be used
/// in generating route parameters.
class FunctionParamConfig extends ParamConfig {
  /// the return type of the function
  final ResolvedType returnType;
  /// the list of parameters of the function
  final List<ParamConfig> params;

  /// Default constructor
  FunctionParamConfig({
    required this.returnType,
    this.params = const [],
    required ResolvedType type,
    required String name,
    String? alias,
    required bool isPositional,
    required bool isOptional,
    required bool isNamed,
    required bool isRequired,
    String? defaultValueCode,
  }) : super(
          type: type,
          name: name,
          alias: alias,
          isPathParam: false,
          isQueryParam: false,
          isInheritedPathParam: false,
          isNamed: isNamed,
          defaultValueCode: defaultValueCode,
          isPositional: isPositional,
          isRequired: isRequired,
          isOptional: isOptional,
        );

  Map<String, dynamic> toJson() {
    return {
      // used for deserialization
      'isFunctionParam': true,
      'type': this.type.toJson(),
      'returnType': this.returnType.toJson(),
      'name': this.name,
      'alias': this.alias,
      'isPositional': this.isPositional,
      'isOptional': this.isOptional,
      'isRequired': this.isRequired,
      'isNamed': this.isNamed,
      'isPathParam': this.isPathParam,
      'isQueryParam': this.isQueryParam,
      'defaultValueCode': this.defaultValueCode,
      'params': this.params.map((e) => e.toJson()).toList(),
    };
  }

  /// Deserializes the parameter from a json map
  factory FunctionParamConfig.fromJson(Map<String, dynamic> map) {
    final params = <ParamConfig>[];
    if (map['params'] != null) {
      for (final pJson in map['params']) {
        params.add(ParamConfig.fromJson(pJson));
      }
    }
    return FunctionParamConfig(
      type: ResolvedType.fromJson(map['type']),
      returnType: ResolvedType.fromJson(map['returnType']),
      name: map['name'] as String,
      params: params,
      alias: map['alias'] as String?,
      isPositional: map['isPositional'] as bool,
      isOptional: map['isOptional'] as bool,
      isRequired: map['isRequired'] as bool,
      isNamed: map['isNamed'] as bool,
      defaultValueCode: map['defaultValueCode'] as String?,
    );
  }

  /// Returns the list of required parameters
  List<ParamConfig> get requiredParams =>
      params.where((p) => p.isPositional && !p.isOptional).toList();

  /// Returns the list of optional parameters
  List<ParamConfig> get optionalParams =>
      params.where((p) => p.isPositional && p.isOptional).toList();

  /// Returns the list of named parameters
  List<ParamConfig> get namedParams =>
      params.where((p) => p.isNamed).toList(growable: false);

  /// Returns A function reference of the function type
  _code.FunctionType get funRefer => _code.FunctionType((b) => b
    ..returnType = returnType.refer
    ..requiredParameters.addAll(requiredParams.map((e) => e.type.refer))
    ..optionalParameters.addAll(optionalParams.map((e) => e.type.refer))
    ..isNullable = type.isNullable
    ..namedParameters.addAll(
      {}..addEntries(namedParams.map(
          (e) => MapEntry(e.name, e.type.refer),
        )),
    ));
}

/// Holds information about a path parameter
class PathParamConfig {
  /// The name of the path parameter
  final String name;
  /// Whether the path parameter is optional
  final bool isOptional;

  /// Default constructor
  const PathParamConfig({required this.name, required this.isOptional});

  /// Serializes the path parameter to a json map
  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'isOptional': this.isOptional,
    };
  }

  /// Deserializes the path parameter from a json map
  factory PathParamConfig.fromJson(Map<String, dynamic> map) {
    return PathParamConfig(
      name: map['name'] as String,
      isOptional: map['isOptional'] as bool,
    );
  }
}
