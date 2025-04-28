class TokenBuilder {
  String _token = '';
  String? _orgId;
  String _apiUrl = '';
  bool _isOrgIdLocked = false;

  TokenBuilder._();

  static final TokenBuilder _instance = TokenBuilder._();
  
  static TokenBuilder get build => _instance;

  ///set token - can be updated anytime
  void setToken(String token) {
    _token = token;
  }

  ///set orgId only if not locked
  void setOrgId(String? orgId) {
    if (!_isOrgIdLocked) {
      _orgId = orgId;
      _isOrgIdLocked = true;
    }
  }

  ///set apiUrl - can be updated anytime
  void setApiUrl(String apiUrl) {
    _apiUrl = apiUrl;
  }

  ///get token
  String? get token => _token;

  ///get orgID
  String? get orgId => _orgId;

  ///get apiUrl
  String get apiUrl => _apiUrl;

  ///check if orgId is locked
  bool get isOrgIdLocked => _isOrgIdLocked;
}

/// OpenAI URL configuration class
class OpenAIUrlConfig {
  final String apiUrl;
  
  OpenAIUrlConfig({required this.apiUrl});
  
  factory OpenAIUrlConfig.create({required String apiUrl}) {
    return OpenAIUrlConfig(apiUrl: apiUrl);
  }
}
