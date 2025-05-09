#!/usr/bin/env bash

parts=$1

if [[ "$parts" -gt 5 ]]; then
    echo "warning: partitions can't be greater than 5"
    exit 0
fi

total_commits=$(git rev-list HEAD | wc -l | tr -d ' ')
echo "Total commits: ${total_commits}"

first_commit=$(git rev-list --reverse HEAD | sed -n '1p')
last_commit=$(git rev-parse HEAD)

add_worktree() {
    local name=$1
    local hash=$2

    if [ ! -d "name" ]; then
        echo "Adding ${name} -> ${hash}"
        git worktree add $1 $2 > /dev/null
    fi
}

add_worktree "tree-initial" $first_commit

for (( i=$parts ; i>1 ; i-- ));
do
    index=$((total_commits / i))
    hash=$(git rev-list --reverse HEAD | sed -n "${index}p")
    add_worktree "tree-${index}" $hash
done

add_worktree "tree-head" $last_commit
