#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
	set -- supervisord "$@"
fi

if [ "$1" = 'supervisord' ]; then
	
	if [ ! -f /etc/rabbitmq/rabbitmq.config ] ; then

		if [ -z "$RABBITMQ_ADMIN_PASSWORD" ]; then
			echo >&2 'error: ariane is not configured and RABBITMQ_ADMIN_PASSWORD not set'
			echo >&2 '  Did you forget to add -e RABBITMQ_ADMIN_PASSWORD=... ?'
			exit 1
		fi
	
        echo "Performing initial config"
        cat > /etc/rabbitmq/rabbitmq.config <<-EOF
			[
			 {rabbit,
			  [
			   %% {reverse_dns_lookups, true},
			   {loopback_users, []},
			   {default_vhost,	   <<"/">>},
			   {default_user,		<<"admin">>},
			   {default_pass,		<<"$RABBITMQ_ADMIN_PASSWORD">>},
			   {default_permissions, [<<".*">>, <<".*">>, <<".*">>]},
			   {default_user_tags, [administrator]}
			  ]
			 },
			 {kernel,
			  [
			   {inet_dist_listen_max, 44001},
			   {inet_dist_listen_min, 44001}
			  ]
			 }
			].
		EOF

        rabbitmq-server -detached
        echo "Waiting 10s for rabbitmq server to be ready"
        sleep 10

        if [ "$RABBITMQ_VHOST" -o "$RABBITMQ_USER" ]; then

            if [ "$RABBITMQ_VHOST" ]; then
                rabbitmqctl add_vhost $RABBITMQ_VHOST
            fi

            if [ "$RABBITMQ_USER" -a "$RABBITMQ_PASSWORD" ]; then
                rabbitmqctl add_user $RABBITMQ_USER $RABBITMQ_PASSWORD

                if [ "$RABBITMQ_VHOST" ]; then
                    rabbitmqctl set_permissions -p $RABBITMQ_VHOST $RABBITMQ_USER ".*" ".*" ".*"
                fi
            fi
        fi
        rabbitmqctl stop
    fi
fi

exec "$@"
