defmodule Textile.UrlLexer do
  import NimbleParsec

  def url_ending_in(ending_sequence) do
    domain =
      repeat(
        choice([
          ascii_char([?a..?z]) |> string(".") |> ascii_char([?a..?z]),
          ascii_char([?a..?z])
        ])
      )

    scheme_and_domain =
      choice([
        string("/"),
        string("data:image/"),
        string("https://") |> concat(domain),
        string("http://") |> concat(domain)
      ])

    scheme_and_domain
    |> repeat(utf8_char([]) |> lookahead_not(ending_sequence))
    |> reduce({List, :to_string, []})
  end
end