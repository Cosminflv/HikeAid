enum DConnectivityStatus {
  mobile,
  wifi,
  ethernet,
  vpn,
  bluetooth,
  other,
  none;

  bool isConnected() {
    return this != none;
  }
}
