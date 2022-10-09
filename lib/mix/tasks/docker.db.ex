defmodule Mix.Tasks.Docker.Db do
  use Mix.Task
  @shortdoc "Start/stop the docker Postgres container for development"

  @moduledoc """
  Fire up a postgres database for development in Docker.

  ## Config

  config/dev.exs:

  ```elixir
  config :docker_db,
    project_slug: "my_cool_app"
  ```

  The `project_slug` value must be a valid container name.

  ## Usage:
      $ mix docker.db start
      $ mix docker.db stop
  """

  @impl Mix.Task
  def run(["start"]) do
    slug = Application.get_env(:docker_db, :project_slug, "generic_phoenix_app")

    volume = "#{slug}_volume"

    Mix.shell().info("Starting container named #{slug} with volume #{volume}...")

    System.cmd("docker", [
      "run",
      "--rm",
      "-d",
      "-e",
      "POSTGRES_PASSWORD=postgres",
      "-p",
      "5432:5432",
      "--mount",
      "type=volume,src=#{volume},dst=/var/lib/postgresql/data",
      "--name",
      slug,
      "postgres"
    ])

    Mix.shell().info("done.")
  end

  @impl Mix.Task
  def run(["stop"]) do
    slug = Application.get_env(:docker_db, :project_slug, "generic_phoenix_app")
    System.cmd("docker", ["stop", slug])
    Mix.shell().info("Container #{slug} stopped")
  end
end
