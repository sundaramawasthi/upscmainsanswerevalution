library default_connector;
import 'dart:convert';

// Define ConnectorConfig
class ConnectorConfig {
  final String region;
  final String projectType;
  final String projectId;

  ConnectorConfig(this.region, this.projectType, this.projectId);
}

// Placeholder for FirebaseDataConnect and CallerSDKType
// You must replace these with your actual implementations
class FirebaseDataConnect {
  final ConnectorConfig connectorConfig;
  final CallerSDKType sdkType;

  FirebaseDataConnect._(this.connectorConfig, this.sdkType);

  static FirebaseDataConnect instanceFor({
    required ConnectorConfig connectorConfig,
    required CallerSDKType sdkType,
  }) {
    return FirebaseDataConnect._(connectorConfig, sdkType);
  }
}

enum CallerSDKType {
  generated,
}

// DefaultConnector class
class DefaultConnector {
  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-central1',
    'default',
    'upscmainsweb',
  );

  DefaultConnector({required this.dataConnect});

  static DefaultConnector get instance {
    return DefaultConnector(
      dataConnect: FirebaseDataConnect.instanceFor(
        connectorConfig: connectorConfig,
        sdkType: CallerSDKType.generated,
      ),
    );
  }

  FirebaseDataConnect dataConnect;
}
