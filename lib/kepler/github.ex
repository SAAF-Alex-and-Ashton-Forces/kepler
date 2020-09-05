defmodule Kepler.Github do
  alias Kepler.Pository

  @base_url "https://api.github.com/"

  @doc """
  Query the Github public API and return a list of starred repositories.

  ```
  iex> Kepler.Github.fetch_stars("zbeeblebrox")
  # => [ %Pository{name: "elixir", owner: "elixir-lang", url: "https://github.com/elixir-lang/elixir"}, %Pository{...}, %Pository{...}, ...]
  ```
  """
  @spec fetch_stars(handle :: String.t()) :: [%Pository{}] | {:error, String.t()}
  def fetch_stars(handle) do
    with {:ok, handle} <- validate(handle),
	 url <- gen_request_url(handle) do
      url
      |> HTTPoison.get()
      |> parse_stars() 
    end
  end

  defp validate(handle) do ## shamelessly stolen: github.com/shinnn/github-username-regex
    if String.match?(handle, ~r/^[a-z\d](?:[a-z\d]|-(?=[a-z\d])){0,38}$/i) do
      {:ok, handle}
    else
      {:error, "Handle #{handle} is not a valid handle!"}
    end
  end

  defp gen_request_url(handle) do
    Path.join(@base_url, "/users/#{handle}/starred")
  end

  defp parse_stars({:ok, %HTTPoison.Response{status_code: 200, body: body}}), do: parse_star_data(body)
  defp parse_stars(resp), do: {:error, "Unable to handle response: #{resp}"}

  defp parse_star_data(body) do
    {:ok, data} = Jason.decode(body)

    data
    |> Enum.map(&structure_pository/1)
  end

  defp structure_pository(repo) do
    %Pository{name: repo["name"], owner: repo["owner"]["login"], url: repo["url"]}
  end

end
