# 3a2e8b03b442656b2bdfa08ed9ff9efb
# Do not modify this file!  It was generated by ‘nixos rekey’ 
# and may be overwritten by future invocations. 
# Please add public keys to /etc/nixos/secrets/keys/*.pub 
rec {

  users.blink = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCqkkVHSFBPNT9ajrgq1lFKNhkf1QJMZgobkL8fsKlx3mle7Ug5GvW/HLymAsfP04zA1CPet4awcufEEolwY7tWfDIdCOi+8xgaJh5Te3AM9Twegc3a2CRL21Mv438LCPU03qhzHh4JPBWbatq5QxTti67joC91XiBjY/vl8aRtyUz2n/tFoS3yhfMb2qP+VU75dgWQw+WDtHbG4bT018JcL+G4wexKBM3vs51t7qdHHkcbjJh/XJ+/+WGg4SkpmzREEtL2VVh7Mn/e0jupZcU4wtsoi7652bYh1kFpi0YvlTWpdwLmhUXx1RpIYsuP/TNePoN+GBcKN+9dmJuJLJFseD8xhuYzOVpFLb/GdXWEAUlMtCdHwg1QjEUcBPTaX0CeLY/kmna1MU4SBGQ6msTDwSNUpEkKEaiv6Fx66XstAzf1g5NEauLw/YGgwDsPGgPfCraS03aJCqieHxBHe5uaD1vBA4zFvV3CBv3uvlKBUsgVbR2A1k4Bvpyw6VlasvpZhh0DoDVWNL30SvTtyVCS1sIey0GwGNYBVDBu5P5LHsCgOESKG32uHkXVEeYTdln35dJyoxP+/zMebJwNTZjGjU19ORthViwibfQMV2J931ZjkLWgVqxnn9t0hltC2845eOJ0BytX5wFxqf4IU5Ix/yuMeUwIlLocz6X6blNbsQ==";
  users.me = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCqkkVHSFBPNT9ajrgq1lFKNhkf1QJMZgobkL8fsKlx3mle7Ug5GvW/HLymAsfP04zA1CPet4awcufEEolwY7tWfDIdCOi+8xgaJh5Te3AM9Twegc3a2CRL21Mv438LCPU03qhzHh4JPBWbatq5QxTti67joC91XiBjY/vl8aRtyUz2n/tFoS3yhfMb2qP+VU75dgWQw+WDtHbG4bT018JcL+G4wexKBM3vs51t7qdHHkcbjJh/XJ+/+WGg4SkpmzREEtL2VVh7Mn/e0jupZcU4wtsoi7652bYh1kFpi0YvlTWpdwLmhUXx1RpIYsuP/TNePoN+GBcKN+9dmJuJLJFseD8xhuYzOVpFLb/GdXWEAUlMtCdHwg1QjEUcBPTaX0CeLY/kmna1MU4SBGQ6msTDwSNUpEkKEaiv6Fx66XstAzf1g5NEauLw/YGgwDsPGgPfCraS03aJCqieHxBHe5uaD1vBA4zFvV3CBv3uvlKBUsgVbR2A1k4Bvpyw6VlasvpZhh0DoDVWNL30SvTtyVCS1sIey0GwGNYBVDBu5P5LHsCgOESKG32uHkXVEeYTdln35dJyoxP+/zMebJwNTZjGjU19ORthViwibfQMV2J931ZjkLWgVqxnn9t0hltC2845eOJ0BytX5wFxqf4IU5Ix/yuMeUwIlLocz6X6blNbsQ==";
  users.all = [ users.blink users.me ];

  systems.cog = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINdUvzQK5foIc/7wyzgNstR74lY/CeNLKcolnRa3wM+j";
  systems.eve = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILVIFHAdEcejD3y6+KsZQsHxfvn6xGBy+zDZGET20Bv4";
  systems.hub = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINkT/YqlPNy1SgDyx2SLJWYR5JrBBvbSQtOxEa0j5JFe";
  systems.lux = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH4vCpdLog563yCJ1epf/CaWhQKNvvMYvC5gTe/QfaX2";
  systems.pom = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGxHN343UNDxowh8JH1KMxRjWdUqhc7QYksuOau++h3n";
  systems.rig = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHJbuVdWrt3P1OdK5nc2Arek8VWn4cCz3S8nZahDc1rt";
  systems.sol = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEVjSYCtJ0VAslez3CdPwu4ZWE1hRHb6ceT7+I/+6yqL";
  systems.all = [ systems.cog systems.eve systems.hub systems.lux systems.pom systems.rig systems.sol ];

  all = users.all ++ systems.all;

}
