how git works pluralishgt by paolo perrota


Part 1 git is not what yhou think
##################################


git porcelain (high level commands)

git status
git add
git commit
git push
git pull 
git branch
git checkout
git merge
git rebase

plumbing commands (lower level)

git cat-file
git hash-object
git count-objects

git as onion

git is  
 discard a distributed revision control system
 discard  branches
 discard content tracker

 git is  a persistent map  in its core

 values and kyes
 sha1  hash values

  every object in git has its own SHA1  key
  collision ? 

cd gitrepo
  git init
  ls -lta  .git
>echo "Apple Pie" |  git hash-object --stdin -w
>git cat-file bb3918d5053fea31fc9a58fae1e5bdeabe3ec647 -p
"Apple Pie"

>git status   (all files should be untracked
)

>git add menu.txt
>git add recipes
>git status (all fles should be in green)


>git commit -m "initial commit"
>ls -lta .git/objects
>git status  (status is cleared)
>git log (to see the list of commits)

 >git cat-file -p 86e29fffb089b629833d92a439905db3dcbbbfda   (sha1 of the commit by git log)
 we see the sha1 of the tree
 >git cat-file -p 23991897e13e47ed0adb91a0082c31c82fe0cbe5
 "Apple Pie"

===> this is how the object database tree is created
cat "\nCheesecake" recipies.txt
>git add recipies.txt
>git status
>git commit -m "add cake"
>git log

>git count-ojbects   
 <- git does not store  a new blob for unchaged files during the commits 
   =>  efficiency  event with small commits


tags  regular tags, annotated tags  

>git tag -a mytag -m "i love cheesecake"
>git tag

===> git objects  =  { blobs, trees, commits, annotated tags}


Part 2. branches
##################################
>git branch
master

a branch is just a refernce
ls -lta .git/refs/heads/

>git branch lisa  ( new branch created)
>git branch
lisa
* master     (asteriks shows the current branch)

$ cat .git/refs/heads/lisa
5c744f3e6320b6d65a0710aa0b33d66cdfce8589

$ cat .git/refs/heads/master
5c744f3e6320b6d65a0710aa0b33d66cdfce8589

same sha1 i.e. branches are pointing to the same commit


$ cat .git/HEAD
ref: refs/heads/master
current branch refrences to master

the master branch points to the latest commit but not the lisa branch


switch the branch
$ git checkout lisa
Switched to branch 'lisa'

$ git branch
* lisa
  master

$ cat .git/HEAD
ref: refs/heads/lisa



cat recipes/apple_pie.txt
shows no added incredients (file version was reverted )

>git add recipies/apple_pie.txt
>git commit -m 'lisa version of recepee'

how to merge branches

1. switch to master
git checkout master

>git merge lisa

will make a confilict 
vi recpies/apple_pie.txt     and resolve the conflict manually
>git status
>git add recpies/apple_pie.txt
>git commit  (opens the warning commit message. accept it)

>git log
git cat-file -p c0484b17f9ac093732e29fe6ea3e4b70fefb7586
2 parents sha1


git (mostly) does not care about your working directly   cares about  db in .git


corner case updating lisa branch with master: 
switch to lisa
and merge from master

> git merge master
Updating a12e850..c0484b1
Fast-forward
 recipes/apple_pie.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

detached head

> git checkout c0484b1

> git branch
* (detached from c0484b1)
  lisa
  master

> commit, commit

> git checkout master
Warning: you are leaving 2 commits behind, not connected to
any of your branches:

  432c21f remove smth
  cce54be add more apples

If you want to keep them by creating a new branch, this may be a good time
to do so with:

 git branch new_branch_name 432c21f

> git checkout 432c21f
>git branch nogood
  (have my excperimental commits in nogood branch to keep it)

if you ommit to detached head and switch back to a branch   the commits are still existing but become unreacheable 


git model 
  three rules
  1. current branch tracks new commits
  2. when yhou move to another commit, git updates your working directory
  3. unreachable objects are garbage collected
  

part 3.  Rebasing made simple

rebase less frequent than merging

create spaghetti branch
>git branch spaghetti
>add recipes/spaghetti_ala_corbonara.txt
commit

