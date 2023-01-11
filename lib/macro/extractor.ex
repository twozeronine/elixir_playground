defmodule Macro.Extractor do
  defmacro extract_caller() do
    {fun_name, _arity} = __CALLER__.function
    module_name = __CALLER__.module

    full_name = "#{module_name}.#{fun_name}"

    name = remove_elixir_prefix(full_name)

    quote do
      IO.inspect("fun_name             : #{unquote(fun_name)}")
      IO.inspect("module_name          : #{unquote(module_name)}")
      IO.inspect("full_name            : #{unquote(full_name)}")
      IO.inspect("remove_elixir_prefix : #{unquote(name)}")
      :ok
    end
  end
  defp remove_elixir_prefix("Elixir." <> module_name), do: module_name
  defp remove_elixir_prefix(module_name), do: module_name
end

defmodule Macro.PlayGround do
  require Macro.Extractor
  def hello() do
    Macro.Extractor.extract_caller()
  end
end
