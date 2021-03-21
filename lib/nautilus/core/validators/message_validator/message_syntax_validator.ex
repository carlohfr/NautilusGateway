defmodule Nautilus.Core.Validators.MessageValidator.MessageSyntaxValidator do

    @moduledoc """
    This module is responsible for validate the syntax of message
    """

    @doc """
    This is the main function of this module and is responsible for organize the steps of validation
    """
    def validate_message_syntax(message) do
        case Map.has_key?(message, "version") do
            :true ->
                version = message["version"]

                with {:ok, fields} <- get_header_fields(version),
                {:valid, _} <- validate_fields(fields, message) do
                    {:valid, message}
                else
                    _ ->
                        {:invalid, message}
                end
            _ ->
                {:invalid, message}
        end
    end


    # This function receive a version and return all main header fields for this version
    defp get_header_fields("1.0"), do: {:ok, ["version", "to", "from", "action", "type", "body-size", "content"]}
    defp get_header_fields(_), do: {:error, :wrong_version}


    # This function will validate all fields of message
    defp validate_fields([], _message), do: {:valid, :valid}
    defp validate_fields([head|tail], message) do
        case Map.has_key?(message, head) do
            :true ->
                validate_fields(tail, message)
            _ ->
                {:invalid, :non_right_fields}
        end
    end

end
