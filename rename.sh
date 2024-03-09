#!/usr/bin/env bash

function replace-tokens {
  local token=$1
  local replacement=$2

  echo "Replacing $token with $replacement"

  files=$(grep -rl "$token" . | grep -v "rename.sh")

  if [ "$(uname)" = "Linux" ]; then
    sed_cmd="sed -i"
  else
    sed_cmd="sed -i ''"
  fi

  xargs $sed_cmd "s/$token/${replacement//\//\\/}/g" <<<"$files"
}

if [ "$#" -ne 2 ]; then
  echo "Usage: rename.sh <gem-name> <namespace>"
  echo "e.g. rename.sh test_bench-some-project TestBench::Some::Project"
  exit 1
fi

gem_name=$1
repo_name=${gem_name//_/-}
path=${gem_name//-/\/}

namespace=$2

echo
echo "Renaming Project"
echo "= = ="
echo
echo "Gem Name: $gem_name"
echo "Repository Name: $repo_name"
echo "Lib Path: lib/$path"
echo "Namepace: $namespace"
echo

if [ "${PROMPT:-on}" = "on" ]; then
  echo "If everything is correct, press return (Ctrl+c to abort)"
  read -r
fi

echo "Writing $gem_name.gemspec"
echo "- - -"
mv -v TEMPLATE.gemspec "$gem_name.gemspec"

echo
echo "Renaming directories"
echo "- - -"
find . -type d -name "TEMPLATE" | while read -r dir; do
  dest="${dir//TEMPLATE/$path}"

  echo "Moving $dir -> $dest"
  mkdir -p "$(dirname "$dest")"
  mv "$dir" "$dest"
done

echo
echo "Renaming files"
echo "- - -"
find . -type f -name "TEMPLATE.*" | while read -r file; do
  dest="${file//TEMPLATE/$path}"

  echo "Moving $file -> $dest"
  mkdir -p "$(dirname "$dest")"
  mv "$file" "$dest"
done

echo
echo "Replacing tokens"
echo "- - -"
replace-tokens "TEMPLATE-GEM-NAME" "$gem_name"
replace-tokens "TEMPLATE-REPO-NAME" "$repo_name"
replace-tokens "TEMPLATE-PATH" "$path"
replace-tokens "TEMPLATE-NAMESPACE" "$namespace"

echo
echo "Installing gems"
echo "- - -"
./install-gems.sh

echo
echo "Running example test"
echo "- - -"
ruby -w -r./test/automated/automated_init.rb <<'RUBY'
context "Example Context" do
  test "Some test" do
    assert(true)
  end
end
RUBY

echo
echo "Deleting rename.sh"
echo "- - -"
rm -v rename.sh

echo
echo "- - -"
echo "(done)"
