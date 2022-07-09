{
  pkgs,
  flakePkgs,
  systemName,
  lib,
  ...
}: let
  onDiscordia = systemName == "discordia";
in {
  programs.starship.package = flakePkgs.starship-sciencentistguy;
  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;
  programs.starship.enableBashIntegration = false;
  programs.starship.settings = {
    add_newline = false;
    format = "$username$hostname$shell$all";
    aws.disabled = true;
    battery.disabled = !onDiscordia;
    character = {
      success_symbol = "[<I>](bold fg:246) [➜](bold #98C379)";
      cancel_symbol = "[<I>](bold fg:246) [➜](bold #EFC07B)";
      error_symbol = "[<I>](bold fg:246) [➜](bold #E06C75)";
      vimcmd_success_symbol = "[<N>](bold fg:246) [➜](bold #98C379)";
      vimcmd_cancel_symbol = "[<N>](bold fg:246) [➜](bold #EFC07B)";
      vimcmd_error_symbol = "[<N>](bold fg:246) [➜](bold #E06C75)";
    };
    cmd_duration = {
      min_time = 5000;
      show_milliseconds = true;
    };
    directory = {
      truncation_length = 8;
      truncate_to_repo = true;
      read_only = " 🔒";
      style = "bold #61AFEF";
    };
    gcloud.disabled = true;
    git_branch.style = "bold #C678DD";
    git_status.style = "bold #E06C75";
    hostname = {
      ssh_only = false;
      style = "bold #98C379";
      format = "[$hostname]($style) ";
    };
    nix_shell = {
      impure_msg = "";
      pure_msg = "";
      format = "within [$symbol($name)]($style) ";
      symbol =
        if onDiscordia
        then "  "
        else " ";
    };
    package.disabled = true;
    shell = {
      disabled = false;
      nu_indicator = "nushell";
      format = "\\([$indicator]($style)\\) in ";
    };
    username = {
      show_always = true;
      format = "[$user]($style)@";
    };
    username = {
      style_root = "bold #E06C75";
      style_user = "bold #EFC07B";
    };
  };
}
