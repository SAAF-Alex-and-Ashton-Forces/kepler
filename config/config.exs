# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :kepler,
  ecto_repos: [Kepler.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :kepler, KeplerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "q30Iq+HSj8swBel6T00EvjrYYwgE+X53YL83CAeJw0S49UFVkKFPaWGdc3eee6dy",
  render_errors: [view: KeplerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Kepler.PubSub,
  live_view: [signing_salt: "qNEodbwD"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :kepler, :pow,
  user: Kepler.Users.User,
  repo: Kepler.Repo

config :kepler, :pow_assent,
  providers: [
    github: [
      client_id: "64c7f0b43949555adb22",
      client_secret: (System.get_env("GITHUB_OAUTH_CLIENT_SECRET") || raise "Environment variable GITHUB_OAUTH_CLIENT_SECRET is not set."),
      strategy: Assent.Strategy.Github
    ]
  ]
