git checkout -b gh-pages
git merge master
cp -r website/. .
git add .
git commit -m 'build'
git push origin gh-pages
git checkout master
