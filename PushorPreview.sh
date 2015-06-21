while getopts spm: OPTION
do
	case $OPTION in
		p )
			antiCommentString="s/"`grep pygments _config.yml`"/highlighter: pygments/g"
			commentString="s/"`grep rouge _config.yml`"/# highlighter: rouge/g"
			
			sed -i "$antiCommentString" _config.yml
			sed -i "$commentString" _config.yml

			message=`date +%Y-%m-%d-%H-%M-%S`
			git add --all
			git commit -m "$message"
			git push

			echo "Push Finished"
			echo "Push Message $message"

			;;
		s)
			commentString="s/"`grep pygments _config.yml`"/# highlighter: pygments/g"
			antiCommentString="s/"`grep rouge _config.yml`"/highlighter: rouge/g"
			sed -i "$commentString" _config.yml
			sed -i "$antiCommentString" _config.yml
			jekyll s						
			;;
		m)
			antiCommentString="s/"`grep pygments _config.yml`"/highlighter: pygments/g"
			commentString="s/"`grep rouge _config.yml`"/# highlighter: rouge/g"
			
			sed -i "$antiCommentString" _config.yml
			sed -i "$commentString" _config.yml

			git add --all
			git commit -m "$OPTARG"
			git push

			echo "Push Finished"
			echo "Push Message $OPTARG"
			
	esac
done
