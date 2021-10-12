## Flask pocket project

### Steps to get running:
    - clone repository "https://github.com/nathan-barrett/flask-webpack-project.git"
    - `cd flask-webpack-project`
    - `make run` to run the backend Flask app
    - `npm install` to install dependencies
    - `npm run watch` to build static files (js & scss) and run a local server

### Freeze the website
    - `make freeze` will run the Flask app and freeze all known and traversable URLs
      - See the `freeze.py` file to add URLs that aren't linked to from the home page.