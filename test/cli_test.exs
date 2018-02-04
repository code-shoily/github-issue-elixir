defmodule CliTest do
  use ExUnit.Case

  import Issues.CLI,
    only: [parse_args: 1, sort_into_ascending_order: 1, convert_to_list_of_hashdicts: 1]

  test ":help returned for --help or -h options" do
    assert parse_args(["--help", "anything"]) == :help
    assert parse_args(["-h", "anything"]) == :help
  end

  test "three values returned when three given" do
    assert parse_args(["mafinar", "tread", 3]) == {"mafinar", "tread", 3}
  end

  test "count is defaulted to 4 if two given" do
    assert parse_args(["mafinar", "tread"]) == {"mafinar", "tread", 4}
  end

  test ":help returned if invalid was given" do
    assert parse_args([]) == :help
  end

  test "sort ascending order" do
    result = sort_into_ascending_order(fake_created_at_list(["a", "c", "b", "d"]))
    issues = for issue <- result, do: issue["created_at"]
    assert issues == ~w/a b c d/
  end

  def fake_created_at_list(list) do
    data = for value <- list, do: [{"created_at", value}, {"foo", "bar"}]
    convert_to_list_of_hashdicts(data)
  end
end
