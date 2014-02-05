base_dir = "/home/pi"
app_dir  = "/home/pi/WorkshopArduiPiSinatra"
worker_processes 2
working_directory app_dir

listen "#{base_dir}/tmp/app.sock", :backlog => 64
#listen 8080, :tcp_nopush => true

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 30

# feel free to point this anywhere accessible on the filesystem
pid "#{base_dir}/pids/app.pid"

# By default, the Unicorn logger will write to stderr.
# Additionally, ome applications/frameworks log to stderr or stdout,
# so prevent them from going to /dev/null when daemonized here:
stderr_path "#{base_dir}/log/unicorn.stderr.log"
stdout_path "#{base_dir}/log/unicorn.stdout.log"

check_client_connection false
