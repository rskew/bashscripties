# tar GPG and SSH keys, then symmetrically encrypt it.
# This password-protected set of keys will be ok-ish to
# backup onto private stores.
# Only public-key (asymmetric) encrypted files should be
# stored publicly (like on Github).

now=$( date +%s )
backupsdir="backup-keys-"$now
keyfiletar="keys-"$now".tar"

mkdir $backupsdir

cp -r ~/.ssh ./$backupsdir
cp -r ~/.gnupg ./$backupsdir

tar --create --file $keyfiletar ./"$backupsdir"

rm -rf ./"$backupsdir"

gpg -e -r "Rowan Skewes" $keyfiletar

rm -f $keyfiletar
