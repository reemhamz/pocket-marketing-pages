from app import app
from flask_frozen import Freezer

freezer = Freezer(app)

app.config["FREEZER_DESTINATION_IGNORE"] = ["*.css", "*.js", "static/"]
app.config["FREEZER_DESTINATION"] = "./build"
app.config["FREEZER_STATIC_IGNORE"] = ["*.scss", "*.js", "static/"]
app.config["FREEZER_DEFAULT_MIMETYPE"] = "text/html"


@freezer.register_generator
def product_url_generator():
    # Frozen-Flask will follow URLs from the home page, but we can explicitly
    # define URLs to freeze here also.
    # yield "/about"  # found in index.html
    yield "/features"  # not linked in index.html


if __name__ == "__main__":
    freezer.freeze()
