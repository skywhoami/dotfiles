{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.gum.services.postgres;
in
{
  options.gum.services.postgres.enable = mkEnableOption "Enable PostgreSQL";

  config = mkIf cfg.enable {
    services.postgresql = {
      enable = true;

      ensureUsers = [
        {
          name = "postgres";
          ensureClauses = {
            superuser = true;
            login = true;
            createrole = true;
            createdb = true;
            replication = true;
          };
        }
      ];

      checkConfig = true;
      enableTCPIP = false;

      settings = {
        max_connections = 100;
        superuser_reserved_connections = 3;

        # memory
        shared_buffers = "2048 MB";
        work_mem = "32 MB";
        maintenance_work_mem = "320 MB";
        huge_pages = "off";
        effective_cache_size = "3 GB";
        effective_io_concurrency = 100;
        random_page_cost = 1.25;

        # monitoring
        shared_preload_libraries = "pg_stat_statements";
        track_io_timing = "on";
        track_functions = "pl";

        # replication
        wal_level = "replica";
        max_wal_senders = 0;
        synchronous_commit = "on";

        # wal writing
        wal_compression = "on";
      };
    };
  };
}
