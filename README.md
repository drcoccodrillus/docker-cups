# docker-cups

A dockerized version of CUPS

## Project description

This project was born to address a scenario where there are:

- one server running `cups` that manages printer queues
- one server running `foomatic-rip` that manages the rendering phase

If you need to setup a similar environment, you should also consider to run the `foomatic-rip` container https://github.com/drcoccodrillus/docker-cups-filters

***

## How to use it

Using this printer application is pretty simple. Just follow the steps below in order to make it working on your system.

### Clone the repository

`git clone git@github.com:drcoccodrillus/docker-cups.git`

### Copy PPDs and raster files (optional)

Put your PPDs here `cups/ppd/` and your raster files here `cups/filter/`

### Build the image

`docker-compose up --build -d`

### Connect and configure the printer

Connect your printer and run the following commands to configure a printer queue.

`docker exec cups lpinfo -v`

Take note of the URI of your USB printer (for example usb://Xerox/WorkCentre%20PE114%20Series?serial=3429108682......)

`docker exec cups lpadmin -p Xerox -v usb://Xerox/WorkCentre%20PE114%20Series?serial=3429108682......`

`docker exec cups lpadmin -p Xerox -o printer-is-shared=true`

`docker exec cups lpadmin -d Xerox`

`docker exec cups cupsenable Xerox`

`docker exec cups cupsaccept Xerox`

### Use your printer

`docker exec cups lp -d printer-name /test-files/test.pdf`

Following the example above, the printing command would be

`docker exec cups lp -d Xerox /test-files/test.pdf`
