{ pkgs, ... }:
let beets = pkgs.beets.overrideAttrs (oldAttrs: {
  propagatedBuildInputs = (oldAttrs.propagatedBuildInputs or [ ]) ++ [
    pkgs.beets-file-info
  ];
});
in
{
  programs.beets.enable = true;
  programs.beets.package = beets;
  programs.beets.settings = {
    directory = "~/Music/beets";
    plugins = [
      "duplicates"
      "missing"
      "fetchart"
      "chroma"
      "fromfilename"
      "edit"
      "embedart"
      "mbsync"
      "scrub"
      "acousticbrainz"
      "badfiles"
      "mbsubmit"
      "rewrite"
      "fileinfo"
    ];
    # acoustid.apikey = builtins.readfile config.age.secrets.secret1.path;
    fetchart.minwidth = 1000;
    import.timid = true;
    rewrite = ''
      artist .*AFX.*: AFX
      artist Billie Joe Armstrong.*: Billie Joe Armstrong
      artist The Beach Boys.*: The Beach Boys
      artist Black Sabbath.*: Black Sabbath
      artist Action Bronson.*: Action Bronson
      artist Chiddy Bang.*: Chiddy Bang
      artist DJ smallz.*drake.*: Drake
      artist ^drake.*: Drake
      artist ansel elgort.*: Ansel Elgort
      artist ben harper.*: Ben Harper
      artist Calvin Harris &.*: Calvin Harris
      artist iann dior.*: iann dior
      artist jay.z & Linkin Park: Linkin Park
      artist jay.z.*: JAY‐Z
      artist joey trap.*: Joey Trap
      artist Logic.*: Logic
      artist Loud Luxury and Bryce Vine: Bryce Vine
      artist Louis the Child, Quinn XCII & Chelsea Cutler: Quinn XCII
      artist Annette Peacock.*: Annette Peacock
      artist Quinn xcii.*: Quinn XCII
      artist social house.*: Social House
      artist vigiland.*: Vigiland
      artist 24kgoldn.*: 24kGoldn
      artist Rihanna.*: Rihanna
      artist swedish house mafia.*: Swedish House Mafia
      artist aronchupa.*: AronChupa
      artist czarface.*: Czarface
      artist d.angelo.*: D’Angelo
      artist daktyl.*: Daktyl
      artist danger.mouse.*: Danger Mouse
      artist DJ Snake feat.*: DJ Snake
      artist dr..dre.*: Dr. Dre
      artist dua lipa.*: Dua Lipa
      artist elvis.costello.*: Elvis Costello
      artist ella.fitzgerald.*: Ella Fitzgerald
      artist flume.*: Flume
      artist Freddie Mercury.*: Freddie Mercury
      artist gorillaz.*: Gorillaz
      artist spacemonkeyz vs. gorillaz.*: Gorillaz
      artist cavetown.*: Cavetown
      artist frank.ocean.*: Frank Ocean
      artist the.flaming.lips.*: The Flaming Lips
      artist Jeff Goldblum.* Mildred Snitzer Orchestra: Jeff Goldblum & the Mildred Snitzer Orchestra
      artist justice.*: Justice
      artist lorde.*: Lorde
      artist Louis The Child.*: Louis The Child
      artist lou reed.*: Lou Reed
      artist Lupe Fiasco.*: Lupe Fiasco
      artist Jason Derulo.*: Jason Derulo
      artist Korn.*: Korn
      artist Powfu.*: Powfu
      artist Machinedrum.*: Machinedrum
      artist miles davis.*: Miles Davis
      artist .*mozart.*: Mozart
      artist n.e.r.d.*: N*E*R*D
      artist noisia.*: Noisia
      artist nothing,nowhere.*: nothing,nowhere.
      artist usher.*: Usher
      artist kid.cudi.*: Kid Cudi
      artist prince.&: Prince
      artist prince.and: Prince
      artist lido.*: Lido
      artist twenty one pilots.*: twenty one pilots
      artist thundercat.*: Thundercat
      artist hardy.caprio: Hardy Caprio
      artist dream f.*: Dream
      artist Sway & King Tech.*: Sway & King Tech
      artist meridian dan.*: Meridian Dan
      artist skrillex &.*: Skrillex
      artist skrillex with.*: Skrillex
      artist snoop dogg.*: Snoop Dogg
      artist bazanji,.*: Bazanji
      artist lil nas x.*: Lil Nas X
      artist “Weird Al” Yankovic: '"Weird Al" Yankovic'
    '';
  };
}
