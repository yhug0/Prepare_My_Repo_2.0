if [ -z "$1" ];
then
    echo "no name"
elif [ "$1" = "-h" ];
then
    echo ""
    echo "   Prepare_my_repo {REPO_NAME} for create a repo"
    echo "   Prepare_my_repo {REPO_NAME} -i for information"
    echo "   Prepare_my_repo {REPO_NAME} -add {USER} for add a user to your project"
    echo "   Prepare_my_repo {REPO_NAME} -delete for delete the repo"
    echo "   Prepare_my_repo {REPO_NAME} -clone {USER} clone a repo | if USER does not exist it will be replace by your login"
    echo ""
    echo "   echo -n ''PASSWORD'' | sha512sum | cut -f1 -d' ' to create your TOKEN"
    echo "   Prepare_my_repo {REPO_NAME} -clone {USER} for clone a repo no arg if the user is you"
    echo ""
else
    TOKEN="YOUR_TOKEN MADE BY THE COMMAND IN -H"
    NAME="YOUR_LOGIN"
    
    if [ -z "$2" ];
    then
	blih -u $NAME -t $TOKEN  repository create $1 
	blih -u $NAME -t $TOKEN repository setacl $1 ramassage-tek r
	blih -u $NAME -t $TOKEN repository getacl $1  
	git clone git@git.epitech.eu:/$NAME/$1
    else
	if [ "$2" = "-remove" ];
	then
	    read -p "Are you sure y\n ? " -n 1 -r
	    echo
	    if [ "$REPLY" = "y" ];
	       then
		   blih -u hugo.frugier@epitech.eu -t $TOKEN repository delete $1 
	    fi
	elif [ "$2" = "-i" ];
	then
	    echo ""
	    blih -u $NAME -t $TOKEN repository info $1
	    echo ""
	    blih -u $NAME -t $TOKEN repository getacl $1
	    echo ""
	elif [ "$2" = "-add" ];
	then
	    if [ -z "$3" ];
	    then
		echo "no login"
	    else
		blih -u $NAME -t $TOKEN repository setacl $1 $3 rwa
	    fi
	elif [ "$2" = "-clone" ];
	then
	    if [ -z "$3" ];
	    then
		git clone git@git.epitech.eu:/$NAME/$1
	    else
		git clone git@git.epitech.eu:/$3/$1
	    fi
	else
	    echo "BAD OPTION ! You have some help with : -h"
	fi
    fi
fi
