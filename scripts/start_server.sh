script_dir=$(dirname "$(readlink -f "$0")")

export PERL5LIB=$script_dir/../lib:$PERL5LIB
export KB_DEPLOYMENT_CONFIG=$script_dir/../deploy.cfg

plackup $script_dir/../lib/contigcount.psgi
