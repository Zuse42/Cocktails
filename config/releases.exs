import Config

db_host = System.get_env("DB_HOST") ||
  raise """
  enviroment variable DATABASE_HOST is missing.
  """

db_instance = System.get_env("DB_INSTANCE") || "video_dev"
db_user = System.get_env("DB_USER") || "postgres"
db_password = System.get_env("DB_PASSWORD") || "postgres"
db_url = "ecto://#{db_user}:#{db_password}@#{db_host}/#{db_instance}"

config :video, Video.Repo,
  url: db_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base = System.get_env("SECRET_KEY_BASE") ||
  raise """
  enviroment variable SECRET_KEY_BASE is missing.
  you can generate one by calling: mix phx.gen.secret
  """

config :video, VideoWeb.Endpoint,
  http: [:inet6, port: 4000],
  url: [host: "//localhost" , port: 4000],
  check_origin: ["//localhost"],
  secret_key_base: secret_key_base

