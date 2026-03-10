import 'dart:async';
import 'dart:io';

enum NetworkInterfaceType {
  wifi,
  cellular,
  ethernet,
  vpn,
  hotspot,
  unknown,
}

class NetworkStateChange {
  final NetworkInterfaceType type;
  final bool isConnected;
  final String interfaceName;
  final List<String> addresses;
  final DateTime timestamp;

  NetworkStateChange({
    required this.type,
    required this.isConnected,
    required this.interfaceName,
    required this.addresses,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  @override
  String toString() =>
      'NetworkStateChange(type: $type, connected: $isConnected, interface: $interfaceName, addresses: $addresses)';
}

class NetworkStateDetector {
  static final NetworkStateDetector _instance = NetworkStateDetector._internal();
  factory NetworkStateDetector() => _instance;
  NetworkStateDetector._internal();

  final StreamController<NetworkStateChange> stateController = StreamController<NetworkStateChange>.broadcast();

  Timer? monitoringTimer;
  Map<String, List<String>> previousInterfaces = {};
  bool isMonitoring = false;

  Stream<NetworkStateChange> get onNetworkStateChanged => stateController.stream;

  void startMonitoring({
    Duration interval = const Duration(milliseconds: 500),
  }) {
    if (isMonitoring) return;

    isMonitoring = true;
    previousInterfaces = {};

    scanNetworkInterfaces();

    monitoringTimer = Timer.periodic(interval, (_) {
      scanNetworkInterfaces();
    });
  }

  void stopMonitoring() {
    monitoringTimer?.cancel();
    monitoringTimer = null;
    isMonitoring = false;
    previousInterfaces.clear();
  }

  Future<void> scanNetworkInterfaces() async {
    try {
      final interfaces = await NetworkInterface.list(
        includeLoopback: false,
        includeLinkLocal: true,
        type: InternetAddressType.any,
      );

      final currentInterfaces = <String, List<String>>{};

      for (final interface in interfaces) {
        final addresses = interface.addresses.map((addr) => addr.address).toList();

        currentInterfaces[interface.name] = addresses;

        if (!previousInterfaces.containsKey(interface.name)) {
          emitStateChange(
            interface: interface,
            isConnected: true,
            addresses: addresses,
          );
        } else {
          final prevAddresses = previousInterfaces[interface.name]!;
          if (!areAddressListsEqual(addresses, prevAddresses)) {
            emitStateChange(
              interface: interface,
              isConnected: addresses.isNotEmpty,
              addresses: addresses,
            );
          }
        }
      }

      for (final prevInterface in previousInterfaces.keys) {
        if (!currentInterfaces.containsKey(prevInterface)) {
          stateController.add(NetworkStateChange(
            type: detectInterfaceType(prevInterface),
            isConnected: false,
            interfaceName: prevInterface,
            addresses: [],
          ));
        }
      }

      previousInterfaces = currentInterfaces;
    // ignore: empty_catches
    } catch (e) {}
  }

  void emitStateChange({
    required NetworkInterface interface,
    required bool isConnected,
    required List<String> addresses,
  }) {
    final type = detectInterfaceType(interface.name);
    final event = NetworkStateChange(
      type: type,
      isConnected: isConnected,
      interfaceName: interface.name,
      addresses: addresses,
    );

    stateController.add(event);
  }

  NetworkInterfaceType detectInterfaceType(String interfaceName) {
    final name = interfaceName.toLowerCase();

    if (name.contains('wlan') ||
        name.contains('wifi') ||
        name.contains('wi-fi') ||
        name.contains('en0') && Platform.isIOS ||
        name.contains('en1') && Platform.isMacOS) {
      return NetworkInterfaceType.wifi;
    }

    if (name.contains('ap') ||
        name.contains('hotspot') ||
        name.contains('tether') ||
        name.contains('bridge') ||
        name.contains('rndis') ||
        name.contains('usb') && name.contains('0')) {
      return NetworkInterfaceType.hotspot;
    }

    if (name.contains('rmnet') ||
        name.contains('ccmni') ||
        name.contains('pdp') ||
        name.contains('cellular') ||
        name.contains('mobile') ||
        name.contains('wwan')) {
      return NetworkInterfaceType.cellular;
    }

    if (name.contains('eth') ||
        name.contains('lan') && !name.contains('wlan') ||
        name.contains('en0') && Platform.isMacOS) {
      return NetworkInterfaceType.ethernet;
    }

    if (name.contains('tun') || name.contains('tap') || name.contains('vpn') || name.contains('ppp')) {
      return NetworkInterfaceType.vpn;
    }

    return NetworkInterfaceType.unknown;
  }

  bool areAddressListsEqual(List<String> list1, List<String> list2) {
    if (list1.length != list2.length) return false;
    final set1 = Set<String>.from(list1);
    final set2 = Set<String>.from(list2);
    return set1.difference(set2).isEmpty && set2.difference(set1).isEmpty;
  }

  Future<List<NetworkStateChange>> getCurrentNetworkState() async {
    final interfaces = await NetworkInterface.list(
      includeLoopback: false,
      includeLinkLocal: true,
    );

    return interfaces.map((interface) {
      final addresses = interface.addresses.map((addr) => addr.address).toList();
      return NetworkStateChange(
        type: detectInterfaceType(interface.name),
        isConnected: addresses.isNotEmpty,
        interfaceName: interface.name,
        addresses: addresses,
      );
    }).toList();
  }

  Future<bool> isWiFiEnabled() async {
    final interfaces = await NetworkInterface.list();
    return interfaces.any((interface) =>
        detectInterfaceType(interface.name) == NetworkInterfaceType.wifi && interface.addresses.isNotEmpty);
  }

  Future<bool> isHotspotEnabled() async {
    final interfaces = await NetworkInterface.list();
    return interfaces.any((interface) =>
        detectInterfaceType(interface.name) == NetworkInterfaceType.hotspot && interface.addresses.isNotEmpty);
  }

  Future<bool> isInternetEnabled() async {
    if (await isHotspotEnabled() || await isWiFiEnabled()) {
      return true;
    }
    return false;
  }

  Future<List<NetworkInterface>> getWiFiInterfaces() async {
    final interfaces = await NetworkInterface.list();
    return interfaces.where((interface) => detectInterfaceType(interface.name) == NetworkInterfaceType.wifi).toList();
  }

  Future<List<NetworkInterface>> getHotspotInterfaces() async {
    final interfaces = await NetworkInterface.list();
    return interfaces
        .where((interface) => detectInterfaceType(interface.name) == NetworkInterfaceType.hotspot)
        .toList();
  }

  void dispose() {
    stopMonitoring();
    stateController.close();
  }
}

extension NetworkStateChangeFilter on Stream<NetworkStateChange> {
  Stream<NetworkStateChange> get wifiOnly => where((event) => event.type == NetworkInterfaceType.wifi);

  Stream<NetworkStateChange> get hotspotOnly => where((event) => event.type == NetworkInterfaceType.hotspot);

  Stream<NetworkStateChange> get cellularOnly => where((event) => event.type == NetworkInterfaceType.cellular);

  Stream<NetworkStateChange> get connectionsOnly => where((event) => event.isConnected);

  Stream<NetworkStateChange> get disconnectionsOnly => where((event) => !event.isConnected);
}
