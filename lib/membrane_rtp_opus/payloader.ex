defmodule Membrane.RTP.Opus.Payloader do
  @moduledoc """
  Parses RTP payloads into parseable Opus packets.

  Based on [RFC 7587](https://tools.ietf.org/html/rfc7587).
  """

  use Membrane.Filter

  alias Membrane.{Opus, RemoteStream, RTP}

  def_input_pad :input,
    accepted_format:
      [
        %Opus{self_delimiting?: false},
        %RemoteStream{type: :packetized, content_format: content_format}
      ]
      when content_format in [Opus, nil],
    demand_unit: :buffers

  def_output_pad :output, accepted_format: RTP

  @impl true
  def handle_stream_format(:input, _stream_format, _ctx, state) do
    {[stream_format: {:output, %RTP{}}], state}
  end

  @impl true
  def handle_process(:input, buffer, _ctx, state) do
    {[buffer: {:output, buffer}], state}
  end

  @impl true
  def handle_demand(:output, size, :buffers, _ctx, state) do
    {[demand: {:input, size}], state}
  end
end
