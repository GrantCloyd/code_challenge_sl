# Code Challenge

Created based on specifications for the SmartLogic code challenge. 

## Version

- Ruby:  -v 2.7.4
- Rspec: -v 3.10
- Bundler: -v 2.2.4

## Getting started: GitHub
To download and set-up the program, use the following commands:

```
git clone https://github.com/GrantCloyd/code_challenge_sl.git
cd code_challenge_sl
bundle
```

## Getting started: Zip
Unzip the file, cd into the containing directory, and use the the following commands: 
```
cd code_test
bundle
```

You should see:

```
Bundle complete! 1 Gemfile dependency, 7 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

If not, make sure your bundler is up to date. See this [site](https://bundler.io/) for more information

## Running the program

To run the program type `rspec` while in the code_challenge_sl root directory. This will print the sorted order of the input-files, run 7 rspec tests, and generate a file in the root directory called `output.txt`. The `output.txt` file takes a few seconds to be created. 

You can open the newly created file from the command line on mac using `open output.txt` or print it directly to the console using `cat output.txt`.
