#!/usr/bin/env bash
set -e

oldpwd="$PWD"
worktree="$(mktemp -d)"

trap '{ rm -rf -- "$worktree"; }' EXIT

git worktree add "$worktree"

trap '{ git worktree remove -f "$worktree"; rm -rf -- "$worktree"; }' EXIT

cd "$worktree"

git branch -D gh-pages || true
git checkout --orphan gh-pages
git rm -rf .

cp -r "$oldpwd/demo"/* .

git add -A
git commit -m deploy
git push --force -u origin gh-pages
