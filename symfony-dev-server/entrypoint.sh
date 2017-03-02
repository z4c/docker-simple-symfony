#!/bin/sh

alias sf="php app/console"

[ -z "$1" ] && {
	[ ! -d ./vendor ] && {
	    echo "
	    
	    Installing composer dependencies...
	    
	    "
		export APP_VERSION=`git describe --abbrev=0 --tags`
		[ -z "$SECRET_TOKEN" ] &&  
			export SECRET_TOKEN=`git rev-parse HEAD`
		composer install --dev --no-interaction &&
		sf cache:clear --env=dev --no-interaction
	}
	[[ `sf doctrine:schema:update --dump-sql` == "Nothing to update"* ]] || {
	    echo "
	    
	    Updating database...
	    
	    "
	    sf doctrine:schema:update --force --no-interaction 
	    sf doctrine:migrations:migrate --no-interaction 2>/dev/null 
		sf doctrine:fixtures:load --no-interaction 2>/dev/null 
		sf faker:populate --no-interaction 2>/dev/null 
	}
	
	figlet "Rock'n'Roll"
	sf server:run $APP_SERVER_HOST:$APP_SERVER_PROT --env=dev $APP_SERVER_VERBOSITY

} || exec "$@"
