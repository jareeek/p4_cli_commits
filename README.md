## Script Purpose
💻 This script allows user to quickly collect commit messages from perforce server since desired revision. It may be used for regression testing in various domains.

ℹ️ Note that if your commit messages contain Jira-ID in format ID-XXXX, it will automatically open jira filter with affected issues.

## Pre-conditions
Before using this script, make sure you have Perforce client and Command Line Interface .exe installed.
1. Make sure Python 3.10+ is installed. You can download it freely at [official site](https://www.python.org/downloads/)
2. Proceed to commit_parser.py file and change variables project_code and jira_url to desired ones. (Note that jira url should contain everything before jql query part)

![image](https://github.com/jareeek/p4_cli_commits/assets/127681569/82b3894c-99d2-4ea6-b794-a77c56870c80)


3. Open commits.bat file in any text editot and change server variable to your perforce server and port.

![image](https://github.com/jareeek/p4_cli_commits/assets/127681569/387accdf-940f-40d8-8275-243bd8676bdf)


## Running the script
To use the script, simply run the **commits.bat** file. On the first launch (or if authentication token is expired) it will ask you to enter your credentials. This step will be omitted if authentication check exits with 0 error code later.

**commits.bat** file prompts user for revision number to filter commits. Simply type in numeric value of revision that will serve as a lower threshold for your commits file.

If executed successfully, commits since revision you typed in will be output to **commits_since_rXXXX.txt** file in script's root directory. Also jira filter with affected issues (if commit messages have jira ID in them) will open in your default browser.
