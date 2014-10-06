## Welcome to Horizon!

Horizon is an application for completing and reviewing challenges. Use the [Browse][browse] link in the navigation bar to view a list of available challenges and supporting material.

Once you're ready to get started, [sign in or register][sign_in] for an account using your Github login (you need to be a member of the Launch Academy organization to register). Once registered, you'll be able to submit your solutions to challenges via our command-line tool **et**.

## Installation

To complete the challenges you'll need to setup a development environment. At a minimum this consists of installing Ruby to run our code and a text editor to modify it.

### Local Development Environment (Mac OS X / Linux only)

If you're on a UNIX-like operating system (e.g. Mac OS X or Linux) you can try setting up a local development environment (i.e. installing the necessary software on your computer).

[Rocket fuel][rocket-fuel] is an installation script that will install Ruby, the Atom text editor, and a handful of other useful utilities for OS X and Linux (Windows support is pending). Follow the instructions on the [GitHub][rocket-fuel] page to run the installer.

### Remote Development Environment

If you're not using OS X or Linux or are having issues installing some of the software, we recommend using [Nitrous.IO][nitrous-io] to setup a remote development environment. Nitrous.IO provides an in-browser development environment including a text editor and a terminal.

To get started, sign up for an account and create a new box with the **Ruby/Rails** template. Choose a name for your box, select a region close to you, and choose the minimum settings for *Memory* and *Storage*. Click **Create Box** to startup your development environment.

At this point you should see a few windows in the browser. In the center there is a text editor which is used to write our Ruby programs. Along the bottom is a console window where we can enter commands in the terminal. The window on the left shows our file hierarchy and can be used to select which files are being edited.

## Configuration

Once you have Ruby and an editor installed, open a terminal and install the **et** gem:

```no-highlight
$ gem install et
```

The **et** gem is the interface for retrieving and submitting challenges to Horizon.

Before we retrieve any challenges let's create a directory to store our work in. From the terminal, run the following commands (**the `$` does not need to be typed in and is used to represent the terminal prompt**):

```no-highlight
$ mkdir ~/challenges
$ cd ~/challenges
```

This will create a new directory for storing challenges and change into that directory (the `~` character represents your home directory). Now we can configure our Horizon account with the **et** gem. To do so we'll need three pieces of information:

* Username. If you've signed into Horizon you should see your username in the top-right corner of the web page (e.g. `Signed in as <username>`) This should be the same as your GitHub username.
* Authentication Token. When signed in, click on the `Signed in as <username>` link on the top-right corner of the web page to view your account settings. Click the *Toggle* link next to *Token* to view your authentication token.
* Server. This is the location of the Horizon web server. You can enter `https://horizon.launchacademy.com` for this field.

To configure **et**, run the `et init` command in the terminal. Here's a sample run:

```no-highlight
$ et init

Username: atsheehan
Token: yOuRsEcReTtOkEnGoEsHeRe
Host: https://horizon.launchacademy.com

Saved configuration to /home/asheehan/challenges/.et
```

This command will store your configuration in a hidden file under the `~/challenges` directory. To verify it was saved correctly, run the following command:

```no-highlight
$ cat ~/challenges/.et
```

And this should produce the settings you have just entered:

```yaml
---
username: atsheehan
token: yOuRsEcReTtOkEnGoEsHeRe
host: https://horizon.launchacademy.com
```

## Downloading Challenges

Once **et** is configured, we can download a challenge to work on. Run the following command within the `~/challenges` directory to view the list of challenges available:

```no-highlight
$ et list

 slug                         | title
--------------------------------------------------------------
 compound-interest-calculator | Compound Interest Calculator
```

The table contains the title of the challenge as well as the *slug* that we reference it with. In this case there is only one challenge which we'll download using the **get** command:

```no-highlight
$ et get compound-interest-calculator
Extracted challenge to /home/asheehan/challenges/compound-interest-calculator
```

If everything worked correctly we should have a new directory containing our challenge:

```no-highlight
$ ls
compound-interest-calculator
```

The `ls` command lists the files in the current directory and we can see an entry for `compound-interest-calculator`. This is a directory that we can `cd` into:

```no-highlight
$ cd compound-interest-calculator
$ ls
calculator.rb    compound-interest-calculator.md
```

Here we have two files: `calculator.rb` which is where we should write our code and the instructions in `compound-interest-calculator.md`. At this point you can open `calculator.rb` in your text editor and start working on the challenge!

## Submitting Challenges

Once you've completed the challenge (by writing code in `calculator.rb`) you can submit it with the **et submit** command within the `compound-interest-calculator` directory:

```no-highlight
$ et submit
Challenge submitted
```

Congratulations! At this point, your code has been submitted to Horizon and be viewed on your profile page.

[browse]: /lessons
[sign_in]: /session/new
[rocket-fuel]: https://github.com/LaunchAcademy/rocket-fuel
[install-ruby]: https://www.ruby-lang.org/en/installation/
[rvm]: http://rvm.io/
[ruby-installer]: http://rubyinstaller.org/
[sublime-text]: http://www.sublimetext.com/
[atom]: https://atom.io/
[iterm2]: http://iterm2.com/
[ubuntu-vm]: http://www.wikihow.com/Install-Ubuntu-on-VirtualBox
[nitrous-io]: https://www.nitrous.io/
