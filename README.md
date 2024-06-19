# Ruby Web Scraping

This open-source project, developed in Ruby, is a versatile web scraping tool capable of fetching information from websites rendered with JavaScript.

The tool utilizes Docker to streamline its execution, with Chromium installed inside the container. This allows the tool to render JavaScript-heavy pages for accurate data extraction. Alternatively, it can perform traditional web scraping by directly fetching HTML content via simple HTTP requests.

Data extraction is flexible and user-friendly. You can pass the desired parameters in the body of a POST request to retrieve specific information from a site. Additionally, the tool provides an endpoint to return the entire HTML content of a webpage, enabling comprehensive data analysis.

To simplify usage, the project includes a Makefile with all necessary commands for execution. The Makefile also contains detailed instructions and examples, including `curl` commands for testing and demonstration purposes.

For more detailed instructions and examples, please refer to the Makefile in the project repository.

# JavaScript Render

If the site you are fetching the data from has JavaScript rendering, use the `javascript` parameter of the `body -> html` with the value of `true`.

# Options

There are 3 options for modifying the data, `transform`, `convert` and `exclude`. For more details and examples of how to use them, view the Makefile.

## transform

An array of array, where the first value of the array is the transform option followed by the values.

Example:

```
"transform": [
  ["split", "value", index],
  ["replace", "old", "new"],
  ["prepend", "value"],
  ["append", "value"],
]
```

`index` is an integer.

## convert

Convert the value to another type, eg string to integer.

Examples:

```
"convert": "string"
```
```
"convert": "integer"
```
```
"convert": "float"
```
```
"convert": "boolean"
```

## exclude

If the comparison is true, exclude the value. Must be given as an array of array.

Example:

```
"exclude": [
  ["null", value],
  ["==", value],
  ["!=", value],
  [">", value],
  [">=", value],
  ["<", value],
  ["<=", value],
  ["like", value],
  ["not", "null", value],
  ["not", "==", value],
  ["not", "!=", value],
  ["not", ">", value],
  ["not", ">=", value],
  ["not", "<", value],
  ["not", "<=", value],
  ["not", "like", value],
]
```

`value` must be the value to be compared can be a string, integer, float, boolean or null.

# How to use

Run the application:

```
make run
```

Start the application:

```
make start
```

Stop the application:

```
make stop
```

View logs for Docker containers:

```
make logs
```

Example of how to fetch information within a web page using a URL as input:

```
make test-find
```

Example of how to fetch information within a web page using a URL as input with `transform`:

```
make test-find-tranform
```

Example of how to fetch information within a web page using a URL as input with `convert`:

```
make test-find-convert
```

Example of how to fetch information within a web page using a URL as input with `exclude`:

```
make test-find-exclude
```

Example of how to fetch for information within a web page using HTML as input:

```
make test-find-html
```

Example of how to get all the HTML from a web page using a URL as input:

```
make test-html
```
