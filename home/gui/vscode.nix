{
  pkgs,
  flakePkgs,
  ...
}: let
  clang-format-style = {
    AccessModifierOffset = -3;
    "AlignAfterOpenBracket" = "Align";
    "AlignConsecutiveMacros" = true;
    "AlignConsecutiveAssignments" = false;
    "AlignConsecutiveDeclarations" = false;
    "AlignEscapedNewlines" = "Left";
    "AlignOperands" = true;
    "AlignTrailingComments" = true;
    "AllowAllArgumentsOnNextLine" = true;
    "AllowAllConstructorInitializersOnNextLine" = true;
    "AllowAllParametersOfDeclarationOnNextLine" = true;
    "AllowShortBlocksOnASingleLine" = false;
    "AllowShortCaseLabelsOnASingleLine" = false;
    "AllowShortFunctionsOnASingleLine" = "None";
    "AllowShortIfStatementsOnASingleLine" = "Never";
    "AllowShortLambdasOnASingleLine" = "Inline";
    "AllowShortLoopsOnASingleLine" = false;
    "AlwaysBreakAfterReturnType" = "None";
    "AlwaysBreakTemplateDeclarations" = "Yes";
    "BinPackArguments" = true;
    "BinPackParameters" = true;
    "BreakAfterJavaFieldAnnotations" = true;
    "BreakBeforeBinaryOperators" = "NonAssignment";
    "BreakBeforeBraces" = "Attach";
    "BreakBeforeTernaryOperators" = true;
    "BreakConstructorInitializers" = "AfterColon";
    "BreakInheritanceList" = "AfterColon";
    "BreakStringLiterals" = false;
    "ColumnLimit" = 158;
    "CompactNamespaces" = false;
    "ConstructorInitializerAllOnOneLineOrOnePerLine" = false;
    "Cpp11BracedListStyle" = true;
    "DerivePointerAlignment" = false;
    "ExperimentalAutoDetectBinPacking" = false;
    "FixNamespaceComments" = true;
    "IncludeBlocks" = "Regroup";
    IncludeCategories = [
      {
        "Regex" = "^<[a-zA-Z_]*>";
        "Priority" = 1;
      }
      {
        "Regex" = "^<[a-zA-Z_/]*>";
        Priority = 2;
      }
      {
        Regex = "^<.*>";
        Priority = 3;
      }
      {
        Regex = "^\"(.*\/)+.*\"";
        Priority = 4;
      }
      {
        Regex = "\".*\"";
        Priority = 5;
      }
    ];
    # - Regex:
    # Priority:        1
    # - Regex:           ''
    # Priority:        2
    # - Regex:           ''
    # Priority:        3
    # - Regex:           ''
    # Priority:        4
    # - Regex:           ''
    # Priority:        5
    "IndentCaseLabels" = true;
    "IndentPPDirectives" = "BeforeHash";
    "IndentWidth" = 4;
    "IndentWrappedFunctionNames" = true;
    "JavaScriptQuotes" = "Double";
    "JavaScriptWrapImports" = true;
    "KeepEmptyLinesAtTheStartOfBlocks" = false;
    "Language" = "Cpp";
    "MaxEmptyLinesToKeep" = 1;
    "NamespaceIndentation" = "All";
    "PointerAlignment" = "Left";
    "ReflowComments" = true;
    "SortIncludes" = true;
    "SortUsingDeclarations" = true;
    "SpaceAfterCStyleCast" = true;
    "SpaceAfterLogicalNot" = false;
    "SpaceAfterTemplateKeyword" = false;
    "SpaceBeforeAssignmentOperators" = true;
    "SpaceBeforeCpp11BracedList" = false;
    "SpaceBeforeCtorInitializerColon" = true;
    "SpaceBeforeInheritanceColon" = true;
    "SpaceBeforeParens" = "ControlStatements";
    "SpaceBeforeRangeBasedForLoopColon" = true;
    "SpaceInEmptyParentheses" = false;
    "SpacesBeforeTrailingComments" = 2;
    "SpacesInAngles" = false;
    "SpacesInCStyleCastParentheses" = false;
    "SpacesInContainerLiterals" = false;
    "SpacesInParentheses" = false;
    "SpacesInSquareBrackets" = false;
    "Standard" = "Cpp11";
    "TabWidth" = 4;
    "UseTab" = "Never";
  };
in {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      ms-vscode.cpptools
      rust-lang.rust-analyzer
      # asvetliakov.vscode-neovim
      ms-python.python
      ms-python.vscode-pylance
    ];

    mutableExtensionsDir = false;
    # keybindings = {
    # "K"
    # };
    userSettings = {
      "keyboard.dispatch" = "keyCode";

      "editor.fontFamily" = "Iosevka Term";
      "editor.renderWhitespace" = "trailing";

      "editor.minimap.enabled" = false;
      "files.autoGuessEncoding" = true;

      "update.mode" = "none";
      "telemetry.telemetryLevel" = "off";

      "window.zoomLevel" = 1;

      "C_Cpp.clang_format_path" = "${pkgs.clang-tools}/bin/clang-format";
      "C_Cpp.codeAnalysis.clangTidy.path" = "${pkgs.clang-tools}/bin/clang-tidy";
      "C_Cpp.clang_format_style" = builtins.toJSON clang-format-style;

      # "vscode-neovim.neovimExecutablePaths.linux" = "${flakePkgs.neovim}/bin/nvim";

      "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
      "python.formatting.blackPath" = "${pkgs.black}/bin/black";
      "python.formatting.provider" = "black";
    };
  };
}
