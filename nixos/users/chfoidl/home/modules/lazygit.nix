{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        autoRefresh = false;
        overrideGpg = true;
      };
      customCommands = [
        {
          command = "git merge {{index .SelectedLocalBranch.Name }} --no-ff";
          context = "localBranches";
          description = "merge into currently checked out branch with --no-ff";
          key = "<c-n>";
        }
      ];
    };
  };
}
