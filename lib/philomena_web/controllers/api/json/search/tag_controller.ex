defmodule PhilomenaWeb.Api.Json.Search.TagController do
  use PhilomenaWeb, :controller

  alias PhilomenaWeb.TagJson
  alias Philomena.Elasticsearch
  alias Philomena.Tags.Tag
  alias Philomena.Tags.Query
  import Ecto.Query

  def index(conn, params) do
    case Query.compile(params["q"] || "") do
      {:ok, query} ->
        tags =
          Elasticsearch.search_records(
            Tag,
            %{query: query, sort: %{images: :desc}},
            conn.assigns.pagination,
            preload(Tag, [:aliased_tag, :aliases, :implied_tags, :implied_by_tags, :dnp_entries])
          )

        json(conn, %{tags: Enum.map(tags, &TagJson.as_json/1)})

      {:error, msg} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: msg})
    end
  end
end
