defmodule ClickClient.CountsClient do
  use Confix

  def get do
    if config(:mock) do
      123
    else
      url = config!(:url)
      response = HTTPotion.get!("#{url}/clicks")
      json = Poison.decode!(response.body)

      Map.fetch!(json, "count")
    end
  end

  def front_url do
    config(:front_url) || config!(:url)
  end
end
