# Richmond Computer Club Project \#1

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Setup](#setup)
  - [Prerequisites](#prerequisites)
  - [Preparation](#preparation)
  - [Start Vagrant](#start-vagrant)
  - [Prepare Our Workspace](#prepare-our-workspace)

## Setup

### Prerequisites

You will need:

1. Internet
2. VirtualBox
3. Vagrant
4. Git

If you have all of the above, skip the installation instructions below.

VirtualBox is open source [virtual machine](http://en.wikipedia.org/wiki/Virtual_machine) software. Vagrant is a tool that enables us to easily include virtual machine configurations with our projects, build and run the virtual machines with a single command, and do this all in a repeatable, cross-platform manner. By doing this we can all work on the project together in our identical virtual machines without running into problems unique to our own computers—everything should work the same for everybody.

Git is [SCM](http://en.wikipedia.org/wiki/Software_configuration_management) software. Rather than simply saving our files and only having access to the latest version of our files, it gives us the ability to go back in time and see every revision to a file we've "committed" to git (take a look at the [git documentation](http://git-scm.com/doc) to learn more about commits, among other things). Further more, it uses a concept called branching. We can create multiple branches, and branches on our branches, in order to maintain different states of our project. For example, you may want to work on two features at the same time, but one of those features will be done first and ready to deploy before the other. Git is very powerful and we will only scratch the surface during the course of this project. However, it is integral to any software project, whether you are the sole developer or one of thousands.

#### VirtualBox

VirtualBox is easily downloaded and installed with a GUI installer. It works on OS X, Windows, and Linux. To download the installer, visit the [downloads page](https://www.virtualbox.org/wiki/Downloads) and under 'VirtualBox Platform Packages' find your operating system and click the link next to it to download. Once the download is complete open it up and install--it's a pretty standard process.

#### Vagrant

Vagrant is easy as well. Same drill; download the installer and install. Here's the [downloads page](http://www.vagrantup.com/downloads).

#### Git

And again with git. [Downloads](http://git-scm.com/downloads). *If you are on a Mac, when you try to run the installer, you may get a message that says "git-2.0.1-intel-universal-snow-leopard.pkg can't be opened because it is from an unidentified developer"—this is okay—right click it instead, click "open", and you will be given the option to open it anyway.* We are installing git here simply to retrieve the project files, which include Vagrant files. After this, we will be using git from within our virtual machines to manage our progress through the project.

### Preparation

Now that we have the requisite software, we can get the project's source code which includes the Vagrant files that specify how to build our virtual machine.

The first thing we should do is to let git know what our name and email address are. Git will use this information to identify us when we make commits. Also, Vagrant will use this information that we set to build our virtual machine later. In your terminal type the following commands, exactly as you see them, but replace my name and email address with yours.

```shell
git config --global user.name "Robbie Pitts"
git config --global user.email robbie@example.com
```

I like to keep all my local repositories in a directory called `repos` in my home directory (your home directory is your user account directory; on a Mac your home directory is the one that holds your Documents directory, Pictures directory, etc., on Windows your home directory is the one that holds My Documents, etc.). You don't have to do this, but I recommend deciding on a way to organize the repos that you will accumulate over time. If you want to organize things the way I do, create your `repos` directory now.

In your terminal `cd` to the directory where you are keeping your repos. If you are doing things like me your command will look like this:

```shell
cd ~/repos
```

As an aside, the tilde character is a shortcut for your user's home directory. I could have typed in `cd /Users/robbie/repos` and the exact same thing would have happened. Also, `cd` means "change directory".

If all this is new to you, I recommend double-checking what directory you're in now. You can do this by putting in the command `pwd`, which means "print working directory". If the output looks like the right directory, continue.

The following command will copy the project repo onto your computer, in your current directory:

```shell
git clone https://github.com/sweatypitts/rcc-one.git
```

Now `cd` into the repo with the following command. Note that if you have RVM installed, it may whine at you that you don't have a certain version of Ruby installed. Ignore this. We will be doing development within the virtual machine which will already have the proper version of Ruby installed for you. The command:

```shell
cd rcc-one
```

### Start Vagrant

Still in your terminal, in the project directory, run the following command:

```shell
vagrant up
```

This will start up your virtual machine, which comes pre-packaged with everything you need to start development on this project. You will see a lot of output, which is good. This can take several minutes. When it stops, and your prompt comes back up, read the last bit of output and see if it mentions any errors. If not, you're good to go.

At this point, your virtual machine is up and running. The current directory you're in is synced with the `/vagrant` directory in your virtual machine. If you make a change to a file in one place, it will reflect immediately in the other. Because of this, we will use a text editor, like Vim or Atom, on our real computers to write and modify code in our real computer's file system. However, when it comes time to run commands in the terminal or run a web server or use git to manage the repo, we will do so in the virtual machine.

Before we go into our virtual machine, let's open up our project in our text editor. If you're using atom, enter `atom` in your terminal, `subl` if sublimetext, `mvim` (for MacVim) or `vim` for Vim, etc.

Now we can `ssh` into our virtual machine's terminal. Vagrant has a shortcut command for this. Run the following command:

```shell
vagrant ssh
```

You'll now notice your prompt has changed. You are in your virtual machine's terminal. You're basically using a whole other computer which is embedded in your computer.

Now you want to `cd` to the project's directory, which is the same directory that is synced with your computer. This is located at `/vagrant`:

```ruby
cd /vagrant
```

Observe the slash preceding the word "vagrant". This is an absolute path, with `/` being the root path. Describing a path any other way is a relative path; that is, relative to the current context.

If you enter `ls -l` in the terminal, you should see a list of the project files like this:

```
total 56
drwxr-xr-x 1 vagrant vagrant  272 Aug  9 19:03 app
drwxr-xr-x 1 vagrant vagrant  170 Aug  9 19:03 bin
-rw-rw-r-- 1 vagrant vagrant  474 Aug  9 19:03 bower.json
drwxr-xr-x 1 vagrant vagrant  374 Aug  9 19:03 config
-rw-rw-r-- 1 vagrant vagrant  154 Aug  9 19:03 config.ru
drwxr-xr-x 1 vagrant vagrant  170 Aug  9 19:03 db
drwxr-xr-x 1 vagrant vagrant  204 Aug  9 19:03 features
-rw-rw-r-- 1 vagrant vagrant  434 Aug  9 19:03 Gemfile
-rw-rw-r-- 1 vagrant vagrant 4343 Aug  9 19:03 Gemfile.lock
drwxr-xr-x 1 vagrant vagrant  136 Aug  9 19:03 lib
...
```

### Prepare Our Workspace

We can now run the following command in the terminal in order to install the gems specified in the `Gemfile`. Bundler is a ruby gem itself which uses the `Gemfile` to manage dependencies in ruby projects. The `bundle` command is how we use Bundler.

```shell
bundle install
```

It's a good idea to run `bundle install` when you first clone a new project, which is what we've done. You would also run it if you added a new gem to the Gemfile.

We also need to install our javascript dependencies. We'll use bower to do that. Bower is written using nodejs, a javascript runtime. Run the following command:

```shell
bower install
```

Right now we're in the `master` branch of the repo, which, by convention, is usually the latest version of a project. However, that's not where we want to be if we're trying to build this ourselves. If you're starting from the beginning and want a clean slate, checkout the `week_0` branch and create a new branch from that branch. You can call it `wip` or whatever makes sense to you. It will be the branch you'll be working on this project in. If you're starting from a different week, say week 2, checkout the week 1 branch and branch off of that rather than the week 0 branch. Run the following commands in your terminal to do what I've been talking about:

```shell
git fetch
git checkout week_0
git checkout -b wip
```

The `fetch` command will get all "refs" from the "origin" remote. You do not need to fetch every time you check out a branch, but since this is a new project on our system, we only have the master branch. Explaining the ins and outs of git is way out of the scope of this project, so if you'd like to learn more please take a look at the [documentation page](http://git-scm.com/doc) on the git website. It has information for both people who have no background knowledge of version control and those who need a reference for advanced topics. In addition, it also has some videos. Git, or more generally version control, is an integral part of any software project, so it is highly recommended that you become familiar with it if you are not already.

In the third command you'll notice the `-b` option for the `checkout` command. This option will create the new branch before checking it out. If you omitted the `-b` it would whine that there is no branch called `wip`.

To verify that you are currently in the `wip` branch, run the following in your terminal:

```shell
git branch
```

This will list all of the branches currently on your machine and put an asterisk by your current branch.

You can now proceed to work on your current week. To do so, I recommend going to this repo's [GitHub page](https://github.com/sweatypitts/rcc-one) and opening up the current week's instruction document. For example, if this is the second week open up `week_2.md`.
