# ex_issue_12110
Basic sample to illustrate how to reproduce [Elixir issue #12110](https://github.com/elixir-lang/elixir/issues/12110)

## Steps
The steps done to create this sample were:

* Create project
```bash
❯ mix new ex_issue_12110
```
* Add test/support directory
```bash
❯ cd ex_issue_12110
❯ mkdir test/support
```
Update mix.exs to include test/support in :elixirc_paths
* Add file test/ex_issue12110_test.exs
* Add file test/support/helper.exs

## How to reproduce the issue
```bash
❯ mix test
Compiling 1 file (.ex)

== Compilation error in file test/ex_issue12110_test.exs ==
** (CompileError) elixir_compiler_1:1: function '-__MODULE__/1-fun-0-'/2+6:
  Internal consistency check failed - please report this bug.
  Instruction: {get_map_elements,
                   {f,28},
                   {x,0},
                   {list,
                       [{atom,url},
                        {x,3},
                        {atom,func},
                        {x,3},
                        {atom,desc},
                        {x,2}]}}
  Error:       conflicting_destinations:

    (stdlib 4.0.1) lists.erl:1442: :lists.foreach_1/2
```

## Description

`test/ex_issue12110_test.exs` calls a macro supposed to generate test cases from constant @tests.
```elixir
ExIssue12110.Helper.generate_tests(@tests)
```

This macro is
```elixir
  defmacro generate_tests(external_tests) do
    quote do
      for [category: category, tests: tests] <- unquote(external_tests) do
        describe "#{category}" do
          for %{desc: desc, func: _, url: _} = test <- tests do
            @test test
            test "#{desc}" do
              assert true
            end
          end
        end
      end
    end
  end
```

If we remove the line:
```elixir
            @test test
```
no more issue.

If we change the line
```elixir
          for %{desc: desc, func: _, url: _} = test <- tests do
```
into
```elixir
          for %{desc: desc, func: _} = test <- tests do
```
no more issue either.
