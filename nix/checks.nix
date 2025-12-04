{
  perSystem = {self', ...}: {
    checks = {
      default = self'.checks.firmware;
      inherit (self'.packages) firmware flash update;
    };
  };
}
