import re
import os
import glob
import webbrowser

project_code = 'TST'
jira_url = 'https://example.atlassian.net/issues/'

re_pat = re.compile(fr'({project_code}-\d+)')
dir_path = os.getcwd()
files = sorted(glob.iglob(dir_path+"\\*.txt"), key=os.path.getctime, reverse=True)
with open(files[0]) as f:
    raw_data = f.read()
    issues = re.findall(re_pat, raw_data)

key_in = "%2C%20".join(issues)
filter_result = f"{jira_url}?jql=key%20in%20({key_in})"
webbrowser.open(filter_result)
