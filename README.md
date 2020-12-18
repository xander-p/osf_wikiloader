# OSF wikiloader

As many people in academia, I use [OSF](https://osf.io/) for managing research projects. Their Wiki is useful for daily records, however, there is no interface option to download them all (for example, for backup purposes). Here, I introduce a short script that uses the OSF's API to download these records as HTML files.

This script will download all Wiki files in the working directory in the following format: "wiki_date_Ttime.html"

What do I need to know before using this script?
**1. The secret token.**
As of the date of uploading, you can create the token here: https://osf.io/settings/tokens/. Keep it secret and don't share it.

**2. The project's (or its component's) code**
On the OSF website, select the project of interest, and get the code from the address bar:  https://osf.io/project_code/

Enjoy!