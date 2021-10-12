from flask import Flask, render_template

app = Flask(__name__)

app.config["FREEZER_DESTINATION_IGNORE"] = ["*.css", "*.js", "static/"]
app.config["FREEZER_DESTINATION"] = "./build"
app.config["FREEZER_STATIC_IGNORE"] = ["*.scss", "*.js", "static/"]


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/about")
def about():
    return render_template("about.html")


@app.route("/features")
def features():
    return render_template("features.html")


if __name__ == "__main__":
    app.run(debug=True)
