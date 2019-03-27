defmodule Mint.Core.Conn do
  @moduledoc false

  alias Mint.Types

  @type conn() :: term()

  @callback initiate(
              module(),
              Mint.Types.socket(),
              String.t(),
              :inet.port_number(),
              keyword()
            ) :: {:ok, conn()} | {:error, Types.error()}

  @callback open?(conn()) :: boolean()

  @callback close(conn()) :: {:ok, conn()}

  @callback request(
              conn(),
              method :: String.t(),
              path :: String.t(),
              Types.headers(),
              body :: iodata() | nil | :stream
            ) ::
              {:ok, conn(), Types.request_ref()}
              | {:error, conn(), Types.error()}

  @callback stream_request_body(conn(), Types.request_ref(), body_chunk :: iodata() | :eof) ::
              {:ok, conn()} | {:error, conn(), Types.error()}

  @callback stream(conn(), term()) ::
              {:ok, conn(), [Types.response()]}
              | {:error, conn(), Types.error(), [Types.response()]}
              | :unknown

  @callback open_request_count(conn()) :: non_neg_integer()

  @callback put_private(conn(), key :: atom(), value :: term()) :: conn()

  @callback get_private(conn(), key :: atom(), default_value :: term()) :: term()

  @callback delete_private(conn(), key :: atom()) :: conn()

  @callback get_socket(conn()) :: Mint.Types.socket()
end
