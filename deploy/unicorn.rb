working_directory "/usr/share/horizon"
pid "/usr/share/horizon/pids/unicorn.pid"

stderr_path "/usr/share/horizon/log/unicorn.log"
stdout_path "/usr/share/horizon/log/unicorn.log"

listen "/tmp/unicorn.horizon.sock"

worker_processes 4
timeout 30
