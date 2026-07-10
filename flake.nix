{
  description = "ludihan nix config :^)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    templates.url = "github:nixos/templates";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    todo = {
      url = "github:ludihan/todo";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nix-index-database,
      todo,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      flakeLocation = "/home/ludihan/.dotfiles";
      hmBase =
        hostPath:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs flakeLocation; };
          modules = [
            hostPath
            nix-index-database.homeModules.nix-index
            { programs.nix-index-database.comma.enable = true; }
            todo.homeModules.todo
          ];
        };
      noBase =
        hostPath:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs flakeLocation; };
          modules = [
            hostPath
            inputs.musnix.nixosModules.musnix
          ];
        };
    in
    {
      nixosConfigurations = {
        "nixos-desktop" = noBase ./nixos/desktop.nix;
        "nixos-laptop" = noBase ./nixos/laptop.nix;
      };

      homeConfigurations = {
        "ludihan@nixos-desktop" = hmBase ./home/desktop.nix;
        "ludihan@nixos-laptop" = hmBase ./home/laptop.nix;
      };

      templates = inputs.templates;

      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
