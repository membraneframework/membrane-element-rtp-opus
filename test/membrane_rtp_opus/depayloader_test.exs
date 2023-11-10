defmodule Membrane.RTP.Opus.DepayloaderTest do
  use ExUnit.Case

  alias Membrane.Buffer
  alias Membrane.RTP.Opus.Depayloader

  describe "Depayloader when processing real data" do
    test "sample_payload0.bin" do
      payload = File.read!("test/fixtures/sample_payload0.bin")
      buffer = %Buffer{payload: payload, metadata: %{}}
      assert {actions, nil} = Depayloader.handle_buffer(:input, buffer, nil, nil)
      assert [buffer: {:output, buffer}] == actions
    end
  end
end
