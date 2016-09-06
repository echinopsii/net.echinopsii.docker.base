#!/bin/zsh
help() {
	echo "Usage: $0 nb_nodes (MUST be an integer >= 2)"
	exit 1
}

if [ $# -ne 1 ]; then
	help
fi

nb_nodes=$1
re='^[0-9]+?$'
if ! [[ $nb_nodes =~ $re ]] || [[ $nb_nodes -lt 2 ]]; then
   help
fi

echo "Cassandra Murmur3Partitioner tokens for a $nb_nodes nodes cluster : " 
python -c "print [str(((2**64 / $nb_nodes) * i) - 2**63) for i in range($nb_nodes)]"
