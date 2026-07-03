{ pkgs, lib, ... }: {
  programs.starship = {
    enable = true;
    settings = {
      git_branch.disabled = true;
      git_commit.disabled = true;
      git_status.disabled = true;
      custom.jj = {
        when = "${lib.getExe pkgs.jj-starship} detect";
        shell = [ "${lib.getExe pkgs.jj-starship}" ];
        format = "$output ";
      };
    };
  };
}
