defmodule ExIssue12110Test do
  use ExUnit.Case
  require ExIssue12110.Helper

  @tests [
    [
      category: "category1",
      tests: [
        %{
          desc: "test1",
          func: "func",
          url: "url"
        }
      ]
    ]
  ]

  ExIssue12110.Helper.generate_tests(@tests)
end
