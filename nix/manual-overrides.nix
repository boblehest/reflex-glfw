{ self, super, pkgs, lib, local ? false }:

with pkgs.haskell.lib; with lib; with self; {

  monoidal-containers = overrideCabal super.monoidal-containers (drv: {
    src = pkgs.fetchFromGitHub {
      owner = "bgamari";
      repo = "monoidal-containers";
      rev = "b0a4b5121f2ce830f9c6da4e7a2ff4c0480cd42b";
      sha256 = "0z85z8q3sa0609cvy6r3cavy01zhfg3acmiak74b4y8wpklr0xw0";
    };
    jailbreak       = true;
    libraryHaskellDepends = (drv.libraryHaskellDepends or []) ++ (with self; [ aeson these ]);
  });

  reflex = overrideCabal super.reflex (drv: {
    src = pkgs.fetchgit (removeAttrs (builtins.fromJSON (builtins.readFile ./reflex/reflex.src.json)) ["date" "path"]);
    libraryHaskellDepends = (drv.libraryHaskellDepends or []) ++ (with self; [ lens data-default hlint filemanip monad-control monoidal-containers prim-uniq unbounded-delays MemoTrie ]);
    jailbreak       = true;
  });
}
