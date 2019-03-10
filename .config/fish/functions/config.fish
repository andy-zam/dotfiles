# Defined in - @ line 0
function config --description 'alias config /usr/bin/git --git-dir /home/andy/.dotfiles --work-tree=/home/andy'
	/usr/bin/git --git-dir /home/andy/.dotfiles --work-tree=/home/andy $argv;
end