switch to master
>git checkout master
>git rebase spaghetti
>git log  ( we see all master commits + spaghetti commits)

git garbage-collects unreacheable objects

rebase vs merge

merges preserve history  
rebases refactor history (look simpler, can loose orphan commits)
When in doubt, just merge instead of rebase

   merge
   x
 /  \
|    |
x    x
|    |
x    x
 \  /
   x


rebase
x
|
x
|
x
|
x
|


a tag is like a branch that doesn't move


part 4. distributed version control
###################################

>git clone https://github.com/nusco/cookbook.git

copied the .git  db 
got only 1 master branch

but both computers  remote and local contain the same .git  

>cat .git/config
localhost:cookbook zimine$ cat .git/config
[core]
  repositoryformatversion = 0
  filemode = true
  bare = false
  logallrefupdates = true
  ignorecase = true
  precomposeunicode = true
[remote "origin"]
  url = https://github.com/nusco/cookbook.git
  fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
  remote = origin
  merge = refs/heads/master


  >git brach --all     shows all existing remote branches

> git show-ref master
704182f5e2925fbdc03f9874d35ce696c21e9a3d refs/heads/master
704182f5e2925fbdc03f9874d35ce696c21e9a3d refs/remotes/origin/master

> git show-ref lisa
ecbebe6601f5730ed6157f95175204cdf4d0542a refs/remotes/origin/lisa


now make new commit in ref/heads/master
>git show-ref master will show different sha1 for local and remote masters
to syncrhonize  use 
>git push
>git show-ref  master will show same sha1 for local and remote sha1

if somebody  esle changed the remote master,  you cannot push  there will be a conflict
option 1. git push -f  (forced, not recommended)
option 2. resolve conflict on one own machine before pushit  ->  git fetch
>git fetch
>git merge
== >git pull  
then you push


Never rebase shared commits

###################
GitHub features
####################
Fork   is like a clone, but you clone to your own accout with rw access where you can laterly push
after fork there is no connection with the original project 

create an upstream connection from  hyour dev machine to the original project repo
solve conflicts with upstream then push to  new origin

Pull Request   (= send a message to original project maintaners  so that they can 
pull changes from your origin)

0. how to crete a new repo on github
####################################
on root page top right corner  near the avatar click on "+" icon  -> new repository

1. how to clone a repo from github
####################################
in github got to your repo page,  click on 'Clone or downlaod', copy the https adresse

in the terminal  got to a folder which ill contain a fork
>git clone https://github.com/slzdevsnp/hello-world-git.git

https://github.com/slzdevsnp/hello-world-git.git

>cd hello_world-git 
>git status
#modify code add changes. 
>git add file.x
>git commit
>git status
your branch is agead of 'origin/master' by 1 commit

> git push  #will ask interactively github username  and github password

## will not ask any questions
>git push https://github.com/slzdevsnp/hello-world-git.git master


2. how to add existing repo to github 
####################################

cd project_folder
git init
git add  all files
git commit -m "initial commit"

in github web site create new repo without creation of readme.md an follow istructions

cd project_folder
echo "# reponame" >> README.md
git add README.md
git commit -m "add readme"
git remote add origin https://github.com/slzdevsnp/reponame.git
git push -u origin master  # master is your current branch

git remote -v  #shows fetch and push remote repo urls


3. how to get updates from remote
###################################

git pull 


4. github
###################################
#create a new branch
git checkout -b [name_of_new_branch]

#push the branch to github
git push origin [name_of_new_branch]

## see on which branch
git branch  

#push the branch to github
git push origin [name_of_your_branch]


#update your branch when the original branch from tofficial repository has been updated
git fetch [name_of_your_remote]

#merge (if your branch is derivated from master)
git merge [name_of_remote]/master

#to see remote name
git remote -v

#delete a branch on your local FS
git branch -d  [name_of_branch]

#delete a branch on github
git push origin :[name_of_branch]



##how to clone a repo under a different name

git clone https://zslava@github.com/zslava/wyck.git

# when you do git commit; git push you can specify a user name password 

git push https://zslava:serobourmalinNapoleon@github.com/zslava/wyck.git





