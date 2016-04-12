export PATH=$PATH:$HOME/prometheus_mongodb_exporter

[ ! -d example/log ] && mkdir -p example/log
[ ! -d example/tmp ] && mkdir -p example/tmp
logdir=$(readlink -f example/log)
piddir=$(readlink -f example/tmp)

killall mongodb_exporter 2>/dev/null

mongodb_exporter -mongodb.uri mongodb://localhost:37017 -web.listen-address ":47017" -log_dir $logdir/37017 >/dev/null &
mongodb_exporter -mongodb.uri mongodb://localhost:37018 -web.listen-address ":47018" -log_dir $logdir/37018 >/dev/null &
mongodb_exporter -mongodb.uri mongodb://localhost:37019 -web.listen-address ":47019" -log_dir $logdir/37019 >/dev/null &
mongodb_exporter -mongodb.uri mongodb://localhost:37027 -web.listen-address ":47027" -log_dir $logdir/37027 >/dev/null &

echo OK!
