# Getting Started on OSS Contributions

A lot of us PowerShell folks have one foot in the developers' dorm room door in our daily life.
I have seen on several occasions that the main barrier to contributing back to the tools we use can
easily just be a matter of _I don't know how_.
After all, many of the tools we use _are_ open source, and for the vast majority of us our favourite
tools are actually _written_ in PowerShell code; our favourite modules are often largely native
code, though there are several that may be compiled cmdlets instead.

Those of us who _have_ worked with **git** before will know some or all of the topics being
discussed here, but for those of us less familiar, I will cover the topic from the absolute basics,
step by step.

## Learn By Example: Contributing to PowerShell Core

The first things you will need in order to make this happen are:

* Git
* A GitHub account

Although, depending on where the original project is hosted, you may instead wish to use a BitBucket
or other git-hosting website for ease of interaction.

### Install Git

[Download Git](https://git-scm.com/downloads)

In the above link, you'll find download links for most common operating systems.
Download and install the application per the instructions.
On Windows it includes a GUI interface as well as the standard command line.
However, I have found that the command line is a bit easier to work with, as a majority of online
instructions work with the command line primarily.
If your editor of choice (I'll be using VS Code here) includes Git integration, these GUI options
are often much easier to use.

Once done, verify `git` has been added to your `$env:Path` variable by calling it from a console
window; this guide will assume you're using PowerShell as your console of choice, as it will be
required to set up your build environment.

### Fork the Repo

[Sign up to GitHub](https://github.com/join)

Once you have a GitHub account, the first thing you'll need to do when starting to work with an
open source repo is to **fork** it.
This creates a copy of that repository in your own GitHub account, which will be necessary in order
to create new branches and do all necessary preparation for a pull request.

To **fork** the [PowerShell/PowerShell](https://github.com/PowerShell/PowerShell) repository, go to
the main repository page and click the **Fork** button in the top-right of the main page.

![Fork the PowerShell repository](./images/PowerShell-Repo.png)

This will create a copy of the repository housed under your own account.

### Clone Your PowerShell Repository

Once you've been redirected to the new repository page, you can get the clone link from your own
repository.
Select the green **Clone or Download** button, and then copy the link from the popup pane.

![Get your Clone link](./images/Clone-Your-PowerShell-Repo.png)

Now, drop into your favourite command line console and navigate to a folder you would like to clone
the repository to.
To clone the repository, enter the following command:

```powershell
git clone <URL> [<Folder>]
```

Where `<URL>` is the URL to the `.git` file that the clone link specifies, and `<Folder>` is the
folder you would like the repository cloned into.
The default folder `git` creates matches the name of the repository itself.
In this case, the URL should be `https://github.com/PowerShell/PowerShell.git` and the folder
name can be left blank (`git`)
Your full command should look like this:

```powershell
git clone https://github.com/PowerShell/PowerShell.git
```

