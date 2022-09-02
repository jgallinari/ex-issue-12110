defmodule ExIssue12110.Helper do
  @moduledoc false

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
end
