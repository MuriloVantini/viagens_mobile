class LoginResponseDto {
  LoginResponseDto({
    required this.tokenType,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  final String tokenType;
  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      tokenType: json['tokenType'] as String? ?? 'Bearer',
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: json['expiresIn'] as int? ?? 0,
    );
  }
}

class RefreshResponseDto {
  RefreshResponseDto({
    required this.tokenType,
    required this.accessToken,
    required this.expiresIn,
  });

  final String tokenType;
  final String accessToken;
  final int expiresIn;

  factory RefreshResponseDto.fromJson(Map<String, dynamic> json) {
    return RefreshResponseDto(
      tokenType: json['tokenType'] as String? ?? 'Bearer',
      accessToken: json['accessToken'] as String,
      expiresIn: json['expiresIn'] as int? ?? 0,
    );
  }
}
