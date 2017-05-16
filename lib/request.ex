defmodule Urlpreview.Request do

  @doc """
  Returns the body and real_url for the requested URL.
  This also converts elements from charlist to their string representation.

  ## Examples

      iex> Urlpreview.Request.get("https://www.google.com")
      %{body: "<!doctype html>...", url: "https://www.google.com"}

      iex> Urlpreview.Request.get("https://www.mybadurl.com")
      %{:error, "Status code 500 encountered."}

  """
  def get(url) do
    try do
      request = HTTPotion.get url
      get(request.status_code, request, url)
    rescue
      _ -> {:error, "An unknown error has occurred."}
    end
  end

  defp get(301, request, url) do
    request
      |> get_redirect_location(url)
      |> get
  end

  defp get(302, request, url) do
    request
      |> get_redirect_location(url)
      |> get
  end

  # if we encounter a status code which we can not do anything about then return error tuple
  defp get(404, request, url) do
    get_error_response(404, request, url)
  end

  # if we encounter a status code which we can not do anything about then return error tuple
  defp get(500, request, url) do
    get_error_response(500, request, url)
  end

  defp get(200, request, url) do
    case is_binary(request.body) do
      true ->
        {:ok, %{ body: get_request_body(request), url: url }}
      false ->
        {:ok, %{ body: request.body, url: url }}
    end
  end

  defp get_request_body(request) do
    Enum.join(for <<c::utf8 <- request.body>>, do: <<c::utf8>>)
  end

  defp get_error_response(status_code, request, url) do
    {:error, %{ body: get_request_body(request), url: url, status_code: status_code}}
  end

  defp get_redirect_location(request, url) do
    %{"location" => location} = request.headers.hdrs
    location |> fix_request_location(url)
  end

  # if we get a redirect without the protocol we will build the redirect location manually
  defp fix_request_location(location, url) do
    if String.at(location, 0) == "/" do
      parsed_url = Fuzzyurl.from_string(url)
      "#{parsed_url.protocol}://#{parsed_url.hostname}#{location}"
    else
      location
    end
  end
end
