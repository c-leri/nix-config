{pkgs, ...}: {
  # Makes jdk available at /run/current-system/sw/lib/openjdk and sets JAVA_HOME
  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
}
