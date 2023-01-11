defmodule Decorator.PrintDecorator do
  use Decorator.Define, [print: 0, extract: 0]

  def print(body, context) do
    quote do
      IO.inspect("Function called: " <> Atom.to_string(unquote(context.name)))
      unquote(body)
    end
  end

  # Context %{name: nil, arity: nil, module: nil, args: nil}7
  def extract(body, context) do
    quote do
      unquote(body)
      IO.inspect("context name : #{unquote(context.name)}")
      IO.inspect("context arity : #{unquote(context.arity)}")
      IO.inspect("context module : #{unquote(context.module)}")
      IO.inspect(unquote(context.args))
      :ok
    end
  end
end

defmodule Decorator.PlayGround do
  use Decorator.PrintDecorator

  @decorate print()
  def hello do
    :world
  end

  @decorate extract()
  def hello(arg) do
    IO.inspect("arg : #{arg}")
  end

  @decorate extract()
  def hello(arg1, arg2, arg3) do
    IO.inspect("arg1 : #{arg1}")
    IO.inspect("arg2 : #{arg2}")
    IO.inspect("arg3 : #{arg3}")
  end
end
