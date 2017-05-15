defmodule Urlpreview.Request do

  def get(url) do
    request = HTTPotion.get url
    get(request.status_code, request, url)
  end

  defp get(301, request, _url) do
    request
      |> get_redirect_location
      |> get
  end

  defp get(302, request, _url) do
    request
      |> get_redirect_location
      |> get
  end

  defp get(200, request, url) do
    case is_binary(request.body) do
      true ->
        value = Enum.join(for <<c::utf8 <- request.body>>, do: <<c::utf8>>)
        %{ body: value, request_url: url, real_url: request.url }
      false ->
        %{ body: request.body, request_url: url, real_url: request.url }
    end
  end

  defp get_redirect_location(request) do
    %{"location" => location} = request.headers.hdrs
    location
  end
end
