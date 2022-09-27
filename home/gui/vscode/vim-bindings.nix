{
  normal = [
    {
      before = ["<leader>" "f"];
      commands = ["editor.action.formatDocument"];
    }
    {
      before = ["<F3>"];
      commands = ["editor.action.formatDocument"];
    }

    {
      before = ["<leader>" "e"];
      commands = ["workbench.action.quickOpen"];
    }

    {
      before = ["K"];
      commands = ["editor.action.showHover"];
    }

    {
      before = ["H"];
      after = ["h"];
    }
    {
      before = ["L"];
      after = ["l"];
    }

    {
      before = ["q" ":"];
      after = [];
    }
    {
      before = ["q" "?"];
      after = [];
    }
    {
      before = ["q" "/"];
      after = [];
    }

    {
      before = ["s"];
      after = ["\"" "_" "d"];
    }
    {
      before = ["s" "s"];
      after = ["\"" "_" "d" "d"];
    }
    {
      before = ["S"];
      after = ["\"" "_" "D"];
    }

    {
      before = ["0"];
      after = ["^"];
    }

    {
      before = ["Y"];
      after = ["y" "$"];
    }

    {
      before = ["<leader>" "<cr>"];
      commands = [":nohl"];
    }

    {
      before = ["<leader>" "l"];
      commands = ["workbench.action.nextEditor"];
    }
    {
      before = ["<leader>" "h"];
      commands = ["workbench.action.previousEditor"];
    }

    {
      before = ["]" "g"];
      commands = ["editor.action.marker.next"];
    }
    {
      before = ["[" "g"];
      commands = ["editor.action.marker.prev"];
    }

    {
      before = ["<leader>" "a" "c"];
      commands = ["editor.action.quickFix"];
    }
  ];

  visual = [
    {
      before = ["{"];
      after = [];
    }
    {
      before = ["}"];
      after = [];
    }
  ];

  insert = [];
}
