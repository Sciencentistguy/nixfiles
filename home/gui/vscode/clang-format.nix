{
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
}
