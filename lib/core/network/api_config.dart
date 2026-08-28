/// Base URL of the self-hosted Rimba API (see `api/` and
/// `deploy/vps_setup.sh`). Empty by default so the app still runs fully
/// offline-only when no backend is configured — [ApiClient] treats an
/// empty base URL as "no backend available" and every caller falls back
/// to local-only behavior.
///
/// Set at build/run time, e.g.:
///   flutter run --dart-define=API_BASE_URL=https://api.yourdomain.com
abstract final class ApiConfig {
  static const baseUrl = String.fromEnvironment('API_BASE_URL');

  static bool get isConfigured => baseUrl.isNotEmpty;
}
