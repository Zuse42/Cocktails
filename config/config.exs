# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :video,
  ecto_repos: [Video.Repo]

# Configures the endpoint
config :video, VideoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gJiHAylB7oUUsFYzwZL5d7TjLNkESX3GWsOLor1exqDWEaoqCNJ+gVa373Ov4oMH",
  render_errors: [view: VideoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Video.PubSub,
  live_view: [signing_salt: "CQ4IwkCP"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
