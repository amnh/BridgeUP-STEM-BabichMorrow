# GPS Data Collection Instructions

## Apps

### iPhone

For iPhone, download the free app "GPS Logger" (logo looks like US map). Go to the "Manager" button on the top left and select "Export current track data as CSV".

### Android

For Android, download the free app "GPS Logger" (red circular logo). Go to "Settings" and make sure that "Export Tracks in TXT" is turned on. Make sure that the "Trackpoints" button in the bottom right isn't red (or else the app will continuously record points along your route).

## Collect data

We want to collect data from at least three features: a point, a line, and a polygon. For the line and polygon, we will be using R to convert the points you collect into a line and polygon. To create these, you will need to decide how many points you take for each feature.

### iPhone

To start a session, press the plus icon on the top right of the home page -- your current location will be the first pin. Press the plus icon again anytime you want to log a point.

### Android

Select "Trackpoints" in the bottom right to add a new point. Everytime you do this, the app will prompt you for a description of the points -- note whether the point belongs to the point, line, or polygon feature.

## Download data

When you have collected all the points you want, you can email the .csv or .txt file to yourself so you can analyze it in R.

### iPhone

Select the mail app of your choice and email the .csv file to yourself. Download the data from your email and save it somewhere on your computer (but not in the folder for the repository -- save to desktop or another folder of your choice). Your data is already in .csv format, so it needs no further formatting.

### Android

Go to the "Tracklist" tab. Press and hold on the track you created and select "Share with ...". Select the mail app of your choice and email the .txt to yourself.

Your data will come in the form of a .txt file, so we need to convert that to a .csv. Open Excel and select Data > Get External Data > Import Text File and navigate to the data file you downloaded. Your data is delimited by commas. Import the data into the existing sheet and save it as a .csv file.

