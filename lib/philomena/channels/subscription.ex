defmodule Philomena.Channels.Subscription do
  use Ecto.Schema
  import Ecto.Changeset

  alias Philomena.Channels.Channel
  alias Philomena.Users.User

  @primary_key false

  schema "channel_subscriptions" do
    belongs_to :channel, Channel, primary_key: true
    belongs_to :user, User, primary_key: true
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [])
    |> validate_required([])
  end
end
