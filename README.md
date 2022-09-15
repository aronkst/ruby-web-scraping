# Ruby Web Scraping

This is a web scraping developed using the Ruby programming language that has the possibility to fetch information from websites rendered via JavaScript.

Its execution is done using Docker, where Chromium it's installed inside the container, which can be used to render the page, or not, and use the traditional way that takes the HTML of the page with a simple request.

Searching for site information can be passed easily via `body`, in a POST request.

There is also a way to return all the HTML from a page by making a request to a specific path.

To know more details, there is the Makefile file with the commands necessary for its execution and example of how to use, including `curl` commands.

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
