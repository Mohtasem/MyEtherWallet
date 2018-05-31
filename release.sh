# openssl aes-256-cbc -K $encrypted_85fecf66b314_key -iv $encrypted_85fecf66b314_iv -in mew.gpg.enc -out mew.gpg -d;
mkdir deploy;
# gpg --allow-secret-key-import --import mew.gpg;

PACKAGE_VERSION=$(cat package.json | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[",]//g' | tr -d '[[:space:]]');

zip -r ./deploy/release-"$PACKAGE_VERSION".zip ./dist;

for f in deploy/*; do
  gpg --output $f.sig --detach-sig $f
done;

git tag v$PACKAGE_VERSION; git push --tag
