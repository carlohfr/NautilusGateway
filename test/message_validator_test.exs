defmodule MessageValidatorTest do

    use ExUnit.Case

    @message_validator Application.get_env(:nautilus, :MessageValidator)

    test "message validator test - test if is valid" do
        message = %{
            "action" => "register-client",
            "body-size" => "0",
            "content" => "",
            "from" => "client",
            "to" => "127.0.0.1:10000",
            "type" => "request",
            "version" => "1.0"}
        assert @message_validator.validate_message(message) == {:valid, message}
    end

    test "message validator test - test if is invalid" do
        message = %{"test" => "non valid message"}
        assert @message_validator.validate_message(message) == {:invalid, message}
    end

end
